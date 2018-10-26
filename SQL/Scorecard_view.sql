ALTER view Scorecard_view
as

select 
Statecode 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wkr_mst_org_date) >= year(getdate())-1
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

union all

select 
'Z.Total' as 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and Year(wkr_mst_org_date) >= year(getdate())-1
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by  Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)


union all

select 
Statecode 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','2.WO Completed' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('CMP','CLO','CNX','BER')
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)
--order by Year(wkr_mst_org_date) , Datename(MONTH,wkr_mst_org_date) 

union all

select 
'Z.Total' as 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '2.WO Completed' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('CMP','CLO','CNX','BER')
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by  Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

union all

select 
Statecode 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','3.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

union all

select 
'Z.Total' as 'State Name',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '3.WO Pending' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and Year(wkr_mst_org_date) >= year(getdate())-1
and wko_mst_status in ('OPE','RFS')
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
group by  Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)




