Alter view AGM_Scorecard_view
as
select 
'Northern & East M''sia' as 'State Name', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and ast_mst_perm_id in ('NORTHERN','EAST MALAYSIA')
and Year(wkr_mst_org_date) >= year(getdate())-1

union all

select 
'Southern & Central' as 'State Name', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and ast_mst_perm_id in ('SOUTHERN','CENTRAL')

union all

select 
'Northern & East M''sia' as 'State Name', '2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('CMP','CLO','CNX','BER')
and ast_mst_perm_id in ('NORTHERN','EAST MALAYSIA')

union all

select 
'Southern & Central' as 'State Name','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('CMP','CLO','CNX','BER')
and ast_mst_perm_id in ('SOUTHERN','CENTRAL')

union all

select 
'Northern & East M''sia' as 'State Name','3.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
and ast_mst_perm_id in ('NORTHERN','EAST MALAYSIA')

union all

select 
'Southern & Central' as 'State Name','3.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
and ast_mst_perm_id in ('SOUTHERN','CENTRAL')




