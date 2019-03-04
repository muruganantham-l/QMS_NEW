use hrms40
go

if exists ( select 'y' from sysobjects where name = 'aml_ars_ssis_sp' and type = 'P')
    drop proc aml_ars_ssis_sp
go



 

CREATE proc aml_ars_ssis_sp
@guid              VARCHAR(500) = null 
,@filename          VARCHAR(500) = null 
as
begin
set nocount on
  declare @sysdate			date = getdate()
		,@first_date		date
		--,@guid				udd_guid = newid()
   
		IF @filename IS NOT NULL
          BEGIN
               INSERT file_names
                           ( file_name1
                            ,session_id
                           )
               SELECT RIGHT(@filename ,CHARINDEX('\' ,REVERSE(@filename))-1)
                     ,@guid
          END
		 
	
begin try

		create TABLE  #attendance  
		(
		  employee_code		nvarchar(100)
		  ,attendance_date		date 
		  ,attendance_in_time	datetime 
		  ,attendance_out_time	datetime  
		)


		create table #staging
		(
		employee_code				nvarchar(60)
		,attendance_date			date
		,attendance_date_time		datetime
		,io_flag					varchar(5)
		)		

		create table #source
		(
		master_ou				int
		,employee_code			nvarchar(100)
		,attendance_date		date
		,attendance_in_time		datetime
		,attendance_out_time	datetime
		,shift_code				nvarchar(30)
		,shift_start_date_time	datetime
		,shift_end_date_time	datetime
		,shift_total_time		int
		,regular_hours			int
		,late_coming_hours		int
		,early_going_hours		int
		,ot_hours				numeric(15,4)
		,guid					nvarchar(800)
		,exception_status		nvarchar(10)
		,shift_tolerance_limit  int
		,leave_type				nvarchar(100)
		,leave_unit				nvarchar(100)
		,dept_code				nvarchar(100)
		,wlcon					nvarchar(100)
		,gradeset_code			nvarchar(100)
		,grade					nvarchar(100)
		
		)
		
		insert #staging
		(
		employee_code			
		,attendance_date		
		,attendance_date_time	
		,io_flag				
		)
		select employee_code 
				,attendance_date
				,concat(a.attendance_date,space(1),a.attendance_time)
				,io_flag
		from  aml_ars_ssis_tbl a
		--WHERE a.session_id = @guid

		if @@rowcount = 0 and @filename is NULL
		BEGIN
		    insert aml_ars_ssis_tbl (attendance_date)
		    SELECT getdate()

		END
		
		insert #source
		(
		master_ou		
		,employee_code	
		,attendance_date
		,shift_code
		,guid
		)
/*		
		SELECT	gre.master_ou,gre.employee_code,gre.schedule_date,gre.shift_code, newid()
		FROM		tmscd_emp_gre_calendar  (NOLOCK)	 gre
		where exists (SELECT NULL
				    from	 tmscd_emp_rota_schd_map s (NOLOCK)
				    where  s.emp_code = gre.employee_code
				    AND    gre.schedule_date BETWEEN s.eff_from_date AND s.eff_to_date
				    and    EXISTS(select NULL
							   from   aml_ars_ssis_tbl (nolock) a
							   WHERE  a.employee_code = s.emp_code
							   and    a.attendance_date = gre.schedule_date--BETWEEN s.eff_from_date and s.eff_to_date
							   and    EXISTS (select 'x'
										   from	hrei_asgn_eff_auth_dtl asgn (NOLOCK)
										   where  asgn.employee_code = a.employee_code
										   and    asgn.org_work_locn_code  = 'CO01'
										   and    a.attendance_date between asgn.assignment_effective_from_date and isnull(assignment_effective_to_date,a.attendance_date)

									   )
				    and    s.map_yn = 'y'
								) 
				    )
*/
  		SELECT	gre.master_ou,gre.employee_code,gre.schedule_date,gre.shift_code, newid()
		FROM		tmscd_emp_gre_calendar  (NOLOCK)	 gre
		where exists (SELECT NULL
				    from	 tmscd_emp_rota_schd_map s (NOLOCK)
				    where  s.emp_code = gre.employee_code
				    AND    gre.schedule_date BETWEEN s.eff_from_date AND s.eff_to_date
				    and    s.map_yn = 'y'
				    and    EXISTS(select NULL
							   from   aml_ars_ssis_tbl (nolock) a
							   WHERE -- a.employee_code = s.emp_code
							       a.attendance_date = gre.schedule_date--BETWEEN s.eff_from_date and s.eff_to_date
							    
								)
					and    EXISTS (select 'x'
										   from	hrei_asgn_eff_auth_dtl asgn (NOLOCK)
										   where  asgn.employee_code = s.emp_code
										   and    asgn.org_work_locn_code  = 'CO01'
										   and    gre.schedule_date between asgn.assignment_effective_from_date and isnull(assignment_effective_to_date,gre.schedule_date)

									   )
				   			 
				    )
				    
				    
				     
		/*
		
		WHERE	EXISTS  (SELECT NULL
					    FROM	 #staging s
					    WHERE	 s.employee_code =	 gre.employee_code
					    AND	 s.attendance_date	 =	gre.schedule_date
					    )
	   
	   */
  
	     insert into #attendance

	   (
	    employee_code	
	    ,attendance_date	
	    ,attendance_in_time
	    ,attendance_out_time
	   )
	   SELECT  employee_code
			 ,attendance_date
			 ,min(attendance_in_date_time)
			 ,max(attendance_out_date_time)
	   FROM
		  (
		  select   s.employee_code
				,s.attendance_date		 'attendance_date'  
				,min(s.attendance_date_time) 'attendance_in_date_time'
				,max(s.attendance_date_time) 'attendance_out_date_time'
		  from	 #staging s
		  --join	 #shift_time st
			--	on   s.attendance_date_time BETWEEN st.shift_start_time AND st.shift_end_time
		  group by s.employee_code
				,s.attendance_date
	   
		  UNION ALL

		  SELECT t.employee_code
				,t.tmsht_date
				,t.tmsht_from_date
				,t.tmsht_to_date
		 from	 tmsht_hourly_based_dtl t (nolock)
		  WHERE   EXISTS (SELECT NULL
					   FROM	#staging st-- #shift_time st
					   WHERE  t.tmsht_date = st.attendance_date-- between st.shift_start_date and st.shift_end_date
					   and    t.employee_code = st.employee_code
					   )

		  )	 a 
	   GROUP BY a.employee_code,a.attendance_date
 
	   update  s
	  set	s.attendance_in_time   = a.attendance_in_time
			,s.attendance_out_time = a.attendance_out_time
	  from	#source s
	  join	#attendance a
			on  s.employee_code   = a.employee_code
			and a.attendance_date = s.attendance_date
 
		update #source
		set    regular_hours = (datediff(ss,attendance_in_time,isnull(attendance_out_time,attendance_in_time)) / 3600.00) * 60

		---Update the shift code for each employees

	   UPDATE s
	   SET		s.leave_type	=	l.a_leave_type_code
			 ,s.leave_unit	=	l.leave_auth_unit
	   from	  #source s		
	   join	  ladm_leave_appln_hdr	l	(nolock)
			 on s.attendance_date	BETWEEN	l.a_leave_from_date	AND	l.a_leave_to_date
			 AND	l.leave_appln_status	=	'AUTH'

/*	
		update	tmp
		set		shift_code = t.shift_code
		from	#source	tmp
		join	tmscd_emp_gre_calendar t
				on	tmp.master_ou	=	t.master_ou
				and tmp.employee_code	=	t.employee_code
				and	tmp.attendance_date	=	t.schedule_date
		
*/		
--Replace shift code into deviation shift code if available for particular employee

		update	tmp
		set		shift_code	=	deviate_shift_to
		from	#source	tmp
		join	tmscd_emp_gre_shift_devn_vw	d
				on	tmp.master_ou	=	d.master_ou
				and	tmp.employee_code	=	d.employee_code
				and	tmp.attendance_date	between	d.eff_from_date	and	d.eff_to_date

--Find shift total hours
		
		update	tmp
		set		shift_total_time = (datediff(ss,shift_start_time,shift_end_time) / 3600.00) * 60
				,shift_start_date_time = concat(attendance_date,space(1),shift_start_time)
				,shift_end_date_time = concat(attendance_date,space(1),shift_end_time)
				,shift_tolerance_limit = s.shift_tolerance_limit
		from	#source tmp
		join	tmgif_shift_vw s
				on	tmp.shift_code	=	s.shift_code
				and	s.language_code	=	1
				and	tmp.master_ou	=	s.master_ou

--Find OT hours			  
		
		update	#source
		set		ot_hours	=	regular_hours	-	shift_total_time
		where	regular_hours	>	shift_total_time


--Find late coming hours

		update	#source
		set		late_coming_hours = (datediff(ss,shift_start_date_time,attendance_in_time) / 3600.00) * 60
		where	attendance_in_time	>	dateadd(minute,shift_tolerance_limit,shift_start_date_time)
				 
--Find Early going hours

		update	#source
		set		early_going_hours	=	(datediff(ss,attendance_out_time,shift_end_date_time) / 3600.00) * 60
		where	shift_end_date_time	<	dateadd(minute,-shift_tolerance_limit,attendance_out_time) 



--Populate all the values into timesheet tables 
--added by muruganantham for weekoff apply error
		/*DELETE	  tmsht_hourly_based_dtl with (readpast)
		where isnull(shift,'off') = 'off'
		and tmsht_from_date is NULL
		AND tmsht_to_date	is null
		*/
		DELETE	tmsht_hourly_based_dtl with (readpast)
		WHERE	exists (
						SELECT	NULL
						from	#source	s
						WHERE	s.master_ou	=	master_ou
						AND		s.employee_code	=	employee_code
						AND		s.attendance_date	=	tmsht_date
						)

		insert	tmsht_hourly_based_dtl
			(prim_guid        , timestamp          , guid			    , employee_code    , assignment_no    , tmsht_date  
			,tmsht_from_date  , rounded_from_date  , tmsht_to_date      , rounded_to_date  , exception_status , timesheet_status   
			, master_ou	      , empng_ou		   ,empin_ou  ,tmprc_ou			, tmsch_ou         , createdby		  , createddate	 
			, clock_in_date   , clock_out_date	   ,regular_hours		, ot_hours		   , late_hours		  ,early_hours , shift
			,leave			  , leave_type		   , dept_code			, wlcon		,gradeset_code	,grade
			)
		SELECT
			s.guid			   ,0					,@guid				,s.employee_code		,1				,s.attendance_date
			,s.attendance_in_time, s.attendance_in_time  ,s.attendance_out_time,s.attendance_out_time 
			,  case when  (attendance_in_time is not null AND attendance_out_time is not null)				then 'EXOK'
					when  (attendance_in_time is not null AND attendance_out_time is  null)				then 'EXMO'
					when  (attendance_in_time is  null AND	  attendance_out_time is  NOT null)				then 'EXMI'
					when   shift_code <> 'off'  and attendance_in_time is null and  attendance_out_time is null	then 'EXAB'
					else 'EXOK'
					end
			
			,'AUTH'/*'PA'*/
			,s.master_ou		,s.master_ou			,s.master_ou			,s.master_ou				,s.master_ou			,'BE'				,@sysdate
			,s.attendance_in_time ,s.attendance_out_time ,s.regular_hours ,s.ot_hours			,s.late_coming_hours ,s.early_going_hours , s.shift_code
			,s.leave_unit		,s.leave_type	,s.dept_code	,s.wlcon	,s.gradeset_code	,	s.grade
		from	#source	as	s	

		/*
		--Remove blank attendance entries for separated employees      
	  ;with delete_cte as (
		select * from  tmsht_hourly_based_dtl t
		where exists(   select null
					 from   hrmv_emp_sep_hdr (nolock) h
					 where  h.separation_status = 'p'
					 and    h.employee_code = t.employee_code
					 and    t.tmsht_date > h.separation_date
					)
		  )

		delete delete_cte
		*/
--Populate all the values into timesheet tables 
		/*
 
		merge into dbo.tmsht_hourly_based_dtl as t
		using	#source	as	s
				on		t.master_ou			= s.master_ou
				and		t.employee_code		= s.employee_code
				and		t.tmsht_date		= s.attendance_date
		when	matched	then
				update	set	 tmsht_from_date    = isnull(s.attendance_in_time,t.tmsht_from_date)
							,rounded_from_date  = isnull(s.attendance_in_time,t.rounded_from_date)
							,clock_in_date		= isnull(s.attendance_in_time,t.clock_in_date)
							,t.tmsht_to_date    = isnull(s.attendance_out_time,t.tmsht_to_date)
							,t.rounded_to_date  = isnull(s.attendance_out_time,t.rounded_to_date)
							,t.clock_out_date   = isnull(s.attendance_out_time,t.clock_out_date)
							,t.regular_hours    = isnull(s.regular_hours,t.regular_hours)
							,t.ot_hours		= isnull(s.ot_hours,t.ot_hours)
							,t.late_hours		= isnull(s.late_coming_hours,t.late_hours)
							,t.early_hours		= isnull(s.early_going_hours,t.early_hours)
							,t.shift			= isnull(s.shift_code,t.shift)
							,t.exception_status = isnull(s.exception_status,t.exception_status)
		when	not	matched	then
				insert
				(prim_guid        , timestamp          , guid			    , employee_code    , assignment_no    , tmsht_date  
				,tmsht_from_date  , rounded_from_date  , tmsht_to_date      , rounded_to_date  , exception_status , timesheet_status   
				, master_ou	      , empng_ou		   ,empin_ou  ,tmprc_ou			, tmsch_ou         , createdby		  , createddate	 
				, clock_in_date   , clock_out_date	   ,regular_hours		, ot_hours		   , late_hours		  ,early_hours , shift
				)
				values
				(
				s.guid			   ,0					,@guid				,s.employee_code		,1				,s.attendance_date
				,s.attendance_in_time, s.attendance_in_time  ,s.attendance_out_time,s.attendance_out_time ,  exception_status		,'AUTH'/*'PA'*/
				,s.master_ou		,s.master_ou			,s.master_ou			,s.master_ou				,s.master_ou			,'BE'				,@sysdate
				,s.attendance_in_time ,s.attendance_out_time ,s.regular_hours ,s.ot_hours			,s.late_coming_hours ,s.early_going_hours , s.shift_code
				);
				*/
 		truncate table aml_ars_ssis_tbl

end try
begin catch
 
		insert aml_ars_processed_status
		(
			empcode			
			,attendance_date
			,attendance_time
			,io_flag		
			,file_name1								
			,date
			,status
			,err_id
			,err_desc
		)
		select 
			employee_code			
			,attendance_date
			,attendance_time
			,io_flag		
			,file_name1								
			,@sysdate
			,'F'
			,error_number()
			,error_message()
		from aml_ars_ssis_tbl

		truncate table aml_ars_ssis_tbl
end catch

set nocount off
end 






 

go

if exists ( select 'y' from sysobjects where name = 'aml_ars_ssis_sp' and type = 'P')
    grant exec on aml_ars_ssis_sp to public
go
