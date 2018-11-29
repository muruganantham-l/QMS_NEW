ALTER proc prm_score_card_sp
as
begin
set nocount on
declare @year int = year(getdate())-- @year-- 
truncate table prm_Scorecard_view_All_temp


insert prm_Scorecard_view_All_temp

select 
Statecode 'State Name','Existing' 'Equip.Type' , Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date) 'Month OF WO', '1.PWO Scheduled' Types ,Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
 
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wko_mst_org_date) >= @year
--and ast_mst_create_by not in ('Patch')

and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar15 in ( 'Existing','Accessories')-- is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA') -- commented based on haresh sir
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wko_mst_org_date) ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date)

UNION ALL


select 
Statecode 'State Name','Existing' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+Datename(MONTH,wko_mst_org_date) 'Month OF WO','2.PWO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
 
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wko_mst_org_date) >= @year
and wko_mst_status in ('OPE','RFS')
--and ast_mst_create_by not in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar15 in ( 'Existing','Accessories')-- is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wko_mst_org_date) ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date)
--having  Count(wko_mst_wo_no) > 0

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type' , Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date) 'Month OF WO', '1.PWO Scheduled' Types ,Count(wko_mst_wo_no) 'NumberOf 



WO'
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
 
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wko_mst_org_date) >= @year
--and ast_mst_create_by in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wko_mst_org_date) ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date)

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+Datename(MONTH,wko_mst_org_date) 'Month OF WO','2.PWO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'


from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'PWO'
 
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wko_mst_org_date) >= @year
and wko_mst_status in ('OPE','RFS')
--and ast_mst_create_by in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
--and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wko_mst_org_date) ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date)



--delete v1 from prm_Scorecard_view_All_temp v1 where
--not EXISTS (SELECT '' from prm_Scorecard_view_All_temp v2 (nolock) where v1.[Year OF WO] = v2.[Year OF WO] and v1.[Month OF WO] = v2.[Month OF WO]
--and v1.[State Name] = v2.[State Name] and v1.[Equip.Type] = v2.[Equip.Type]   and v2.Types='2.PWO Pending' and v2.[NumberOf WO] > 0)
 
 
 insert prm_Scorecard_view_All_temp
 (
[State Name]
,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,[NumberOf WO]
 )
 SELECT 'Z.Total'
 ,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,sum([NumberOf WO])
from prm_Scorecard_view_All_temp
group by [Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
 
SELECT * from prm_Scorecard_view_All_temp (NOLOCK)
 
 --alter table prm_Scorecard_view_All_temp alter column types varchar(20)
--where [Year OF WO] = 2017 

set nocount OFF
end



