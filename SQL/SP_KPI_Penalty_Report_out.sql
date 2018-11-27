 --exec SP_KPI_Penalty_Report_out 'pulau pinang','all','all','northern','all','2018-01-07','2018-09-30'

ALTER Procedure SP_KPI_Penalty_Report_out
@statename varchar(100) = 'all',
@district varchar(200) = 'all',
@zone varchar(200) = 'all',
@reporttype varchar(100) = 'all',
@periodfrom Date = '2018-01-01' ,
@periodto date = '2018-11-26',
@ownership varchar(200)  = 'all'

as 

begin

set nocount on

Declare @startdate Datetime
Declare @enddate datetime


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

Declare @startdate_temp Datetime
Declare @enddate_temp Datetime

--Truncate table  Tsd_penalty_report_tab


Declare @guid varchar(100) =   newid()  -- @guid

--INSERT INTO PENALTY_REPORT_DATA_OUT
/*
select @startdate_temp = @startdate


WHILE ( @startdate_temp BETWEEN @startdate AND  @enddate )

BEGIN

select @enddate_temp = CONVERT(datetime,DATEADD(SS,-1,Dateadd(mm,1,@startdate_temp)))

/*
insert into Tsd_penalty_report_tab
(GUID
,[WO Number]
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
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[clinic_code]
,[clinic_name]
,[clinic_category]
)

/* PS & BA - Category Starts*/

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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'2' AS 'Response KPI'
,'4' AS 'Repair KPI'
,Response_Actual_KPI	= CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI		= CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
, ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND ast_mst.ast_mst_asset_type in ( 'PS','BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
	AND ast_det.ast_det_varchar15  in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )


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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'2' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type in ( 'PS','BA'))
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
	

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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'2' AS 'Response KPI'
,'4' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Previous ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type in ( 'PS','BA'))
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'2' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Previous ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type in ( 'PS','BA'))
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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

/* CR - Category Starts*/


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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'1' AS 'Response KPI'
,'3' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'CR' )
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp



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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'1' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type  ='CR' )
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp


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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'1' AS 'Response KPI'
,'3' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Previous ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'CR' )
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'1' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME,@startdate_temp)
	,CONVERT(DATETIME,@enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
	,0
	,0
	,0
	,'Previous ' AS 'Period_Status'
	,ast_det_cus_code
	,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
	,ast_mst_asset_code
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
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type = 'CR')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	--AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	--AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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

if @statename = 'ALL'
begin

insert into Tsd_penalty_report_tab
(GUID
,[WO Number]
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
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[ClinicType]
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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'0' AS 'Response KPI'
,'0' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
		,cus_mst.cus_mst_fob
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
	AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
	

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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'0' AS 'Response KPI'
,'0' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Previous ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
		,cus_mst.cus_mst_fob
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
	AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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

end
else
begin

insert into Tsd_penalty_report_tab
(GUID
,[WO Number]
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
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[ClinicType]
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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'0' AS 'Response KPI'
,'0' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Current ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
		,cus_mst.cus_mst_fob
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
	AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	AND wkr_mst.wkr_mst_org_date between  @startdate_temp and @enddate_temp
	

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
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst.wko_mst_status
,wko_det_varchar8
,wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,'0' AS 'Response KPI'
,'0' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,@enddate_temp)) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,@enddate_temp)) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
--,''
--,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,@enddate_temp))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,@enddate_temp))
,0
,0
--,1
--,1
--,0
--,0
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
	,ast_mst_asset_type 
	,Replace(Replace(wko_mst.wko_mst_descs,Char(10),''),char(13),'') as ProblemReported
	,Replace(Replace(wko_det.wko_det_corr_action,Char(10),''),char(13),'') as ActionTaken 
	,CONVERT(DATETIME, @startdate_temp)
	,CONVERT(DATETIME, @enddate_temp)
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, @enddate_temp) AS DECIMAL(12, 5)) / 365, 16))
	,0
	,0
		,0
		,0
		,0
		,'Previous ' AS 'Period_Status'
		,ast_det_cus_code
		,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
		,ast_mst_asset_code
		,cus_mst.cus_mst_fob
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
	AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
	AND ast_mst.ast_mst_asset_locn = isnull(@District,ast_mst.ast_mst_asset_locn)
	AND ast_mst.ast_mst_asset_code = isnull(@reporttype,ast_mst.ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
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
		end
		

SELECT @startdate_temp = cONVERT(datetime,DATEADD(mm,1,CONVERT(DATETIME,@startdate_temp)))

end
 
update tab
set  [Response KPI]= ResponseDays  , [Repair KPI] = Repairdays
from Tsd_penalty_report_tab tab (nolock),
	KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and Asset_type = Begroup
and mst.ClinicType = tab.ClinicType
 

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
set [Final Response KPI] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
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
set Total_penalty_cost = 0.0 , Remarks = 'BE Age > 15 Years'
Where  [Guid] = @guid
and AgeofBE  >=16


--added by murugan for dupliate removing
--select * from Tsd_penalty_report_tab where  [WO Number] = 'cwo182697'


;with cte as
(
select * ,row_number() over(partition by
[GUID]
,[WO Number]
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
,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[Repair Holidays&Weekends]
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[ProblemReported]
,[Actiontaken]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[Repair KPI_remains]
,clinic_code
,clinic_name
,clinic_category
,Remarks
,ClinicType
,MaintananceRev
,Capping
,ast_rowid
,holiday_from_date
,holiday_response_to_date
,holiday_repair_to_date
,process_flag

order by

[GUID]
,[WO Number]
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
,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[Repair Holidays&Weekends]
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[ProblemReported]
,[Actiontaken]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[Repair KPI_remains]
,clinic_code
,clinic_name
,clinic_category
,Remarks
,ClinicType
,MaintananceRev
,Capping
,ast_rowid
,holiday_from_date
,holiday_response_to_date
,holiday_repair_to_date
,process_flag

 ) rn
 
 from Tsd_penalty_report_tab (nolock)  --where GUID 

)

delete from cte where rn > 1
*/

update Tsd_penalty_report_tab
set [Total_penalty_cost] =  isnull([Repair_penalty_cost],0) + isnull([Response_penalty_cost],0)
 
select 
[WO Number]
,[WR Number]
,[Assign To]
,[Employee Name]
,format([WO Date && Time],'dd/MM/yyyy hh:mm:ss') [WO Date && Time]
, format([Wr Datetime],'dd/MM/yyyy hh:mm:ss') [Wr Datetime]
, format([Response Date && Time],'dd/MM/yyyy hh:mm:ss') [Response Date && Time]
, format([Completion Date && Time],'dd/MM/yyyy hh:mm:ss') [Completion Date && Time]
,[Zone]
,[State]
,[Circle]
,[District]
,[WO Status]
,[Ownership]
,[WR Status]
,[WR Month]
,[Response KPI]--need to debug
,[Repair KPI]--need to debug
,[Actual Response KPI]
,[Actual Repair KPI]
,[Final Response KPI]
,[Final Repair KPI]
,[Holidays&Weekends]
,[Repair Holidays&Weekends]--need to debug
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
from Tsd_penalty_report_tab (NOLOCK)
--where [Guid] = @guid
----and state like @statename
--AND state = isnull(@statename,state)
--AND [District] = isnull(@District,[District])
--AND [clinic_category] = isnull(@reporttype,[clinic_category])
--and [WO Number] = 'CWO177336'--'cwo182697'
--Delete from Tsd_penalty_report_tab where [Guid] = @guid

set nocount off

end






