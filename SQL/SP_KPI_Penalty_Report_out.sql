 --exec SP_KPI_Penalty_Report_out 'PERAK' , 'ALL' , 'NORTHERN' , 'ALL' , '2017-07-01','2017-09-30','ALL'

alter Procedure SP_KPI_Penalty_Report_out
@statename varchar(100) = 'PERAK',--'JOHOR',
@district varchar(200) = 'KERIAN',-- 'all',--'JOHOR BAHRU',
@zone varchar(200) =  'NORTHERN', -- 'SOUTHERN',
@reporttype varchar(100) = 'KESIHATAN',
@periodfrom Date = '2018-07-01', -- '2018-04-01',
@periodto date = '2018-09-30', --'2018-04-30',
@ownership varchar(200) = '%' --WITH ENCRYPTION

as 

begin

set nocount on

Declare @startdate Datetime
Declare @enddate datetime
declare @month_start_date datetime = isnull(@periodto,convert(date,getdate()))

select @month_start_date = concat(year(@month_start_date),'-',month(@month_start_date),'-',01)

Select @startdate = isnull(@periodfrom ,'2017-09-01')
Select @enddate   = isnull(@periodto,convert(date,getdate()))


if @statename in ('ALL','0')
begin
set @statename = 'ALL'
end

if @District in  ('ALL','0')
begin
set @District = NULL
end


if @zone in  ('ALL','0')
begin
set @zone = '%'
end

if @reporttype in  ('ALL','0')
begin
set @reporttype = NULL
end

if @ownership in  ('ALL','0')
begin
set @ownership = '%'
end

----select @District,@reporttype,@statename

--select
-- @statename    statename 
--,@district     district  
--,@zone  	   zone  
--,@reporttype   reporttype
--,@periodfrom   periodfrom
--,@periodto 	   periodto 
--,@ownership    ownership 
--INTO test

Declare @startdate_temp Datetime
Declare @enddate_temp Datetime

--Truncate table  Tsd_penalty_report_tab


Declare @guid varchar(100) =   newid()  -- @guid

--INSERT INTO PENALTY_REPORT_DATA_OUT

select @startdate_temp = @startdate


WHILE ( @startdate_temp BETWEEN @startdate AND  @enddate )

BEGIN

select @enddate_temp = CONVERT(datetime,DATEADD(SS,-1,Dateadd(mm,1,@startdate_temp)))

--declare @wo_month VARCHAR(50) = convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
--right(Convert(varchar,year(@startdate_temp)),2)+'-'+Right('00'+convert(varchar,month(@startdate_temp)),2)+'-'+Left(Datename(mm,@startdate_temp),3)
--alter table Tsd_penalty_report_tab
--add ast_rowid INT 


insert into Tsd_penalty_report_tab
(GUID
,[WR Number]
,[Wr Datetime]
,[Zone]
,[State]
,[Circle]
,[District]
,[WR Status]
,[WR Month]
,[Response KPI]
,[Repair KPI]
,[Final Response KPI]
,[Final Repair KPI]----
,[Final Response KPI ExclHoli]--
,[Final Repair KPI ExclHoli]--
,[Asset_no]
,[BE_Category]--
--,
,[BeGroup] 
,[MonthStart]
,[MonthEnd]--
--,
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
--,
--,
,[clinic_category]
--,
--,[MaintananceRev]
,ast_rowid
,process_flag
)


select 
 @guid
--,wko_mst.wko_mst_wo_no [WO Number]
,wkr_mst.wkr_mst_wr_no [WR Number]
--,wko_det_assign_to [Assign To]
--,wko_det_assign_to [Employee Name]
--,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
--,wko_det.wko_det_exc_date AS [Response Date && Time]
--,wko_det.wko_det_cmpl_date AS [Completion Date && Time]
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
--,ast_mst.ast_mst_asset_locn AS District
,wkr_mst_assetlocn AS District
--,wko_mst.wko_mst_status [WO Status]
--,wko_det_varchar8 [Ownership]
,wkr_mst_wr_status [WR Status]
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2) [WR Month]
,'0' AS 'Response KPI' 
,'0' AS 'Repair KPI'
--,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date), isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) --[Actual Response KPI]
--,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date), isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)--[Actual Repair KPI]
,0 [Final Response KPI]
,0 [Final Repair KPI]
--,''
--,''
--,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date),isnull(wko_det.wko_det_exc_date,@enddate_temp)) [Holidays&Weekends]
--,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date),isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) [Repair Holidays&Weekends]
,0 [Final Response KPI ExclHoli]
,0 [Final Repair KPI ExclHoli]
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no [Asset_no]
,ast_mst.ast_mst_asset_longdesc AS [BE_Category]
--,ast_det.ast_det_asset_cost [Asset_Cost]
	,ast_mst_asset_type  [BeGroup]
	--,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as [ProblemReported]
	--,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as [Actiontaken]
	, @startdate_temp [MonthStart]
	, @enddate_temp [MonthEnd]
	--,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16)) [AgeofBE]
	,0 [KPI_Remains]
	,0 [penalty_cost]
		,0 [Repair_penalty_cost]
		,0 [Response_penalty_cost]
		,0 [Total_penalty_cost]
		,/*'Current '*/ NULL AS [Period_Status]
		--,ast_det_cus_code [clinic_code]
		--,Replace(Replace(ast_det_note1,char(10),''),char(13),0) [clinic_name]
		,ast_mst_asset_code [clinic_category]
		--,cus_mst.cus_mst_fob [ClinicType]
		--,ast_det_numeric8 [MaintananceRev]
		,ast_mst.RowID ast_rowid
		,'N' process_flag
FROM wkr_mst (nolock)
	,wkr_det (nolock)
	--wko_mst   (nolock)
	--,wko_det   (nolock)
	,ast_mst (nolock)
	--,ast_det (nolock)
	--,cus_mst (nolock)
WHERE --(wkr_mst.site_cd = wkr_det.site_cd)
	   (wkr_mst.RowID = wkr_det.mst_RowID)
--	AND (wko_mst.site_cd = wko_det.site_cd)
	 --(wko_mst.RowID = d.mst_RowID)
	--AND (ast_mst.site_cd = ast_det.site_cd)
	--AND (ast_mst.RowID = ast_det.mst_RowID)
	--AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	--AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	and (ast_mst.ast_mst_asset_no = wkr_mst.wkr_mst_assetno)
	--AND (cus_mst.cus_mst_smallbu = '0')
	--AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (wkr_mst.wkr_mst_wr_status in ('A','W'))
	--AND (ast_mst.site_cd = 'QMS')
	AND (ast_mst.ast_mst_ast_lvl =  @statename or @statename is null	)
	AND (ast_mst.ast_mst_perm_id = @zone or @zone is null 				)
--	AND (ast_mst.ast_mst_asset_locn = @District or @District is null 	)--commented by murugan
 and (wkr_mst_assetlocn = @District or @District is null 	) --added by murugan
 
	AND (ast_mst.ast_mst_asset_code = @reporttype or @reporttype is null) 
	and wkr_det_reject_flag = 0
	--AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership ) -- not added by murugan yet
	--murugan AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
 	--AND wkr_mst.wkr_mst_org_date <= @enddate_temp
	 
	--dubug
	/*
 union ALL

 select 
 @guid
--,wko_mst.wko_mst_wo_no [WO Number]
,wkr_mst.wkr_mst_wr_no [WR Number]
--,wko_det_assign_to [Assign To]
--,wko_det_assign_to [Employee Name]
--,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
--,wko_det.wko_det_exc_date AS [Response Date && Time]
--,wko_det.wko_det_cmpl_date AS [Completion Date && Time]
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
--,ast_mst.ast_mst_asset_locn AS District
,wkr_mst_assetlocn AS District
--,wko_mst.wko_mst_status [WO Status]
--,wko_det_varchar8 [Ownership]
,wkr_mst_wr_status [WR Status]
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2) [WR Month]
,'0' AS 'Response KPI' 
,'0' AS 'Repair KPI'
--,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date), isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) --[Actual Response KPI]
--,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date), isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)--[Actual Repair KPI]
,0 [Final Response KPI]
,0 [Final Repair KPI]
--,''
--,''
--,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date),isnull(wko_det.wko_det_exc_date,@enddate_temp)) [Holidays&Weekends]
--,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,IIF(@month_start_date > wkr_mst.wkr_mst_org_date,@month_start_date,wkr_mst.wkr_mst_org_date),isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) [Repair Holidays&Weekends]
,0 [Final Response KPI ExclHoli]
,0 [Final Repair KPI ExclHoli]
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no [Asset_no]
,ast_mst.ast_mst_asset_longdesc AS [BE_Category]
--,ast_det.ast_det_asset_cost [Asset_Cost]
	,ast_mst_asset_type  [BeGroup]
	--,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as [ProblemReported]
	--,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as [Actiontaken]
	, @startdate_temp [MonthStart]
	, @enddate_temp [MonthEnd]
	--,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16)) [AgeofBE]
	,0 [KPI_Remains]
	,0 [penalty_cost]
		,0 [Repair_penalty_cost]
		,0 [Response_penalty_cost]
		,0 [Total_penalty_cost]
		,/*'Previous'*/null AS [Period_Status]
		--,ast_det_cus_code [clinic_code]
		--,Replace(Replace(ast_det_note1,char(10),''),char(13),0) [clinic_name]
		,ast_mst_asset_code [clinic_category]
		--,cus_mst.cus_mst_fob [ClinicType]
		--,ast_det_numeric8 [MaintananceRev]
		,ast_mst.RowID ast_rowid
FROM wkr_mst (nolock)
	--,wkr_det (nolock)
	--wko_mst   (nolock)
	--,wko_det   (nolock)
	,ast_mst (nolock)
	--,ast_det (nolock)
	--,cus_mst (nolock)
WHERE --(wkr_mst.site_cd = wkr_det.site_cd)
	-- AND (wkr_mst.RowID = wkr_det.mst_RowID)
--	AND (wko_mst.site_cd = wko_det.site_cd)
	 --(wko_mst.RowID = d.mst_RowID)
	--AND (ast_mst.site_cd = ast_det.site_cd)
	--AND (ast_mst.RowID = ast_det.mst_RowID)
	--AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	--AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	 (ast_mst.ast_mst_asset_no = wkr_mst.wkr_mst_assetno)
	--AND (cus_mst.cus_mst_smallbu = '0')
	--AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (wkr_mst.wkr_mst_wr_status in ('A','W'))
	--AND (ast_mst.site_cd = 'QMS')
	AND (ast_mst.ast_mst_ast_lvl =  @statename or @statename is null	)
	AND (ast_mst.ast_mst_perm_id = @zone or @zone is null 				)
--	AND (ast_mst.ast_mst_asset_locn = @District or @District is null 	)--commented by murugan
 and (wkr_mst_assetlocn = @District or @District is null 	) --added by murugan
 
	AND (ast_mst.ast_mst_asset_code = @reporttype or @reporttype is null) 
	--AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership ) -- not added by murugan yet
	--AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
 	--AND wkr_mst.wkr_mst_org_date <= @enddate_temp
	AND (wkr_mst.wkr_mst_org_date < @startdate_temp)
	--AND (
	--	(
	--		wko_mst_status NOT IN (
	--			'CLO'
	--			,'CMP'
	--			)
	--		)
	--	OR (
	--		wko_det.wko_det_cmpl_date > @startdate_temp
	--		AND wko_det.wko_det_cmpl_date < @enddate_temp
	--		)
	--	OR (wko_det.wko_det_cmpl_date > @enddate_temp)
	--	) 

	*/

update t
set
 [WO Number]					=	m.wko_mst_wo_no
,[Assign To]					=	d.wko_det_assign_to
,[Employee Name]		=	d.wko_det_assign_to
,[WO Date && Time]	=	m.wko_mst_org_date
,[Response Date && Time] = d.wko_det_exc_date
,[Completion Date && Time] = d.wko_det_cmpl_date
,[WO Status] = m.wko_mst_status
,[ProblemReported] = m.wko_mst_descs
,[Actiontaken] = d.wko_det_corr_action

from Tsd_penalty_report_tab t 
join wko_det d (NOLOCK)
on t.[WR Number] = d.wko_det_wr_no
JOIN wko_mst m (NOLOCK)
on m.RowID = d.mst_RowID
 

update t
set  [Period_Status] = 'Current'
from Tsd_penalty_report_tab t
where [Wr Datetime] between  @startdate_temp and @enddate_temp
 

update t
set  [Period_Status] = 'Previous'
from Tsd_penalty_report_tab t
	where (
		(
			[WO Status] NOT IN (
				'CLO'
				,'CMP'
				)
			)
		OR (
			[Completion Date && Time] > @startdate_temp
			AND [Completion Date && Time] < @enddate_temp
			)
		OR ([Completion Date && Time]> @enddate_temp)
		) 
and [Period_Status] is NULL		
  

delete Tsd_penalty_report_tab where [Period_Status] is NULL

--alter table Tsd_penalty_report_tab
--add process_flag varchar(10) default 'N'
 
--for current report month work order
update t
set  
  holiday_from_date			= t.[Wr Datetime]
 ,holiday_response_to_date = t.[Response Date && Time]
 ,holiday_repair_to_date = t.[Completion Date && Time]
from Tsd_penalty_report_tab t
--where t.[Wr Datetime] BETWEEN @month_start_date and @enddate_temp
  WHERE process_flag = 'N'

--update t
--set  t.holiday_from_date = @month_start_date
--,t.holiday_response_to_date = @enddate_temp
--,t.holiday_repair_to_date = @enddate_temp
--from Tsd_penalty_report_tab t
--where t.holiday_from_date is NULL
update t
SET
t.holiday_response_to_date = @enddate_temp
--,t.holiday_repair_to_date = @enddate_temp
from Tsd_penalty_report_tab t
where holiday_response_to_date is NULL
and process_flag = 'N'
 
update t
SET
 t.holiday_repair_to_date = @enddate_temp
from Tsd_penalty_report_tab t
where holiday_repair_to_date is NULL
 and process_flag = 'N'

  
 update t SET
 [Actual Response KPI] = 
 CEILING(CAST(DATEDIFF(MI,holiday_from_date, holiday_response_to_date) AS DECIMAL(12, 5)) / 60 / 24) 
  ,[Actual Repair KPI] = CEILING(CAST(DateDiff(minute, holiday_from_date, holiday_repair_to_date) AS DECIMAL(14, 5)) / 60 / 24)
  ,[Holidays&Weekends] = dbo.[state_noofholidays]([state],holiday_from_date,holiday_response_to_date) 
  ,[Repair Holidays&Weekends]= dbo.[state_noofholidays]([state],holiday_from_date,holiday_repair_to_date) 
  --,process_flag = 'Y'
from Tsd_penalty_report_tab t	
 where process_flag = 'N'

update t SET
[Ownership] = ast_det_varchar15
,[Asset_Cost] = ast_det_asset_cost
,[AgeofBE] = CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, d.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16)) 
,[clinic_code] = ast_det_cus_code
,[clinic_name] = ast_det_note1
,[ClinicType] = ast_det_varchar1
,[MaintananceRev] = ast_det_numeric8 
from Tsd_penalty_report_tab t	
join ast_det d on t.ast_rowid = d.mst_RowID
  and process_flag = 'N'
	 
SELECT @startdate_temp = cONVERT(datetime,DATEADD(mm,1,CONVERT(DATETIME,@startdate_temp)))
 
 update Tsd_penalty_report_tab
 set process_flag = 'Y'
 where  process_flag = 'N'
end



update tab
set  [Response KPI]= ResponseDays  , [Repair KPI] = Repairdays
from Tsd_penalty_report_tab tab (nolock),
	KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and Asset_type = Begroup
and mst.ClinicType = tab.ClinicType


--debug 
 
update Tsd_penalty_report_tab
set [Final Response KPI] = [Actual Response KPI],
	[Final Repair KPI] = [Actual Repair KPI]
where  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Response KPI] = 0
where  isnull([Response Date && Time],MonthEnd) < [MonthStart]
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Response KPI] = CEILING(CAST(DATEDIFF(MI, [MonthStart], isnull([Response Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Response Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Repair KPI] = CEILING(CAST(DATEDIFF(MI, [MonthStart],  isnull([Completion Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid


update Tsd_penalty_report_tab
set [Final Response KPI] = CEILING(CAST(DATEDIFF(MI, [MonthStart], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where  isnull([Response Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Response KPI] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime] , MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Response Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Current'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Repair KPI] = CEILING(CAST(DATEDIFF(MI, [MonthStart], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Final Repair KPI] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Current'
and  [Guid] = @guid


/*Calculate No of holidays*/

update Tsd_penalty_report_tab
set [Holidays&Weekends] = 0
where  isnull([Response Date && Time],MonthEnd) < [MonthStart]
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], isnull([Response Date && Time],MonthEnd)) 
where   isnull([Response Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], isnull([Completion Date && Time],MonthEnd)) 
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid


update Tsd_penalty_report_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], MonthEnd)
where  isnull([Response Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[Wr Datetime], MonthEnd) 
where   isnull([Response Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Current'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair Holidays&Weekends] = dbo.[state_noofholidays](State,[MonthStart], MonthEnd)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair Holidays&Weekends] = dbo.[state_noofholidays](State,[Wr Datetime], MonthEnd)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Current'
and  [Guid] = @guid


/*Calculate Remaining KPI days*/

update Tsd_penalty_report_tab
set [KPI_remains] = 0
where  isnull([Response Date && Time],MonthEnd) < [MonthStart]
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [KPI_remains] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], Dateadd(mm,-1,MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24) - dbo.[state_noofholidays](State,[Wr Datetime], Dateadd(mm,-1,MonthEnd))
where   isnull([Response Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid
 
update Tsd_penalty_report_tab
set [Repair KPI_remains] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], Dateadd(mm,-1,MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)- dbo.[state_noofholidays](State,[Wr Datetime], Dateadd(mm,-1,MonthEnd))
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [KPI_remains] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], Dateadd(mm,-1,MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)- dbo.[state_noofholidays](State,[Wr Datetime], Dateadd(mm,-1,MonthEnd))
where  isnull([Response Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair KPI_remains] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], Dateadd(mm,-1,MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)- dbo.[state_noofholidays](State,[Wr Datetime], Dateadd(mm,-1,MonthEnd))
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and Period_Status = 'Previous'
and  [Guid] = @guid
 


update Tsd_penalty_report_tab
set [Response KPI] = [Response KPI]-[KPI_remains] 
where [KPI_remains]<= [Response KPI]
and  [Guid] = @guid


update Tsd_penalty_report_tab
set [Response KPI] = 0
where [KPI_remains] > [Response KPI]
and  [Guid] = @guid

 

update Tsd_penalty_report_tab
set [KPI_remains] = 0 , [Response KPI] = 0
where  isnull([Response Date && Time],MonthEnd) < [MonthStart]
and Period_Status = 'Previous'
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair KPI_remains] = 0
where [Repair KPI_remains] is NULL
and  [Guid] = @guid


 
update Tsd_penalty_report_tab
set [Repair KPI] = 0
where [Repair KPI_remains] > [Repair KPI]
and  [Guid] = @guid

update Tsd_penalty_report_tab
set [Repair KPI] = [Repair KPI]-[Repair KPI_remains] 
where [Repair KPI_remains]<= [Repair KPI]
and  [Guid] = @guid

 

--SELECT [Repair KPI_remains],[Repair KPI],[Repair KPI_remains]  from Tsd_penalty_report_tab 


update Tsd_penalty_report_tab
set [Final Response KPI ExclHoli] = [Final Response KPI]-[Holidays&Weekends]-[Response KPI]
Where  [Guid] = @guid


update Tsd_penalty_report_tab
set [Final Repair KPI ExclHoli] = [Final Repair KPI] - [Repair Holidays&Weekends] - [Repair KPI]
Where  [Guid] = @guid


update Tsd_penalty_report_tab
set [Final Response KPI ExclHoli] = 0
Where  [Guid] = @guid
and [Final Response KPI ExclHoli] <=0


update Tsd_penalty_report_tab
set [Final Repair KPI ExclHoli] = 0
Where  [Guid] = @guid
and [Final Repair KPI ExclHoli] <=0


update tab
set penalty_cost = cost.penalty_cost ,
	Repair_penalty_cost = cost.penalty_cost * [Final Repair KPI ExclHoli] ,
	Response_penalty_cost = cost.penalty_cost * [Final Response KPI ExclHoli] ,
	Total_penalty_cost = isnull((cost.penalty_cost * [Final Repair KPI ExclHoli] )+(cost.penalty_cost * [Final Response KPI ExclHoli]),0.0)
from 
Tsd_penalty_report_tab tab(nolock),
Pen_cost_mst cost (nolock)
WHERE [Guid] = @guid
and Asset_Cost between costfrom and isnull(costto,Asset_Cost)


update Tsd_penalty_report_tab
set penalty_cost = 100 ,
	Repair_penalty_cost = 100 * [Final Repair KPI ExclHoli] ,
	Response_penalty_cost = 100 * [Final Response KPI ExclHoli] ,
	Total_penalty_cost = isnull((100 * [Final Repair KPI ExclHoli] )+(100 * [Final Response KPI ExclHoli]),0.0)
Where  [Guid] = @guid
and [BE_Category] in ('12-351','10-212',' 10-972')
and [ownership] = 'Accessories'
					   
					  
------Alter Table Tsd_penalty_report_tab
------add MaintananceRev numeric(30,4)

------Alter Table Tsd_penalty_report_tab
------add Capping numeric(30,4)

update Tsd_penalty_report_tab
set [Capping]  = [MaintananceRev]*0.05 ,
	Total_penalty_cost =[MaintananceRev]*0.05 
Where  [Guid] = @guid
and [BE_Category] in ('Chairs, Examination/Treatment, Dentistry','Chairs, Examination/Treatment, Dentistry, Specialist')
and Convert(datetime,[MonthEnd]) between '2015-12-17' and '2017-12-16'-- '2017-12-31'-- commented by murugan


update Tsd_penalty_report_tab
set Total_penalty_cost = 0.0 , Remarks = 'BE Age > 15 Years'
Where  [Guid] = @guid
and AgeofBE  >=16

 

select 
[WO Number]
,[WR Number]
,[Assign To]
,[Employee Name]
,[WO Date && Time]
,[Wr Datetime]
,[Response Date && Time]
,[Completion Date && Time]
,[Zone]
,[State]
,[Circle]
,[District]
,[WO Status]
,[Ownership]
,[WR Status]
,[WR Month]
,[Response KPI]
,[Repair KPI]
,[Actual Response KPI]
,[Actual Repair KPI]
,[Final Response KPI]
,[Final Repair KPI]
,[Holidays&Weekends]
,[Repair Holidays&Weekends]
,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[ProblemReported]
,[Actiontaken]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
--,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[Capping]
--into test1
from Tsd_penalty_report_tab (NOLOCK)
where [Guid] = @guid
and [Ownership] IN (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
----and state like @statename
--AND state = isnull(@statename,state)
--AND [District] = isnull(@District,[District])
--AND [clinic_category] = isnull(@reporttype,[clinic_category])
AND [Wr Datetime] between  @periodfrom and @periodto
and  [WO Number]	 is not NULL
 --and  [WR Number]=  'WKR180854'
--drop table test
 
--and wkr_mst_wr_no = 'WKR180854'

--and  [wr number] =  'WKR182746'
--SELECT @startdate_temp 'startdate_temp',@enddate_temp 'enddate_temp'-- into test

Delete from Tsd_penalty_report_tab with (readpast)
where [Guid] = @guid

set nocount off

end


----12-351  , 'Lights, Dental'
----10-212  , 'Aspirators, Dental'
----10-972  , 'Compressors, Medical-Air'


