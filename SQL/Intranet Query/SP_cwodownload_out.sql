Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE procedure SP_cwodownload_out
		@state nvarchar(200)
		,@zone nvarchar(200)
		,@District nvarchar(200)
		,@circle nvarchar(200)
		,@ClinicCategory nvarchar(200)
		,@becategory nvarchar(200)
		,@wostatus nvarchar(200)
		,@startdate date
		,@enddate date
		
as
begin

set nocount on

SET QUOTED_IDENTIFIER ON

SET ANSI_NULLS ON

SET ARITHABORT ON


if @state in  ('ALL','0','')
begin
set @state = '%'
end

if @zone in  ('ALL','0','')
begin
set @zone = '%'
end

if @District in  ('ALL','0','')
begin
set @District = '%'
end

if @circle in  ('ALL','0','')
begin
set @circle = '%'
end

if @becategory in  ('ALL','0','')
begin
set @becategory = NULL
end

if @wostatus in  ('ALL','0','')
begin
set @wostatus = '%'
end

if @ClinicCategory in  ('ALL','0','')
begin
set @ClinicCategory = '%'
end


if @startdate in  ('')
begin
set @startdate = '2015-01-01'
end

if @enddate in  ('')
begin
set @enddate = getdate()
end



/*
select 
wko_det_parent_wo 'Parent WO',
wko_mst_wo_no 'WO Number',
wkr_mst_wr_no 'WR Number',
isnull(wko_mst_ast_cod,wkr_det_varchar2) 'Clinic Category',
isnull(wko_mst_assetno,wkr_mst_assetno) 'BE Number',
isnull(AST_MST.ast_mst_asset_longdesc,wkr_mst.ast_mst_asset_longdesc) 'Be Category',
isnull(wko_det_varchar5 ,'NA') 'Manufacturer',
isnull(wko_det_varchar6 ,'NA')'Model',
isnull(wko_det_varchar7 ,'NA') 'Serial No',
wko_det_assign_to 'Assign To',
Replace(Replace(Replace(isnull(wko_mst_descs,wkr_mst_wr_descs),char(13),''),char(10),''),'"','') 'Problem Reported',
Replace(Replace(Replace(wko_det_corr_action,char(13),''),char(10),''),'"','')  'Action Taken' ,
convert(varchar,isnull(wko_mst_create_date,wkr_mst_create_date),120) 'Created Date',
convert(varchar,wko_mst_org_date,120) 'WO Date && Time',
convert(varchar,wkr_mst_org_date,120) 'Wr Datetime',
convert(varchar,wko_det_exc_date,120) 'Response Date && Time',
convert(varchar,wko_det_cmpl_date,120) 'Completion Date && Time',
isnull(wko_det_customer_cd,left(wkr_mst_chg_costcenter,6)) 'Clinic Code',
isnull(wko_det_note1 ,wkr_det_note1)'Clinic Name',
isnull(wko_det_varchar1,wkr_det_varchar1) 'Clinic Type',
isnull(wko_det_perm_id,wkr_det_varchar4) 'Zone',
isnull(wko_mst_asset_level,wkr_mst_location) 'State',
isnull(wko_mst_work_area ,wkr_mst_work_area)'Circle',
isnull(wko_mst_asset_location,wkr_mst_assetlocn) 'District',
wko_mst_status 'WO Status',
Case when wkr_mst_wr_status = 'A' then 'Approved'  
 when wkr_mst_wr_status = 'W' then 'Waiting' 
 else 'Rejected'
 end as 'WR Status' ,
isnull(wko_det_varchar8 ,wkr_det_varchar8) 'Ownership'
from 
wko_mst (nolock) 
JOIN
AST_MST (nolock) 
on AST_MST.site_cd = wko_mst.site_cd
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
AND wko_mst_assetno = ast_mst_asset_no
--and wko_mst_asset_group_code = wko_mst_asset_group_code
and ast_mst_asset_code = wko_mst_ast_cod
and ast_mst_ast_lvl = wko_mst_asset_level
and ast_mst_asset_locn = wko_mst_asset_location
and ast_mst_work_area = wko_mst_work_area
and ast_mst_asset_grpcode = isnull(@becategory,ast_mst_asset_grpcode)
and ast_mst_asset_code = isnull(@ClinicCategory,ast_mst_asset_code)
and ast_mst_asset_locn = isnull(@district,ast_mst_asset_locn)
and ast_mst_ast_lvl =  isnull(@state,ast_mst_ast_lvl)
and ast_mst_work_area = isnull(@circle,ast_mst_work_area)
join 
wko_det (nolock)
on wko_det.site_cd = wko_mst.site_cd
and wko_det.mst_rowid = wko_mst.rowid
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
and wko_mst_asset_group_code = isnull(@becategory,wko_mst_asset_group_code)
and wko_mst_ast_cod = isnull(@ClinicCategory,wko_mst_ast_cod)
and wko_mst_status = isnull(@wostatus,wko_mst_status)
and wko_mst_asset_level = isnull(@state,wko_mst_asset_level)
and wko_mst_asset_location = isnull(@district,wko_mst_asset_location)
and wko_mst_work_area = isnull(@circle,wko_mst_work_area)
--and convert(date,wko_mst_org_date) between @startdate and  @enddate
full outer join
(select 
wkr_mst.site_cd , wkr_mst_wr_no , wkr_mst_wr_status,wkr_mst_org_date,wkr_det_note1,ast_mst_asset_grpcode,ast_mst_asset_longdesc , wkr_det_varchar2,wkr_det_varchar1,wkr_det_varchar4,wkr_mst_chg_costcenter,wkr_mst_location,wkr_mst_work_area,
wkr_mst_assetlocn,wkr_mst_create_date,wkr_mst_wr_descs,wkr_mst_assetno,wkr_det_varchar8
from wkr_mst (nolock),
wkr_det (nolock) ,
ast_mst (nolock)
where wkr_det.site_cd = wkr_mst.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_det.mst_rowid = wkr_mst.rowid
and ast_mst.site_cd = wkr_mst.site_cd
and ast_mst_asset_no = wkr_mst_assetno 
and ast_mst_asset_grpcode = isnull(@becategory,ast_mst_asset_grpcode)
and wkr_det_varchar2 = isnull(@ClinicCategory,wkr_det_varchar2)
and wkr_mst_location = isnull(@state,wkr_mst_location)
and wkr_mst_assetlocn = isnull(@district,wkr_mst_assetlocn)
and convert(date,wkr_mst_org_date) between @startdate and  @enddate
) wkr_mst
on wkr_mst.site_cd = wko_det.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_mst_wr_no = wko_det_wr_no
where  wko_mst_asset_group_code = isnull(@becategory,wko_mst_asset_group_code)
and wko_mst_ast_cod = isnull(@ClinicCategory,wko_mst_ast_cod)
and wko_mst_status = isnull(@wostatus,wko_mst_status)
and wko_mst_asset_level = isnull(@state,wko_mst_asset_level)
and wko_mst_asset_location = isnull(@district,wko_mst_asset_location)
and wko_mst_work_area = isnull(@circle,wko_mst_work_area) 
and wko_det.wko_det_perm_id = isnull(@zone,wko_det.wko_det_perm_id)
and convert(date,isnull(wkr_mst_org_date,wko_mst_org_date)) between @startdate and  @enddate
--and left(wko_mst_wo_no,3) = 'CWO'
*/

declare @guid nvarchar(100) = newid()

if @becategory is not null
begin

insert into cwo_download_report_tab
([Guid],[Parent WO],[WO Number],[WR Number],[Clinic Category],[BE Number],[Be Category],[Manufacturer],[Model],[Serial No],[Assign To],[Problem Reported],[Action Taken],[Created Date],[WO Date && Time],[Wr Datetime],[Response Date && Time],[Completion Date && Time],[Clinic Code],[Clinic Name],[Clinic Type],[Zone],[State],[Circle],[District],[WO Status],[WR Status],[Ownership])
select 
@guid,
wko_det_parent_wo 'Parent WO',
wko_mst_wo_no 'WO Number',
wkr_mst_wr_no 'WR Number',
isnull(wko_mst_ast_cod,wkr_det_varchar2) 'Clinic Category',
isnull(wko_mst_assetno,wkr_mst_assetno) 'BE Number',
isnull(AST_MST.ast_mst_asset_longdesc,wkr_mst.ast_mst_asset_longdesc) 'Be Category',
isnull(wko_det_varchar5 ,'NA') 'Manufacturer',
isnull(wko_det_varchar6 ,'NA')'Model',
isnull(wko_det_varchar7 ,'NA') 'Serial No',
wko_det_assign_to 'Assign To',
Replace(Replace(Replace(isnull(wko_mst_descs,wkr_mst_wr_descs),char(13),''),char(10),''),'"','') 'Problem Reported',
Replace(Replace(Replace(wko_det_corr_action,char(13),''),char(10),''),'"','')  'Action Taken' ,
convert(varchar,isnull(wko_mst_create_date,wkr_mst_create_date),120) 'Created Date',
convert(varchar,wko_mst_org_date,120) 'WO Date && Time',
convert(varchar,wkr_mst_org_date,120) 'Wr Datetime',
convert(varchar,wko_det_exc_date,120) 'Response Date && Time',
convert(varchar,wko_det_cmpl_date,120) 'Completion Date && Time',
isnull(wko_det_customer_cd,left(wkr_mst_chg_costcenter,6)) 'Clinic Code',
isnull(wko_det_note1 ,wkr_det_note1)'Clinic Name',
isnull(wko_det_varchar1,wkr_det_varchar1) 'Clinic Type',
isnull(wko_det_perm_id,wkr_det_varchar4) 'Zone',
isnull(wko_mst_asset_level,wkr_mst_location) 'State',
isnull(wko_mst_work_area ,wkr_mst_work_area)'Circle',
isnull(wko_mst_asset_location,wkr_mst_assetlocn) 'District',
wko_mst_status 'WO Status',
Case when wkr_mst_wr_status = 'A' then 'Approved'  
 when wkr_mst_wr_status = 'W' then 'Waiting' 
 else 'Rejected'
 end as 'WR Status' ,
isnull(wko_det_varchar8 ,wkr_det_varchar8) 'Ownership'
from 
wko_mst (nolock) 
JOIN
AST_MST (nolock) 
on AST_MST.site_cd = wko_mst.site_cd
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
AND wko_mst_assetno = ast_mst_asset_no
and wko_mst_asset_group_code = wko_mst_asset_group_code
and wko_mst_asset_group_code = @becategory
and ast_mst_asset_code = wko_mst_ast_cod
and ast_mst_ast_lvl = wko_mst_asset_level
and ast_mst_asset_locn = wko_mst_asset_location
and ast_mst_work_area = wko_mst_work_area
join 
wko_det (nolock)
on wko_det.site_cd = wko_mst.site_cd
and wko_det.mst_rowid = wko_mst.rowid
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
full outer join
(select 
wkr_mst.site_cd , wkr_mst_wr_no , wkr_mst_wr_status,wkr_mst_org_date,wkr_det_note1,ast_mst_asset_grpcode,ast_mst_asset_longdesc , wkr_det_varchar2,wkr_det_varchar1,wkr_det_varchar4,wkr_mst_chg_costcenter,wkr_mst_location,wkr_mst_work_area,
wkr_mst_assetlocn,wkr_mst_create_date,wkr_mst_wr_descs,wkr_mst_assetno,wkr_det_varchar8
from wkr_mst (nolock),
wkr_det (nolock) ,
ast_mst (nolock)
where wkr_det.site_cd = wkr_mst.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_det.mst_rowid = wkr_mst.rowid
and ast_mst.site_cd = wkr_mst.site_cd
and ast_mst_asset_no = wkr_mst_assetno 
and ast_mst_asset_grpcode = @becategory
and convert(date,wkr_mst_org_date) between @startdate and  @enddate

) wkr_mst
on wkr_mst.site_cd = wko_det.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_mst_wr_no = wko_det_wr_no
where  wko_mst.site_cd = 'QMS'
and convert(date,isnull(wkr_mst_org_date,wko_mst_org_date)) between @startdate and  @enddate

end

if @becategory is null
begin

insert into cwo_download_report_tab
([Guid],[Parent WO],[WO Number],[WR Number],[Clinic Category],[BE Number],[Be Category],[Manufacturer],[Model],[Serial No],[Assign To],[Problem Reported],[Action Taken],[Created Date],[WO Date && Time],[Wr Datetime],[Response Date && Time],[Completion Date && Time],[Clinic Code],[Clinic Name],[Clinic Type],[Zone],[State],[Circle],[District],[WO Status],[WR Status],[Ownership])
select 
@guid,
wko_det_parent_wo 'Parent WO',
wko_mst_wo_no 'WO Number',
wkr_mst_wr_no 'WR Number',
isnull(wko_mst_ast_cod,wkr_det_varchar2) 'Clinic Category',
isnull(wko_mst_assetno,wkr_mst_assetno) 'BE Number',
isnull(AST_MST.ast_mst_asset_longdesc,wkr_mst.ast_mst_asset_longdesc) 'Be Category',
isnull(wko_det_varchar5 ,'NA') 'Manufacturer',
isnull(wko_det_varchar6 ,'NA')'Model',
isnull(wko_det_varchar7 ,'NA') 'Serial No',
wko_det_assign_to 'Assign To',
Replace(Replace(Replace(isnull(wko_mst_descs,wkr_mst_wr_descs),char(13),''),char(10),''),'"','') 'Problem Reported',
Replace(Replace(Replace(wko_det_corr_action,char(13),''),char(10),''),'"','')  'Action Taken' ,
convert(varchar,isnull(wko_mst_create_date,wkr_mst_create_date),120) 'Created Date',
convert(varchar,wko_mst_org_date,120) 'WO Date && Time',
convert(varchar,wkr_mst_org_date,120) 'Wr Datetime',
convert(varchar,wko_det_exc_date,120) 'Response Date && Time',
convert(varchar,wko_det_cmpl_date,120) 'Completion Date && Time',
isnull(wko_det_customer_cd,left(wkr_mst_chg_costcenter,6)) 'Clinic Code',
isnull(wko_det_note1 ,wkr_det_note1)'Clinic Name',
isnull(wko_det_varchar1,wkr_det_varchar1) 'Clinic Type',
isnull(wko_det_perm_id,wkr_det_varchar4) 'Zone',
isnull(wko_mst_asset_level,wkr_mst_location) 'State',
isnull(wko_mst_work_area ,wkr_mst_work_area)'Circle',
isnull(wko_mst_asset_location,wkr_mst_assetlocn) 'District',
wko_mst_status 'WO Status',
Case when wkr_mst_wr_status = 'A' then 'Approved'  
 when wkr_mst_wr_status = 'W' then 'Waiting' 
 else 'Rejected'
 end as 'WR Status' ,
isnull(wko_det_varchar8 ,wkr_det_varchar8) 'Ownership'
from 
wko_mst (nolock) 
JOIN
AST_MST (nolock) 
on AST_MST.site_cd = wko_mst.site_cd
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
AND wko_mst_assetno = ast_mst_asset_no
and wko_mst_asset_group_code = wko_mst_asset_group_code
--and ast_mst_asset_code = wko_mst_ast_cod
--and ast_mst_ast_lvl = wko_mst_asset_level
--and ast_mst_asset_locn = wko_mst_asset_location
--and ast_mst_work_area = wko_mst_work_area
join 
wko_det (nolock)
on wko_det.site_cd = wko_mst.site_cd
and wko_det.mst_rowid = wko_mst.rowid
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'CWO'
full outer join
(select 
wkr_mst.site_cd , wkr_mst_wr_no , wkr_mst_wr_status,wkr_mst_org_date,wkr_det_note1,ast_mst_asset_grpcode,ast_mst_asset_longdesc , wkr_det_varchar2,wkr_det_varchar1,wkr_det_varchar4,wkr_mst_chg_costcenter,wkr_mst_location,wkr_mst_work_area,
wkr_mst_assetlocn,wkr_mst_create_date,wkr_mst_wr_descs,wkr_mst_assetno,wkr_det_varchar8
from wkr_mst (nolock),
wkr_det (nolock) ,
ast_mst (nolock)
where wkr_det.site_cd = wkr_mst.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_det.mst_rowid = wkr_mst.rowid
and ast_mst.site_cd = wkr_mst.site_cd
and ast_mst_asset_no = wkr_mst_assetno 
and convert(date,wkr_mst_org_date) between @startdate and  @enddate

) wkr_mst
on wkr_mst.site_cd = wko_det.site_cd
and wkr_mst.site_cd = 'QMS'
and wkr_mst_wr_no = wko_det_wr_no
where  wko_mst.site_cd = 'QMS'
and convert(date,isnull(wkr_mst_org_date,wko_mst_org_date)) between @startdate and  @enddate

end

select 
[Parent WO],[WO Number],[WR Number],[Clinic Category],[BE Number],[Be Category],[Manufacturer],[Model],[Serial No],[Assign To],[Problem Reported],[Action Taken],[Created Date],[WO Date && Time],[Wr Datetime],[Response Date && Time],[Completion Date && Time],[Clinic Code],[Clinic Name],[Clinic Type],[Zone],[State],[Circle],[District],[WO Status],[WR Status],[Ownership]
from cwo_download_report_tab  (nolock)
where Guid =  @guid
and State like @state
and Zone  like @zone 
and District like @district
and Circle like @circle 
and [Clinic Category] like @ClinicCategory
and [WO Status] like @wostatus

Delete from cwo_download_report_tab 
where Guid =  @guid

set nocount off

end

----SP_cwodownload_out 'ALL','ALL','ALL','ALL','ALL','ALL','ALL','2015-01-01','2017-07-10'










