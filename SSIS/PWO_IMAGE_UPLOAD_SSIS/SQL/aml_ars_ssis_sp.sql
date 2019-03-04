use HRMS40
go

if exists ( select 'y' from sysobjects where name = 'aml_ars_ssis_sp' and type = 'P')
    drop proc aml_ars_ssis_sp
go



 

CREATE proc aml_ars_ssis_sp
@guid              VARCHAR(500) = null--'oxoa' 
,@filename          VARCHAR(500) = null--'E:\RESPLUS\AML_ARS\ars_sample_file2012201711_56.csv'

--null--'/test' 
as
begin
set nocount on
--manual time entry wont be deleted
  declare @sysdate			date = getdate()
		,@first_date		date
		--,@guid				udd_guid = newid()
	declare @weekoff_tmp	hrtext255
	declare @holiday_tmp	hrtext255
	declare @offday_tmp		hrtext255
	declare @wrkday_tmp		hrtext255
	 
		IF @filename IS NOT NULL
          BEGIN
               INSERT file_names
                           ( file_name1
                            ,session_id
                           )
               SELECT RIGHT(@filename ,CHARINDEX('\' ,REVERSE(@filename))-1)
                     ,@guid
          END
		 
/* commented by muruganantham to move it to live	
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
		,actual_work_hours		INT
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
		,prv_attn_date			date
		,nxt_attn_date			date
		,prv_shift_end_time		datetime
		,nxt_shift_start_time	datetime
		,prv_shift_code			nvarchar(30)
		,nxt_shift_code			nvarchar(30)
		,file_name1				nvarchar(1000)
		,attendance_date_time		DATETIME

		,hrothours			 NUMERIC(15,4)
		,day_type				 NVARCHAR(160)
		,rota_plan_code		 NVARCHAR(20)
		,rota_sch_cd			 NVARCHAR(20)
		,date_from			 date
		,date_to				 DATE
		,time_in				 time
		,time_out				 time
		,scheduled_from_date	 DATETIME
		,scheduled_to_date		 DATETIME
		,posn_code			 NVARCHAR(22)
	     ,job_code				 NVARCHAR(20)
		,scheduled_from_time		 time
		,scheduled_to_time		 time
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
		
    select	@weekoff_tmp =dbo.pmcmn_guidance_text_desc('HRMSGNMAS','TWO',1)
    select	@holiday_tmp =dbo.pmcmn_guidance_text_desc('HRMSTABTB','HOL',1)
    select	@offday_tmp =dbo.pmcmn_guidance_text_desc('HRMSTMSHT','OFFDY',1)
    select	@wrkday_tmp =dbo.pmcmn_guidance_text_desc('HRMSTMSHT','WKDAY',1)
	

		insert #source
		(
		master_ou		
		,employee_code	
		,attendance_date
		,shift_code
		,day_type
		,rota_plan_code
		,rota_sch_cd
--		,guid
--		,prv_attn_date
--		,nxt_attn_date
		
		)

  		SELECT	gre.master_ou,gre.employee_code,gre.schedule_date,gre.shift_code,
		case when holiday_qc = 'Y' then @holiday_tmp
			when weeklyoff_qc = 'Y' then @weekoff_tmp
			when offday_qc = 'Y' then @offday_tmp   
			else @wrkday_tmp end
			,rota_plan_code
			,rota_schedule_code
		--, newid()
		--,dateadd(dd,-1,gre.schedule_date) prv_attn_date
		--,dateadd(dd,1,gre.schedule_date) nxt_attn_date
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
		
		EXCEPT
		
		SELECT   tmp.master_ou,tmp.employee_code,tmp.tmsht_date,tmp.shift,type_of_duty,rota_plan_cd
		,rota_sch_cd

		from     tmsht_hourly_based_dtl tmp (NOLOCK)
		where    tmp.createdby <> 'BE'
		and      exists (select null
					   from aml_ars_ssis_tbl a
					   where a.attendance_date = tmp.tmsht_date
					   )

					 
		/*
		delete #source
		WHERE  attendance_date not in (SELECT DISTINCT a.attendance_date
								 from    aml_ars_ssis_tbl a (NOLOCK)
								 )

					    --DELETE from aml_ars_ssis_tbl where attendance_date <>  '2017-12-01'
					     
		 */
		  
				    
		update #source
		set    guid		  = NEWID()
			  ,prv_attn_date = dateadd(dd,-1,attendance_date)
			  ,nxt_attn_date = dateadd(dd,1,attendance_date)

  				    
		UPDATE	s	
		SET		gradeset_code	   = asgn.job_grade_set_code
				,grade		  = asgn.job_grade_code
				,wlcon		  = asgn.org_work_locn_code
				,dept_code	  = asgn.dept_code
				,posn_code       = asgn.position_code
				,job_code		= asgn.job_code
		FROM	#source s
		JOIN	hrei_asgn_eff_auth_dtl (NOLOCK)	asgn
				on s.employee_code	=	asgn.employee_code
				AND	s.attendance_date between asgn.assignment_effective_from_date and  isnull(asgn.assignment_effective_to_date,s.attendance_date)
				AND	asgn.assignment_auth_status	=	'a'
				AND	asgn.assignment_number	=	1
		
		
	     --if (select count('@') from aml_ars_ssis_tbl) > 2
		BEGIN

		
	   ---Update the previous shift code for each employees

			   update	tmp
			   set		prv_shift_code = t.shift_code
			   from	#source	tmp
			   join	tmscd_emp_gre_calendar t (NOLOCK)
					   on	tmp.master_ou	=	t.master_ou
					   and tmp.employee_code	=	t.employee_code
					   and	tmp.prv_attn_date	=	t.schedule_date
		
		
	   --Replace previous shift code into deviation shift code if available for particular employee

			   update	tmp
			   set		prv_shift_code	=	deviate_shift_to
			   from	#source	tmp
			   join	tmscd_emp_gre_shift_devn_vw	d (NOLOCK)
					   on	tmp.master_ou	=	d.master_ou
					   and	tmp.employee_code	=	d.employee_code
					   and	tmp.prv_attn_date	between	d.eff_from_date	and	d.eff_to_date

	   --Find previous shift end time
		
			   update	tmp
			   set		prv_shift_end_time = concat(prv_attn_date,space(1),shift_end_time)
			   from	#source tmp
			   join	tmgif_shift_vw s (NOLOCK)
					   on	tmp.prv_shift_code	=	s.shift_code
					   and	s.language_code	=	1
					   and	tmp.master_ou	=	s.master_ou

	   ---Update the next shift code for each employees

			   update	tmp
			   set		nxt_shift_code = t.shift_code
			   from	#source	tmp
			   join	tmscd_emp_gre_calendar t (NOLOCK)
					   on	tmp.master_ou	=	t.master_ou
					   and tmp.employee_code	=	t.employee_code
					   and	tmp.nxt_attn_date	=	t.schedule_date
		
		
	   --Replace next shift code into deviation shift code if available for particular employee

			   update	tmp
			   set		nxt_shift_code	=	deviate_shift_to
			   from	#source	tmp
			   join	tmscd_emp_gre_shift_devn_vw	d (NOLOCK)
					   on	tmp.master_ou	=	d.master_ou
					   and	tmp.employee_code	=	d.employee_code
					   and	tmp.nxt_attn_date	between	d.eff_from_date	and	d.eff_to_date

	   --Find next shift start time
		
			   update	tmp
			   set		nxt_shift_start_time = concat(nxt_attn_date,space(1),shift_start_time)
			   from	#source tmp
			   join	tmgif_shift_vw s (NOLOCK)
					   on	tmp.nxt_shift_code	=	s.shift_code
					   and	s.language_code	=	1
					   and	tmp.master_ou	=	s.master_ou

   
			   ---Update the shift code for each employees
			   
	   
	   --Replace shift code into deviation shift code if available for particular employee

			   update	tmp
			   set		shift_code	=	deviate_shift_to
			   from	#source	tmp
			   join	tmscd_emp_gre_shift_devn_vw	d (nolock)
					   on	tmp.master_ou	=	d.master_ou
					   and	tmp.employee_code	=	d.employee_code
					   and	tmp.attendance_date	between	d.eff_from_date	and	d.eff_to_date

	   --Find shift total hours
		
			   update	tmp
			   set		shift_total_time = (datediff(ss,shift_start_time,shift_end_time) / 3600.) * 60.
					   ,shift_start_date_time = concat(attendance_date,space(1),shift_start_time)
					  -- ,shift_end_date_time = concat(attendance_date,space(1),shift_end_time)
					   ,shift_tolerance_limit = s.shift_tolerance_limit
			   from	#source tmp
			   join	tmgif_shift_vw s (nolock)
					   on	tmp.shift_code	=	s.shift_code
					   and	s.language_code	=	1
					   and	tmp.master_ou	=	s.master_ou
			 
			   update tmp
			   set	   shift_end_date_time =	dateadd(hh,total_shift_hours ,shift_start_date_time)
			   from   #source tmp
			   join   (select  shift_code,sum(equivalent_hrs)  'total_shift_hours'
					 from  tmgif_shift_ses_con_dtls d (nolock)
					   group by shift_code) a
			   on	tmp.shift_code	=	a.shift_code

			   update sta
		set    sta.attendance_date = dateadd(dd,-1,cast(sta.attendance_date_time as date))
		from   #staging sta
		join   #source s
		on     sta.attendance_date_time  between-- s.shift_end_date_time 
		cast(s.nxt_shift_start_time as date)
		 --concat(s.attendance_date,space(1),'00:00:00.000')
		and isnull(s.nxt_shift_start_time,dateadd(dd,1,s.shift_start_date_time)) 
		--s.shift_end_date_time and isnull(s.nxt_shift_start_time,dateadd(dd,1,shift_start_date_time))
		--sta.attendance_date_time > s.shift_end_date_time and sta.attendance_date_time  < isnull(s.nxt_shift_start_time,dateadd(dd,1,s.shift_start_date_time))
		and    sta.employee_code = s.employee_code
		and    sta.io_flag = 'o'

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
							 FROM	#source st-- #shift_time st
							 WHERE  t.tmsht_date = st.attendance_date-- between st.shift_start_date and st.shift_end_date
							 and    t.employee_code = st.employee_code
							 )

				)	 a 
			 GROUP BY a.employee_code,a.attendance_date
 
			 update  s
			set	s.attendance_in_time   = a.attendance_in_time
			     ,s.date_from		    = a.attendance_in_time
				,s.time_in = cast(a.attendance_in_time as TIME)
			from	#source s
			join	#attendance a
				   on  s.employee_code   = a.employee_code
				   and s.attendance_date = a.attendance_date
				   --and  a.attendance_in_time between s.prv_shift_end_time and s.nxt_shift_start_time
			
			   update  s
			set	s.attendance_out_time = a.attendance_out_time
			     ,s.date_to		=   a.attendance_out_time
				,s.time_out = cast(a.attendance_out_time as TIME)
			from	#source s
			join	#attendance a
				   on  s.employee_code   = a.employee_code
    				   --and a.attendance_out_time between s.prv_shift_end_time and s.nxt_shift_start_time
				   and s.attendance_date = a.attendance_date
	   
			 update #source 
			 set    attendance_out_time = NULL
			 where  attendance_in_time = attendance_out_time
		 
			   update #source
			   set    regular_hours = (datediff(ss,attendance_in_time,isnull(attendance_out_time,attendance_in_time)) / 3600.) * 60.
			   
			   update #source
			   set    actual_work_hours = regular_hours


			 update #source
			 set    scheduled_from_date = shift_start_date_time
				   ,scheduled_to_date = shift_end_date_time
				   ,scheduled_from_time  = cast(shift_start_date_time as time)
				   ,scheduled_to_time = cast(shift_end_date_time as time)
	   --Find OT hours			  
		
			   update	#source
			   set	ot_hours	=	regular_hours	-	shift_total_time
			   where	regular_hours	>	shift_total_time


	   --Find late coming hours

			   update	#source
			   set		late_coming_hours = (datediff(ss,shift_start_date_time,attendance_in_time) / 3600.) * 60.
			   where	attendance_in_time	>	dateadd(minute,shift_tolerance_limit,shift_start_date_time)
				 
	   --Find Early going hours

			   update	#source
			   set		early_going_hours	=	(datediff(ss,attendance_out_time,shift_end_date_time) / 3600.) * 60.
			   where	shift_end_date_time	<	dateadd(minute,-shift_tolerance_limit,attendance_out_time) 


	   
	   --Populate all the values into timesheet tables 
	   /*	   delete s
			 from   #source  s
			 where  exists (SELECT NULL
						 from   tmsht_hourly_based_dtl tmp (NOLOCK)
						 where  tmp.employee_code = s.employee_code
						 and    tmp.tmsht_date = s.attendance_date
						 and    tmp.createdby <> 'be'
						 )
	   */				    
			 update #source
			 set    attendance_date_time = attendance_date
	   END

	   UPDATE s
	   SET		s.leave_type	=	l.a_leave_type_code
			 ,s.leave_unit	=	l.leave_auth_unit
	   from	  #source s		
	   join	  ladm_leave_appln_hdr	l	(nolock)
			 on s.attendance_date	BETWEEN	l.a_leave_from_date	AND	l.a_leave_to_date
			 and s.employee_code = l.employee_code
			 AND	l.leave_appln_status	=	'AUTH'
		
	   DELETE	tmp
	   from	tmsht_hourly_based_dtl tmp 
	   WHERE	exists (
					   SELECT NULL
					   from   #source a
					   where  a.employee_code = tmp.employee_code
					   and    a.attendance_date_time = tmp.tmsht_date
					   and    tmp.createdby = 'be'
					)
		  
	   
		insert	tmsht_hourly_based_dtl
			(prim_guid        , timestamp          , guid			    , employee_code    , assignment_no    , tmsht_date  
			,tmsht_from_date  , rounded_from_date  , tmsht_to_date      , rounded_to_date  , exception_status , timesheet_status   
			, master_ou	      , empng_ou		   ,empin_ou  ,tmprc_ou			, tmsch_ou         , createdby		  , createddate	 
			, clock_in_date   , clock_out_date	   ,regular_hours   ,actual_work_hours		, ot_hours		   , late_hours		  ,early_hours , shift
			,leave			  , leave_type		   , dept_code			, wlcon		,gradeset_code	,grade
			,type_of_duty
			,gnmas_ou	   ,payroll_ou	,pyset_ou	  ,pyelt_ou   ,tmgif_ou
			,date_from, date_to
			,time_in , time_out
			,scheduled_from_date,scheduled_to_date
			
			,posn_code	 , job
			,scheduled_from_time , scheduled_to_time
			,rota_plan_cd			,rota_sch_cd
	
			)
		SELECT
			s.guid			   ,0					,@guid				,s.employee_code		,1				,s.attendance_date
			,s.attendance_in_time, s.attendance_in_time  ,s.attendance_out_time,s.attendance_out_time 
			,  case when    (s.attendance_in_time is not null AND s.attendance_out_time is not null)				then 'EXOK'
					when  (s.attendance_in_time is not null AND s.attendance_out_time is  null)				then 'EXMO'
					when  (s.attendance_in_time is  null AND	  s.attendance_out_time is  NOT null)				then 'EXMI'
					when   s.shift_code <> 'off'  and s.attendance_in_time is null and  s.attendance_out_time is null	then 'EXAB'
					else 'EXOK'
					end
			
			,'AUTH'/*'PA'*/
			,s.master_ou		,s.master_ou			,s.master_ou			,s.master_ou				,s.master_ou			,'BE'				,@sysdate
			,s.attendance_in_time ,s.attendance_out_time ,s.regular_hours ,s.actual_work_hours ,s.ot_hours			,s.late_coming_hours ,abs(s.early_going_hours) , s.shift_code
			,s.leave_unit		,s.leave_type	,s.dept_code	,s.wlcon	,s.gradeset_code	,	s.grade
			,s.day_type
			,s.master_ou,s.master_ou,s.master_ou,s.master_ou,s.master_ou
			,date_from, date_to
			,time_in , time_out
			,scheduled_from_date,scheduled_to_date
			
			,posn_code
			,job_code	
			,scheduled_from_time , scheduled_to_time
			,rota_plan_code			,rota_sch_cd	
		from	#source	as	s	


		

		--SELECT * from #source where employee_code = '00022'

		
--SELECT * from #source		     	  
--SELECT * from tmsht_hourly_based_dtl where tmsht_date = '2017-11-30' 
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
 commented by muruganantham to move it to live*/
set nocount off
end 
go

if exists ( select 'y' from sysobjects where name = 'aml_ars_ssis_sp' and type = 'P')
    grant exec on aml_ars_ssis_sp to public
go
