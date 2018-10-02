 
 --Exec tsd_Sm_kpi_report_out 'ALL' , 'ALL','ALL' , 'ALL','2017-01-01' , '2017-12-31','ALL'

ALTER procedure tsd_Sm_kpi_report_out
@statename	varchar(100) = 'all',
@district	varchar(200) = 'all',
@zone	varchar(200)= 'all',
@cliniccategory	varchar(100)= 'all',
@periodfrom	date = '2018-06-01',
@periodto	date = '2018-07-31',
@ownership	varchar(200) = 'all'
as
begin


if @statename in ('ALL','0')
begin
set @statename = NULL
end

if @District in  ('ALL','0')
begin
set @District = NULL
end


if @zone in  ('ALL','0')
begin
set @zone = NULL
end

if @cliniccategory in  ('ALL','0')
begin
set @cliniccategory = NULL
end

if @ownership in  ('ALL','0')
begin
set @ownership = '%'
end

Declare @guid varchar(100) =   newid()  -- @guid

--Truncate table Tsd_SM_Performance_kpi_tab

Insert into Tsd_SM_Performance_kpi_tab (
[GUID]
,[WO Number]
,[WR Number]
,[Assign To]
,[Employee Name]
,[WO Date && Time]
,[Completion Date && Time]
,[Zone]
,[State]
,[Circle]
,[District]
,[WO Status]
,[Ownership]
,[WR Month]
,[Response KPI]
,[Final Response KPI]
,[Response KPI Type]
,[Holidays&Weekends]
,[Final Response KPI ExclHoli]
,[Computation Field]
,[Computation Field KPI]
,[Remarks]
,[BENumber]
,[Betype]
,[BEcategory]
,[BEstatus]
,[AgeofBE]
,[ClinicCode]
,[clinicname]
,[Wo Month]
,[Comp Month]
,reschedule_date
)
select 
 @guid
,wko_mst.wko_mst_wo_no
,wko_det_pm_idno
,wko_det_assign_to
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,wko_mst_status
,ast_det_varchar15
,Right('00'+Convert(varchar,month(isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date)  )),2)+'.'+Left(Datename(mm,isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date)  ),3)+'-'+ right(Convert(varchar,year(isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date) )),2)
,CEILING(CAST(DateDiff(minute, isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date) , isnull(wko_det.wko_det_cmpl_date,Getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,CEILING(CAST(DateDiff(minute, isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date) , isnull(wko_det.wko_det_cmpl_date,Getdate())) AS DECIMAL(14, 5)) / 60 / 24)
,''
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date) ,isnull(wko_det_cmpl_date,getdate()))
,0
,1
,0
,''
,ast_mst.ast_mst_asset_no
,ast_mst_asset_type 
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_mst_asset_status
,(Year(getdate())- year(Isnull(ast_det_purchase_date,'2000-01-01')))
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
--,datediff(mm,0,wko_mst_org_date) [Wo Month] --added by murugan
,datediff(mm,0,isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date)) [Wo Month]
,Datediff(mm,0,isnull(wko_det_cmpl_date,0)) [Comp Month]
,wko_det.wko_det_datetime1
FROM wko_mst (nolock)
	,wko_det (nolock)
	,ast_mst (nolock)
	,ast_det (nolock)
WHERE (wko_mst.site_cd = wko_det.site_cd)
	AND wko_mst.site_cd = 'QMS'
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)	
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND  left(wko_mst_wo_no,3) = 'PWO'
	AND  wko_det_pm_idno is not null
	AND ast_mst_ast_lvl = Isnull(@statename,ast_mst_ast_lvl)
	AND ast_mst_asset_locn = Isnull(@District,ast_mst_asset_locn)
	and ast_mst.ast_mst_asset_code = Isnull(@cliniccategory ,ast_mst_asset_code)
	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and  Ownership_desc like @ownership 
										)
	--and wko_mst_org_date between  @periodfrom and @periodto
	AND cast(isnull(wko_det.wko_det_datetime1 ,wko_mst_org_date) as date) between  @periodfrom and @periodto
	-- isnull added by muruganantham
	--AND ast_mst.ast_mst_create_date < @yearstart

Update Tsd_SM_Performance_kpi_tab
set [Response KPI Type] = 'With In KPI' , [Computation Field KPI] = 1
where guid = @guid
and [Wo Month] >= [Comp Month]

Update Tsd_SM_Performance_kpi_tab
set [Response KPI Type] = 'Out Of KPI' , [Computation Field KPI] = 0
where guid = @guid
and [Wo Month] < [Comp Month]

Update Tsd_SM_Performance_kpi_tab
set [Response KPI Type] = 'Out Of KPI', [Computation Field KPI] = 0
where guid = @guid
and [Comp Month] = 0

Select 
[WO Number]
,[WR Number]
,[Assign To]
,[Employee Name]
,[WO Date && Time]
,[Completion Date && Time]
,[Zone]
,[State]
,[Circle]
,[District]
,[WO Status]
,[Ownership]
,[WR Month]
,[Response KPI]
,[Final Response KPI]
,[Response KPI Type]
,[Holidays&Weekends]
,[Final Response KPI ExclHoli]
,[Computation Field]
,[Computation Field KPI]
,[Remarks]
,[BENumber]
,[Betype]
,[BEcategory]
,[BEstatus]
,[AgeofBE]
,[ClinicCode]
,[clinicname]
,[Wo Month]
,[Comp Month]
,reschedule_date
From Tsd_SM_Performance_kpi_tab (NOLOCK)
where guid = @guid

Delete from Tsd_SM_Performance_kpi_tab
where guid = @guid


end

--pwo327765

--alter table Tsd_SM_Performance_kpi_tab
--add reschedule_date datetime


