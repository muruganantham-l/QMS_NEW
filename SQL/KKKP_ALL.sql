ALTER view KKKP_ALL
as
select 
Statecode 'State Name','Total' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name','Total' category, 'Existing' 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all

select 
Statecode 'State Name', 'Total' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NoofEngg 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name', 'Total' category, 'New & Purchase' 'Equip.Type',  'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all
select 
Statecode 'State Name','> 3 month' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','> 3 month' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NULL 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name','> 3 month' category, 'Existing' 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union all

select 
Statecode 'State Name', '> 3 month' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode , wko_mst_ast_cod

union 
select 
Statecode 'State Name','> 3 month' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NULL 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
Statecode 'State Name', '> 3 month' category, 'New & Purchase' 'Equip.Type',  'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by Statecode 

union 

select 
'Z.Total' 'State Name','Total' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by --Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','Total' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name','Total' category, 'Existing' 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all

select 
'Z.Total' 'State Name', 'Total' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
group by --Statecode ,
 wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','Total' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, Sum(NoofEngg) 'NumberOf WO'
from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name', 'Total' category, 'New & Purchase' 'Equip.Type',  'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all
select 
'Z.Total' 'State Name','> 3 month' category, 'Existing' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by --Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','> 3 month' category,'Existing' 'Equip.Type',   'No.of.Engg' Types, NULL 'NumberOf WO'
--from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name','> 3 month' category, 'Existing' 'Equip.Type',   'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
--group by Statecode 

union all

select 
'Z.Total' 'State Name', '> 3 month' category,'New & Purchase' 'Equip.Type',  Case 
							when wko_mst_ast_cod = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when wko_mst_ast_cod = 'PERGIGIAN' 
							then 'Pending WO (KP)'
							end as Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')
group by-- Statecode , 
wko_mst_ast_cod

union 
select 
'Z.Total' 'State Name','> 3 month' category, 'New & Purchase' 'Equip.Type',  'No.of.Engg' Types, NULL 'NumberOf WO'
--from scorecard_engineer_detail  (nolock)

union 

select 
'Z.Total' 'State Name', '> 3 month' category, 'New & Purchase' 'Equip.Type',  'Pending WO (KP+KK)' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report1 (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and Datediff(mm,0,wkr_mst_org_date) <= Datediff(mm,0,getdate())-3
and wko_mst_status in ('OPE','RFS')


