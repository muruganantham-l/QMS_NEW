ALTER view prm_KKKP_ALL_view
as
select 
Statecode 'State Name','Total' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and ast_det_varchar15 in ( 'Existing','Accessories')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NoofEngg 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name','Total' category, 'Existing' 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and ast_det_varchar15 in ( 'Existing','Accessories')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all

select 
Statecode 'State Name', 'Total' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NoofEngg 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name', 'Total' category, 'New & Purchase' 'Equip.Type',  'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all
select 
Statecode 'State Name','> 3 month' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','> 3 month' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NULL 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name','> 3 month' category, 'Existing' 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all

select 
Statecode 'State Name', '> 3 month' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','> 3 month' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NULL 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name', '> 3 month' category, 'New & Purchase' 'Equip.Type',  'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union 

select 
'Z.Total' 'State Name','Total' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by --Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name','Total' category, 'Existing' 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all

select 
'Z.Total' 'State Name', 'Total' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
group by --Statecode ,
 wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf PWO'
from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name', 'Total' category, 'New & Purchase' 'Equip.Type',  'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all
select 
'Z.Total' 'State Name','> 3 month' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by --Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','> 3 month' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NULL 'NumberOf PWO'
--from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name','> 3 month' category, 'Existing' 'Equip.Type',   'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all

select 
'Z.Total' 'State Name', '> 3 month' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending PWO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending PWO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by-- Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','> 3 month' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NULL 'NumberOf PWO'
--from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name', '> 3 month' category, 'New & Purchase' 'Equip.Type',  'Pending PWO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf PWO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_mst.rowid = ast_det.mst_rowid
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and Year(wko_mst_org_date) >= year(getdate())
and Datediff(mm,0,wko_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')



