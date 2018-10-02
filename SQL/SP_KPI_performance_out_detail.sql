--exec SP_KPI_performance_out 'JOHOR' , 'ALL' , 'ALL' , 'ALL' , '2017-01-01','2017-09-25'

ALTER Procedure SP_KPI_performance_out_detail
@statename varchar(100)				= null		,
@District varchar(200)				= null		,
@Zone varchar(200)					= null		,
@reporttype varchar(100)			= null		,
@periodfrom Date					= null		,
@periodto date						= null		,
@ownership varchar(200)				= null		,
@assigned_to varchar(200)			= null

as 

begin

set nocount on

Declare @startdate varchar(10)  
Declare @enddate varchar(10) 


Select @startdate = isnull(@periodfrom ,'2017-01-01')
Select @enddate   = isnull(@periodto,convert(date,getdate()))


if @statename in ('ALL','0')
begin
set @statename = '%'
end

if @District in  ('ALL','0')
begin
set @District = '%'
end


if @zone in  ('ALL','0')
begin
set @zone = '%'
end

if @reporttype in  ('ALL','0')
begin
set @reporttype = '%'
end

if @ownership in  ('ALL','0')
begin
set @ownership = '%'
end



Declare @startdate_temp varchar(10) 
Declare @enddate_temp varchar(10)

---Truncate table  tsd_performance_kpi_tab


Declare @guid varchar(100) =   newid()  -- @guid

--INSERT INTO PENALTY_REPORT_DATA_OUT


insert into Tsd_Performance_kpi_tab
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
, [District]
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
,[Response KPI Type]
,[Repair KPI Type]
,[Holidays&Weekends]
,[Repair Holidays&Weekends]
,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[Computation Field]
,[Repair Computation Field]
,[Computation Field KPI]
,[Repair Computation Field KPI]
,BENumber
,BEcategory
,ClinicCode
,ClinicCategory
,Betype
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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'2' AS 'Response KPI'
,'4' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wkr_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND (ast_mst.ast_mst_asset_type = 'PS')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	AND (ast_mst.site_cd = 'QMS')
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )

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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'2' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wko_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND (ast_mst.ast_mst_asset_type = 'PS')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_det.ast_det_varchar15 in( 'Accessories','EXISTING')
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	--AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')


	---BA category
Union all

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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'2' AS 'Response KPI'
,'4' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wko_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND (ast_mst.ast_mst_asset_type = 'BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	--AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	--AND Year(wkr_mst.wkr_mst_org_date) = 2017
	--AND ast_det.ast_det_varchar15 in( 'Accessories','EXISTING')

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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'2' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wko_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND (ast_mst.ast_mst_asset_type = 'BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	--AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_det.ast_det_varchar15 in( 'Accessories','EXISTING')

----CR category

Union all

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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'1' AS 'Response KPI'
,'3' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wko_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND (ast_mst.ast_mst_asset_type = 'CR')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	--AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	--AND Year(wkr_mst.wkr_mst_org_date) = 2017
	--AND ast_det.ast_det_varchar15 in( 'Accessories','EXISTING')

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
,convert(varchar,month(wkr_mst.wkr_mst_org_date))+'.'+Left(Datename(mm,wkr_mst.wkr_mst_org_date),3)+'-'+ right(Convert(varchar,year(wkr_mst.wkr_mst_org_date)),2)
,'1' AS 'Response KPI'
,'5' AS 'Repair KPI'
,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_exc_date,getdate())) AS DECIMAL(12, 5)) / 60 / 24) 
,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, isnull(wko_det.wko_det_cmpl_date,getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,0
,0
,''
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_exc_date,getdate()))
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,wkr_mst.wkr_mst_org_date,isnull(wko_det.wko_det_cmpl_date,getdate()))
,0
,0
,1
,1
,0
,0
,wko_mst_assetno
,ast_mst_asset_longdesc
,ast_det_cus_code
,ast_mst_asset_code
,ast_mst_asset_type
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
	AND convert(date,wkr_mst.wkr_mst_org_date) between convert(date,@startdate) and convert(date,@enddate)
	AND ast_det.ast_det_varchar15 in (select Ownership_Type from ownership_mst (nolock) where Ownership_desc like @ownership )
	--AND ast_mst.ast_mst_ast_lvl LIKE @statename
	--AND (ast_mst.ast_mst_perm_id LIKE @zone)
	AND (ast_mst.site_cd = 'QMS')
	--AND ast_det.ast_det_varchar15 in( 'Accessories','EXISTING')

update tab
set [Employee Name] = emp_mst_name
from tsd_performance_kpi_tab tab(nolock) ,
	emp_mst mst(nolock) 
where GUid =  @guid
and site_cd = 'QMS'
and [Employee Name] = emp_mst_empl_id

update tsd_performance_kpi_tab
set [Final Response KPI] = [Actual Response KPI]  ,
[Final Repair KPI] = [Actual Repair KPI] 
where GUid =  @guid


update tsd_performance_kpi_tab
set [Final Response KPI ExclHoli] = [Actual Response KPI] -[Holidays&Weekends] ,
[Final Repair KPI ExclHoli] = [Actual Repair KPI] - [Repair Holidays&Weekends]
where GUid =  @guid


update tsd_performance_kpi_tab
set [Response KPI Type] = 'Within KPI', 
[Computation Field KPI] = 1 
where GUid =  @guid
and [Final Response KPI ExclHoli] <= [Response KPI]

update tsd_performance_kpi_tab
set [Response KPI Type] = 'Out of KPI', 
[Computation Field KPI] = 0 
where GUid =  @guid
and [Final Response KPI ExclHoli] > [Response KPI]


update tsd_performance_kpi_tab
set [Repair KPI Type] = 'Within KPI', 
[Repair Computation Field KPI] = 1
where GUid =  @guid
and [Final Repair KPI ExclHoli] <= [Repair KPI]

update tsd_performance_kpi_tab
set [Repair KPI Type] = 'Out of KPI', 
[Repair Computation Field KPI] = 0 
where GUid =  @guid
and [Final Repair KPI ExclHoli] > [Repair KPI]
 

select 
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
,case when @assigned_to = 'Yes' then [Assign To] else [District] END [District]
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
,[Response KPI Type]
,[Repair KPI Type]
,[Holidays&Weekends]
,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[Computation Field]
,[Computation Field KPI]
,[Repair Computation Field]
,[Repair Computation Field KPI]
,[Repair Holidays&Weekends]
,BENumber
,BEcategory
,ClinicCode
,ClinicCategory
,Betype
 from tsd_performance_kpi_tab (nolock)
 where GUid =  @guid
 and [State] like @statename
 and [Zone] like @zone
 and [District] like  @District

 Delete from tsd_performance_kpi_tab
  where GUid =  @guid


set nocount off

END




