ALTER view Today_scorecard_all
as
select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and convert(date,wkr_mst_org_date) = convert(date,getdate())
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 
--order by Year(wkr_mst_org_date) , Datename(MONTH,wkr_mst_org_date) 

/*
union all

select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date)  'Month OF WO','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and convert(date,wkr_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('CMP','CLO')
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 
--order by Year(wkr_mst_org_date) , Datename(MONTH,wkr_mst_org_date) 
*/

union all

select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date)  'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and wko_mst_asset_level = SatateDesc
and convert(date,wkr_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 

union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and convert(date,wkr_mst_org_date) = convert(date,getdate())
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 
--order by Year(wkr_mst_org_date) , Datename(MONTH,wkr_mst_org_date) 

/*
union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date)  'Month OF WO','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and convert(date,wkr_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('CMP','CLO')
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 
--order by Year(wkr_mst_org_date) , Datename(MONTH,wkr_mst_org_date) 

*/
union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,Convert(date,wkr_mst_org_date)  'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
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
and ast_mst_create_by in ('Patch')
and wko_mst_asset_level = SatateDesc
and convert(date,wkr_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , Year(wkr_mst_org_date) ,Convert(date,wkr_mst_org_date) 


