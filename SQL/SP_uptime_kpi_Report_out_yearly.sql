  --exec SP_uptime_kpi_Report_out 'JOHOR' , 'JOHOR BAHRU' , 'ALL' , '2017-01-01','2017-03-31','ALL'

ALTER Procedure SP_uptime_kpi_Report_out_yearly
@statename varchar(100) = 'melaka',
@district varchar(200) = 'melaka tengah',
--@zone varchar(200),
@cliniccategory varchar(100) ='kesihatan',
@periodfrom Date = '2017-12-01' ,
@periodto date = '2017-12-31',
@ownership varchar(200) = 'EXISTING' -- WITH ENCRYPTION

as 


begin
 
set nocount on
select @periodfrom = concat(year(@periodfrom),'-',01,'-',01)
SELECT @periodto = concat(year(@periodfrom),'-',12,'-',31)

Declare @startdate Datetime
Declare @enddate datetime
Declare @yearstart datetime

Declare @state  varchar(100),
		@dis  varchar(100),
		@clinic varchar(100),
		@owner varchar(200)
		
Set @state		= @statename
Set @dis		= @district
set @clinic		= @cliniccategory
set @owner		= @ownership

Select @yearstart = DATEADD(yy, DATEDIFF(yy, 0, Isnull(@periodfrom,'2017-01-01')), 0) 

Select @startdate = isnull(@periodfrom ,'2017-09-01')
Select @enddate   = isnull(@periodto,convert(date,getdate()))



if @state in ('ALL','0')
begin
set @state = 'ALL'
end

if @dis in  ('ALL','0')
begin
set @dis = NULL
end


--if @zone in  ('ALL','0')
--begin
--set @zone = NULL
--end

if @clinic in  ('ALL','0')
begin
set @clinic = NULL
end

if @owner in  ('ALL','0')
begin
set @owner = '%'
end


----select @District,@cliniccategory,@statename

Declare @startdate_temp Datetime
Declare @enddate_temp Datetime

--Truncate table Tsd_Uptime_Detail_tab
--Truncate Table Tsd_Uptime_report_tab

Declare @guid varchar(100) =   newid()  -- @guid

select @startdate_temp = @startdate


WHILE ( @startdate_temp BETWEEN @startdate AND  @enddate )

BEGIN

select @enddate_temp = CONVERT(datetime,DATEADD(SS,-1,Dateadd(mm,1,@startdate_temp)))


insert into Tsd_Uptime_report_tab
(

GUID
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[ClinicType]
,[Ownership]
,[Month Name]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
 ,purchase_cost
)
select 
 @guid
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
,ast_mst_asset_type 
,CONVERT(DATETIME, @startdate_temp)
,CONVERT(DATETIME, @enddate_temp)
,COALESCE(Year(@yearstart) - year(ast_det.ast_det_purchase_date),16) Age
,ast_mst_asset_status
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
,ast_mst_asset_code
,''
,cus_mst.cus_mst_fob
,ast_det_varchar15
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,0 as 'Down Time'
,0 AS 'Total Downtime'
,0 AS 'Total Uptime'
,246 as 'Actual Working Days Year'
,0 as 'Actual Working Days Month'
,(Datediff(dd,@startdate_temp,@enddate_temp)+1) as 'No Days Month'
,0 as 'No Days Up Month'
,0 as 'Total No Days Up'
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,@startdate_temp,@enddate_temp) 'Holidays'
,0 as Firstlevel
,0 as Secondlevel
,'YES' as 'First Status'
,'YES'  as 'Second Status'
,0 
,0
,0
,ast_aud_status AS 'Period_Status'
 ,ast_det_asset_cost
FROM ast_mst (nolock)
	,ast_det (nolock)
	,cus_mst (nolock)
	,ast_aud (nolock)
WHERE (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (ast_mst.site_cd = ast_aud.site_cd)
	AND (ast_mst.RowID = ast_aud.mst_RowID)
	AND (ast_aud_asset_no = ast_mst_asset_no)
	AND ast_aud_status in ('ACT','PBR')
	AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst_ast_lvl =  @state )
	AND (ast_mst_asset_locn = @Dis)
	--AND ast_mst.ast_mst_perm_id = isnull(@zone,ast_mst.ast_mst_perm_id)
	AND ast_mst.ast_mst_asset_code = isnull(@clinic,ast_mst.ast_mst_asset_code)
	and ast_det_varchar15 not in ('Accessories')
	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and  Ownership_desc like @owner
										)
	--commented by muruganantham AND ast_mst.ast_mst_create_date < @yearstart	
	--commented by muruganantham AND (@yearstart-1)	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@yearstart))
	--added by murugan AND @yearstart	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@yearstart))
	AND @periodfrom	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@periodto))

--	if SUSER_NAME() = 'tommsadm'
--	begin
--	-- SP_uptime_kpi_Report_out
----	select ast_mst_create_date 'test',* from  ast_mst order by ast_mst_create_date where  ast_mst_create_date < '2015-01-01'
--	--select * from ast_aud (nolock) where '2014-12-31 00:00:00.000' between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,'2015-01-01 00:00:00.000'))
--	-- select @yearstart '@yearstart',(@yearstart-1) '(@yearstart-1)'

--	 select ast_aud_start_date,ast_aud_end_date

--	 FROM ast_mst (nolock)
--	,ast_det (nolock)
--	,cus_mst (nolock)
--	,ast_aud (nolock)
--WHERE (ast_mst.site_cd = ast_det.site_cd)
--	AND (ast_mst.RowID = ast_det.mst_RowID)
--	AND (ast_mst.site_cd = ast_aud.site_cd)
--	AND (ast_mst.RowID = ast_aud.mst_RowID)
--	AND (ast_aud_asset_no = ast_mst_asset_no)
--	AND ast_aud_status in ('ACT','PBR')
--	AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
--	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
--	AND (ast_mst_ast_lvl =  @state )
--	AND (ast_mst_asset_locn = @Dis)
--	--AND ast_mst.ast_mst_perm_id = isnull(@zone,ast_mst.ast_mst_perm_id)
--	AND ast_mst.ast_mst_asset_code = isnull(@clinic,ast_mst.ast_mst_asset_code)
--	and ast_det_varchar15 not in ('Accessories')
--	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
--										where Ownership_desc not in ('Accessories') 
--										and  Ownership_desc like @owner
--										)
--	-- AND ast_mst.ast_mst_create_date < @yearstart	
--	--AND (@yearstart-1)	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@yearstart))
--	AND @periodfrom	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@periodto))
--	order by ast_aud_start_date,ast_aud_end_date

--	  select @yearstart
--	end
--murugan
/*

insert into Tsd_Uptime_Detail_tab
(GUID
,[WO Number]
,[WR Number]
,[Assign To]
,[Employee Name]
,[WO Date && Time]
,[Wr Datetime]
,[Response Date && Time]
,[Completion Date && Time]
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[ClinicType]
,[WO Status]
,[Ownership]
,[WR Status]
,[WR Month]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
)


select 
 @guid
,wko_mst.wko_mst_wo_no
,wkr_mst.wkr_mst_wr_no
,wko_det_assign_to
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
,wko_det.wko_det_exc_date AS Response_Date
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
,ast_mst_asset_type 
,CONVERT(DATETIME, @startdate_temp)
,CONVERT(DATETIME, @enddate_temp)
,COALESCE(Year(@enddate_temp) - year(ast_det.ast_det_purchase_date),16) Age
,ast_mst_asset_status
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
,ast_mst_asset_code
,cus_mst.cus_mst_fob
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,'0' AS 'Total Downtime'
,0 AS 'Total Uptime'
,246 as 'Actual Working Days Year'
,0 as 'Actual Working Days Month'
,(Datediff(dd,@startdate_temp,@enddate_temp)+1) as 'No Days Month'
,0 as 'No Days Up Month'
,0 as 'Total No Days Up'
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,@startdate_temp,@enddate_temp) 'Holidays'
,0 as Firstlevel
,0 as Secondlevel
,'' as 'First Status'
,''  as 'Second Status'
,0 
,0
,0
,'Current ' AS 'Period_Status'
FROM wkr_mst (nolock)
	,wkr_det (nolock)
	,wko_mst (nolock)
	,wko_det (nolock)
	,ast_mst (nolock)
	,ast_det (nolock)
	,cus_mst (nolock)
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	AND ast_mst_asset_longdesc not in ('Dental Delivery Units','Chairs, Examination/Treatment, Dentistry','Chairs, Examination/Treatment, Dentistry, Specialist')
	AND ast_mst.ast_mst_ast_lvl = @statename
	AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	AND ast_mst.ast_mst_asset_code = isnull(@cliniccategory,ast_mst.ast_mst_asset_code)
	and ast_det_varchar15 not in ('Accessories')
	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and  Ownership_desc like @ownership 
										)
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
	AND ast_mst.ast_mst_create_date < @yearstart
	

union all

select 
 @guid
,wko_mst.wko_mst_wo_no
,wkr_mst.wkr_mst_wr_no
,wko_det_assign_to
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
,wko_det.wko_det_exc_date AS Response_Date
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
,ast_mst_asset_type 
,CONVERT(DATETIME, @startdate_temp)
,CONVERT(DATETIME, @enddate_temp)
,COALESCE(Year(@enddate_temp) - year(ast_det.ast_det_purchase_date),16) Age
,ast_mst_asset_status
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
,ast_mst_asset_code
,cus_mst.cus_mst_fob
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,'0' AS 'Total Downtime'
,0 AS 'Total Uptime'
,246 as 'Actual Working Days Year'
,0 as 'Actual Working Days Month'
,(Datediff(dd,@startdate_temp,@enddate_temp)+1) as 'No Days Month'
,0 as 'No Days Up Month'
,0 as 'Total No Days Up'
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,@startdate_temp,@enddate_temp) 'Holidays'
,0 as Firstlevel
,0 as Secondlevel
,'' as 'First Status'
,''  as 'Second Status'
,0 
,0
,0
,'Previous ' AS 'Period_Status'
FROM wkr_mst (nolock)
	,wkr_det (nolock)
	,wko_mst (nolock)
	,wko_det (nolock)
	,ast_mst (nolock)
	,ast_det (nolock)
	,cus_mst (nolock)
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	AND ast_mst.ast_mst_ast_lvl = @statename
	AND ast_mst_asset_longdesc not in ('Dental Delivery Units','Chairs, Examination/Treatment, Dentistry','Chairs, Examination/Treatment, Dentistry, Specialist')
	--AND ast_mst.ast_mst_perm_id = isnull(@zone,ast_mst.ast_mst_perm_id)
	AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	AND ast_mst.ast_mst_asset_code = isnull(@cliniccategory,ast_mst.ast_mst_asset_code)
	AND ast_det_varchar15 not in ('Accessories')
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and Ownership_desc like @ownership )
	AND ast_mst.ast_mst_create_date <= @yearstart
	AND (wkr_mst.wkr_mst_org_date < @startdate_temp)
	AND (
		(
			wko_mst.wko_mst_status NOT IN (
				'CLO'
				,'CMP'
				)
			)
		OR (
			wko_det.wko_det_cmpl_date > @startdate_temp
			AND wko_det.wko_det_cmpl_date < @enddate_temp
			)
		OR (wko_det.wko_det_cmpl_date > @enddate_temp)
		)
*/


insert into workorder_master
Select  
wko_mst.site_cd 
,wko_mst.wko_mst_wo_no
,wkr_mst.wkr_mst_wr_no
,ast_mst_asset_no
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
,wko_det.wko_det_exc_date AS Response_Date
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst_ast_lvl 
,ast_mst_asset_locn
,ast_det_varchar15
,ast_det_cus_code
,wko_mst_status
,wkr_mst_wr_status
,@Guid
from 
wkr_mst (nolock)
,wkr_det (nolock)
,wko_mst (nolock)
,wko_det (nolock)
,ast_mst (nolock)
,ast_det (nolock)
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
AND (wkr_mst.RowID = wkr_det.mst_RowID)
AND (wko_mst.site_cd = wko_det.site_cd)
AND (wko_mst.RowID = wko_det.mst_RowID)
AND (ast_mst.site_cd = ast_det.site_cd)
AND (ast_mst.RowID = ast_det.mst_RowID)
AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
AND (wkr_mst.wkr_mst_wr_status <> 'D') 
AND (ast_mst.site_cd = 'QMS')
AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
AND ast_det_varchar15 not in ('Accessories')
AND ast_mst.ast_mst_ast_lvl = @state
AND ast_mst_asset_locn = @Dis
AND ast_mst.ast_mst_asset_code = isnull(@clinic,ast_mst.ast_mst_asset_code)
AND ast_mst.ast_mst_create_date < @yearstart
AND ( (wkr_mst_org_date between @startdate_temp and @enddate_temp) 
			or 
			(wkr_mst_org_date <  @startdate_temp
				and 
					(wko_det_cmpl_date >= @enddate_temp or wko_det_cmpl_date between @startdate_temp and  @enddate_temp) or wko_mst.wko_mst_status NOT IN ('CLO','CMP')))


insert into Tsd_Uptime_Detail_tab (GUID,[Asset_no],[Wr Datetime],[Completion Date && Time], MonthStart, MonthEnd, State , District, Ownership, clinic_code, [WR Status] ,[WO Status],[WR Month])
SELECT  @Guid,
		s1.ast_mst_asset_no,
		s1.[Wr Datetime], 
       MIN(t1.[Completion Date]) AS EndDate ,
	   @startdate_temp,
	   @enddate_temp,
	   s1.ast_mst_ast_lvl ,
	   s1.ast_mst_asset_locn,
	   s1.ast_det_varchar15,
	   s1.ast_det_cus_code,
	   s1.wkr_mst_wr_status,
	   s1.wko_mst_status
	   ,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
FROM   workorder_master (nolock) s1 
INNER JOIN workorder_master (nolock) t1 
ON s1.ast_mst_asset_no = t1.ast_mst_asset_no 
and  s1.[Wr Datetime] <= t1.[Completion Date]
  AND NOT EXISTS(SELECT * FROM workorder_master (nolock) t2 
WHERE t1.ast_mst_asset_no = t2.ast_mst_asset_no and t1.[Completion Date] >= t2.[Wr Datetime] AND t1.[Completion Date] < t2.[Completion Date]
) 
WHERE NOT EXISTS(SELECT * FROM workorder_master (nolock) s2 
WHERE s1.ast_mst_asset_no = s2.ast_mst_asset_no 
and s1.[Wr Datetime] > s2.[Wr Datetime] AND s1.[Wr Datetime] <= s2.[Completion Date]) 
GROUP BY s1.ast_mst_asset_no, s1.[Wr Datetime] ,s1.ast_mst_ast_lvl ,
	   s1.ast_mst_asset_locn,
	   s1.ast_det_varchar15,
	   s1.ast_det_cus_code,
	   s1.wkr_mst_wr_status,
	   s1.wko_mst_status
ORDER BY s1.ast_mst_asset_no,s1.[Wr Datetime] 

Delete from workorder_master
where Guid = @Guid

SELECT @startdate_temp = CONVERT(datetime,DATEADD(mm,1,CONVERT(DATETIME,@startdate_temp)))

end

update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [MonthStart],  isnull([Completion Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and [Wr Datetime] <= [MonthStart]
and  [Guid] = @guid


update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [MonthStart], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd 
and [Wr Datetime] <= [MonthStart]
and  [Guid] = @guid

update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], isnull([Completion Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and [Wr Datetime] between [MonthStart] and MonthEnd
and  [Guid] = @guid

update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and [Wr Datetime] between [MonthStart] and MonthEnd
and  [Guid] = @guid


Update tab 
SET [Actual Downtime] = Isnull(Total,0.0) , [Total Downtime] = Isnull(Total,0.0) 
from 
	Tsd_Uptime_report_tab tab(nolock),
	(select 
	[Guid],[WR Month],[Asset_no],[BE_Category],[BeGroup],[MonthStart],[MonthEnd],[AgeofBE],[clinic_code],[clinic_name],[clinic_category]
	,[No Days Month], SUM([Actual Downtime]) Total ,COUNT(*) Count1
	from Tsd_Uptime_Detail_tab (nolock)
	where [Guid] = @guid
	group by [Guid],[WR Month],[Asset_no],[BE_Category],[BeGroup],[MonthStart],[MonthEnd],[AgeofBE],[clinic_code],[clinic_name],[clinic_category],[No Days Month]
	) Det
WHERE tab.[Guid] = @guid
and tab.[Asset_no] = Det.[Asset_no]
and [WR Month] = [Month Name]


Update t1
set [Total Downtime] = (select Sum([Actual Downtime])
	from Tsd_Uptime_report_tab t2(nolock)
	Where t1.[Guid]= t2.[GUID] 
	And t1.[Asset_no] = t2.[Asset_no]
	AND t1.[MonthStart] >= t2.[MonthStart] 
	) 
	from 
	Tsd_Uptime_report_tab t1 (nolock)
	WHERE t1.[Guid] = @guid
	
/*
/*Calculate No of holidays*/

update Tsd_Uptime_Detail_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], isnull([Completion Date && Time],MonthEnd)) 
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid


update Tsd_Uptime_Detail_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], MonthEnd)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_Uptime_Detail_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[Wr Datetime], MonthEnd)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Current'
and  [Guid] = @guid

*/



update tab
set  Period_Status = ast_aud_status
from Tsd_Uptime_report_tab tab (nolock),
	ast_mst (nolock),
	ast_aud (nolock)
where  [Guid] = @guid
and ast_mst.RowID = ast_aud.mst_RowID
AND ast_mst.site_cd = ast_aud.site_cd
AND ast_mst.site_cd = 'QMS'
AND ast_mst.ast_mst_asset_no = Asset_no
and Convert(date,MonthEnd) between ast_aud_start_date and Isnull(ast_aud_end_date,MonthEnd)


update tab
set  [First Level Days]= Firstlevel  , [Second Level Days] = Secondlevel
from Tsd_Uptime_report_tab tab (nolock),
	Uptime_KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and mst.BeGroup = tab.BeGroup
and AgeofBE between minage and maxage


Update Tsd_Uptime_report_tab
set [Total Uptime] = [Actual Working Days Year] - [Total Downtime] , [Actual Working Days Month] = [No Days Month],[No Days Up Month] = [No Days Month]-[Actual Downtime]
where [Guid] = @guid

Update Tsd_Uptime_report_tab
set [First Level Status] = 'NO'
where [Guid] = @guid
and [Total Uptime] < [First Level Days]

Update Tsd_Uptime_report_tab
set [Second Level Status] = 'NO'
where [Guid] = @guid
and [Total Uptime] < [Second Level Days]
 

update Tsd_Uptime_report_tab
set Total_penalty_cost = 0.0 , Remarks = 'BE Age > 15 Years'
Where  [Guid] = @guid
and AgeofBE  >=16
 
 
Select 
[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[ClinicType]
,[Ownership]
--,[Month Name] commented by muruganantham
,'Jan - Dec' [Month Name]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,purchase_cost
,delayed_response_time_penalty
,delayed_repair_time_penalty
,delayed_ppm_time_penalty_month
,less_than_1_uptime_grnt
,less_than_2_uptime_grnt

 from Tsd_Uptime_report_tab (nolock) t
 join uptime_kpi_penalt_mst u (NOLOCK)
 on t.purchase_cost BETWEEN u.purchase_val_from and isnull(u.purchase_value_to,t.purchase_cost)

where [Guid] = @guid 

Delete from Tsd_Uptime_Detail_tab
where [Guid] = @guid


Delete from Tsd_Uptime_report_tab
where [Guid] = @guid

set nocount off

end






