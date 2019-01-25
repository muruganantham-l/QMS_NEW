alter  view prm_Today_scorecard_all
as


--all
SELECT s.statename 'State Name',equipment_type 'Equip.Type',year_wo 'Year OF WO',month_wo 'Month OF WO','1.WO Received' Types ,Count(wo_no) 'NumberOf WO'
from score_card_PRM_tbl (NOLOCK) s
where wo_type = 'PWO'
and wkr_mst_org_date = cast(getdate() as date)
GROUP by s.statename,equipment_type,year_wo,month_wo
--all pending 
union ALL
SELECT s.statename,equipment_type,year_wo,month_wo,'2.WO Pending'   Types ,Count(wo_no) 'NumberOf WO'
from score_card_PRM_tbl (NOLOCK) s
where wo_type = 'PWO'
and  wko_mst_status in ('OPE','RFS')
and wkr_mst_org_date = cast(getdate() as date)
GROUP by s.statename,equipment_type,year_wo,month_wo

----pending without mr
--union ALL
--SELECT s.statename,equipment_type,year_wo,month_wo,'3.WO Pending without MR'   Types ,Count(wo_no) 'NumberOf WO'
--from score_card_PRM_tbl (NOLOCK) s
--where wo_type = 'PWO'
--and  wko_mst_status in ('OPE','RFS')
--and mr_no is null
--and wkr_mst_org_date = cast(getdate() as date)
--GROUP by s.statename,equipment_type,year_wo,month_wo

/*commented by murugan for performance tuning
select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date) 'Month OF WO', '1.PWO Scheduled' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and ast_mst.RowID = ast_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
--and ast_det_varchar22  in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and convert(date,wko_mst_org_date) = convert(date,getdate())
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 
--order by Year(wko_mst_org_date) , Datename(MONTH,wko_mst_org_date) 

/*
union all

select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date)  'Month OF WO','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by not in ('Patch')
and convert(date,wko_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('CMP','CLO')
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 
--order by Year(wko_mst_org_date) , Datename(MONTH,wko_mst_org_date) 
*/

union all

select 
Statecode 'State Name', 'Existing' 'Equip.Type', Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date)  'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and ast_mst.RowID = ast_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by not in ('Patch')
and ast_det_varchar15 in ( 'Existing','Accessories')
--and ast_det_varchar22  in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and wko_mst_asset_level = SatateDesc
and convert(date,wko_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 

union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date) 'Month OF WO', '1.PWO Scheduled' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and ast_mst.RowID = ast_det.mst_RowID
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
--and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and convert(date,wko_mst_org_date) = convert(date,getdate())
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 
--order by Year(wko_mst_org_date) , Datename(MONTH,wko_mst_org_date) 

/*
union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date)  'Month OF WO','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and wko_mst_asset_level = SatateDesc
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_create_by in ('Patch')
and convert(date,wko_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('CMP','CLO')
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 
--order by Year(wko_mst_org_date) , Datename(MONTH,wko_mst_org_date) 

*/
union all

select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,Convert(date,wko_mst_org_date)  'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and ast_mst.RowID = ast_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_create_by in ('Patch')
and wko_mst_asset_level = SatateDesc
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
--and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and convert(date,wko_mst_org_date) = convert(date,getdate())
and wko_mst_status in ('OPE','RFS')
group by Statecode , Year(wko_mst_org_date) ,Convert(date,wko_mst_org_date) 




*/--commented by murugan for performnace tuning