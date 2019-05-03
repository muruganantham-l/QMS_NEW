alter proc score_card_sp
 
as
begin
set nocount on
declare @year int = year(getdate()) - 1
,@sysdate date = eomonth(getdate())

truncate table Scorecard_view_All_temp
truncate table score_card_tbl
--alter table score_card_tbl
--alter column   district_code varchar(500)
insert score_card_tbl
(
statename--
,ast_mst_asset_no--
,equipment_type -- no
,wkr_mst_org_date
,year_wo
,month_wo
,wko_mst_status
,ast_det_varchar22
,wo_type
,ast_mst_parent_id
 
,wo_no
,wko_mst_ast_cod
,district_code
,circle_code
)



select 
ast_mst_ast_lvl 'State Name'
,ast_mst_asset_no
,null
--,case when ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
--when ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
--else null end 'Equip.Type'
,cast(isnull(wko_det_datetime1,wko_mst_org_date) as date)
, Year(isnull(wko_det_datetime1,wko_mst_org_date)) 'Year OF WO' 
,right('00' +Convert(varchar,Month(isnull(wko_det_datetime1,wko_mst_org_date))),2)+'.'+ Datename(MONTH,isnull(wko_det_datetime1,wko_mst_org_date)) 'Month OF WO'
,wko_mst_status
,ast_det_varchar22
,left(wko_mst_wo_no,3)
,ast_mst_parent_id
,wko_mst_wo_no
,wko_mst_ast_cod
--, '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO' 
,wko_mst_asset_location
,wko_mst.wko_mst_work_area
from wko_mst (nolock) 
--,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
--,district_desc_qms d (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'cwo'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
--and ast_mst_ast_lvl = SatateDesc
and Year( isnull(wko_det_datetime1,wko_mst_org_date)) >= @year
and cast(isnull(wko_det_datetime1,wko_mst_org_date) as date) <= @sysdate
 --and d.district_desc = wko_mst.wko_mst_asset_location
and ast_mst.RowID = ast_det.mst_RowID

 
 --and ast_mst_ast_lvl = 'perak'

  update t set t.statename = s.Statecode
 from  
 score_card_tbl t (NOLOCK) join
 Stock_Location_mst_report s (nolock) on t.statename = s.SatateDesc

 update t set district_code = d.district_code
 from score_card_tbl t (NOLOCK)
 join district_desc_qms d (NOLOCK) on t.district_code = d.district_desc


update  score_card_tbl
set  equipment_type = case when  ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
when ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
else  ast_det_varchar22 end


update  score_card_tbl
set  equipment_type = case when  d.ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
when d.ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
else  d.ast_det_varchar22 end
from  score_card_tbl a join ast_mst m on a.ast_mst_parent_id = m.ast_mst_asset_no and a.equipment_type = 'NA'
join ast_det d on m.RowID = d.mst_RowID
 

update a
set		mr_no	=	m.mtr_mst_mtr_no
from score_card_tbl a join mtr_mst m on m.mtr_mst_wo_no = a.wo_no

insert Scorecard_view_All_temp
(
[State Name]
,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,[NumberOf WO]
)
--all
SELECT s.statename,equipment_type,year_wo,month_wo,'1.WO Received' Types ,Count(wo_no) 'NumberOf WO'
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
GROUP by s.statename,equipment_type,year_wo,month_wo
--all pending 
union ALL
SELECT s.statename,equipment_type,year_wo,month_wo,'2.WO Pending'   Types ,Count(wo_no) 'NumberOf WO'
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and  wko_mst_status in ('OPE','RFS')
GROUP by s.statename,equipment_type,year_wo,month_wo

--pending without mr
union ALL
SELECT s.statename,equipment_type,year_wo,month_wo,'3.WO Pending without MR'   Types ,Count(wo_no) 'NumberOf WO'
from score_card_tbl (NOLOCK) s
where wo_type = 'cwo'
and  wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by s.statename,equipment_type,year_wo,month_wo


--SELECT * from score_card_tbl where  equipment_type is null
--alter table Scorecard_view_All_temp drop column  wkr_mst_org_date datetime
/* commented by murugan for performance tuning
insert Scorecard_view_All_temp

select 
Statecode 'State Name','Existing' 'Equip.Type' , Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO' 
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
--and ast_det_varchar15 is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in ( 'Existing','Accessories')-- is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

UNION ALL


select 
Statecode 'State Name','Existing' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO' 
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
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
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in ( 'Existing','Accessories')-- is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)
--having  Count(wko_mst_wo_no) > 0

--added by murugan for no mr wo pending
UNION ALL


select 
Statecode 'State Name','Existing' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','3.WO Pending without MR' Types, Count(wko_mst_wo_no) 'NumberO



f WO' 
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK) 
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
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in ( 'Existing','Accessories')-- is not null-- in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
 and not exists (
SELECT '' 
from mtr_mst m (NOLOCK)
where m.mtr_mst_wo_no = wko_mst.wko_mst_wo_no 
)
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)
--having  Count(wko_mst_wo_no) > 0

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type' , Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date) 'Month OF WO', '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf 



WO' 
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
and wkr_mst.site_cd = wko_det.site_cd
and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wkr_mst_org_date) >= year(getdate())-1
--and ast_mst_create_by in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','2.WO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO'





 
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK)
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
--and ast_mst_create_by in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wkr_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+Datename(MONTH,wkr_mst_org_date) 'Month OF WO','3.WO Pending without MR' Types, Count(wko_mst_wo_no) 'N



umberOf WO'
 


from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
,wkr_mst (nolock)
,ast_mst (nolock),ast_det (NOLOCK) 
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
--and ast_mst_create_by in ('Patch')
and ast_mst.RowID = ast_det.mst_RowID
--and ast_det_varchar15 is not null--in   ('New Biomedical','Purchase Biomedical','Existing','Accessories')
--and ast_det_varchar15 in   ('New Biomedical','Purchase Biomedical','Accessories')
and ast_det_varchar22 in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
 
and not exists (
SELECT '' 
from mtr_mst m (NOLOCK)
where m.mtr_mst_wo_no = wko_mst.wko_mst_wo_no 
)
group by Statecode , Year(wkr_mst_org_date) ,right('00' +Convert(varchar,Month(wkr_mst_org_date)),2)+'.'+ Datename(MONTH,wkr_mst_org_date)


--commented by murugan for performance tuning*/

delete v1 from Scorecard_view_All_temp v1 where
not EXISTS (SELECT '' from Scorecard_view_All_temp v2 (nolock) where v1.[Year OF WO] = v2.[Year OF WO] and v1.[Month OF WO] = v2.[Month OF WO]
and v1.[State Name] = v2.[State Name] and v1.[Equip.Type] = v2.[Equip.Type]   and v2.Types='2.WO Pending' and v2.[NumberOf WO] > 0)
--and v1.[State Name] <> 'Z.Total'
 
 insert Scorecard_view_All_temp
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
from Scorecard_view_All_temp
group by [Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]

SELECT * from Scorecard_view_All_temp (NOLOCK)
 
--where [Year OF WO] = 2017 

set nocount OFF
end


--alter table Scorecard_view_All_temp alter column types varchar(50)




