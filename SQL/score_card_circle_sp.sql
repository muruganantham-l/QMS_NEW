alter proc score_card_circle_sp
@state_code varchar(100) = 'jhr'
,@eqip_type varchar(100) = 'existing'
as
begin
set nocount on
--drop table test
--select @state_code '@@distict_code',@eqip_type '@eqip_type' into test
 
 --select @state_code = statename from score_card_PRM_tbl (NOLOCK)
 --where district_code = @state_code
--SELECT * INTO score_card_circle_tbl FROM score_card_circle_tbl
declare @year int = year(getdate())-- @year-- 
truncate table Scorecard_view_All_circle_temp
truncate table score_card_circle_tbl
--alter table score_card_circle_tbl
--add   statename varchar(50)
insert score_card_circle_tbl
(
circlename--
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
,statename
)
SELECT
circle_code
,ast_mst_asset_no
,equipment_type
,wkr_mst_org_date
,year_wo
,month_wo
,wko_mst_status
,ast_det_varchar22
,wo_type
,ast_mst_parent_id
 
,wo_no
,wko_mst_ast_cod
,statename
from score_card_tbl (NOLOCK)
where statename = @state_code
and equipment_type = @eqip_type

/*
select 
wko_mst_work_area 'circle Name'
,ast_mst_asset_no
,null
--,case when ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
--when ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
--else null end 'Equip.Type'
,cast(wko_mst_org_date as date)
, Year(wko_mst_org_date) 'Year OF WO' 
,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date) 'Month OF WO'
,wko_mst_status
,ast_det_varchar22
,left(wko_mst_wo_no,3)
,ast_mst_parent_id
,wko_mst_wo_no
,wko_mst_ast_cod
--, '1.WO Received' Types ,Count(wko_mst_wo_no) 'NumberOf WO' 
from wko_mst (nolock) 
,Stock_Location_mst_report (nolock)
,wko_det (nolock)
--,wkr_mst (nolock)
,ast_mst (nolock)
,ast_det (NOLOCK)
where wko_mst.site_cd = wko_det.site_cd
and wko_mst.RowID = wko_det.mst_RowID
and left(wko_mst_wo_no,3) = 'pwo'
--and wkr_mst.site_cd = wko_det.site_cd
--and wko_det_wr_no = wkr_mst.wkr_mst_wr_no
and ast_mst.site_cd    = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and ast_mst_ast_lvl = SatateDesc
and Year(wko_mst_org_date) >= @year
 
 and Statecode = @state_code

and ast_mst.RowID = ast_det.mst_RowID
 

update  score_card_circle_tbl
set  equipment_type = case when  ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
when ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
else  ast_det_varchar22 end


update  score_card_circle_tbl
set  equipment_type = case when  d.ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING' ) then 'Existing' 
when d.ast_det_varchar22 in ('NEW', 'PUR'  ) then 'New & Purchase'
else  d.ast_det_varchar22 end
from  score_card_circle_tbl a join ast_mst m on a.ast_mst_parent_id = m.ast_mst_asset_no and a.equipment_type = 'NA'
join ast_det d on m.RowID = d.mst_RowID
 
 */
update a
set		mr_no	=	m.mtr_mst_mtr_no
from score_card_circle_tbl a join mtr_mst m on m.mtr_mst_wo_no = a.wo_no
--alter table Scorecard_view_All_circle_temp add state_code varchar(50)
insert Scorecard_view_All_circle_temp
(
[circle Name]
,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,[NumberOf WO]
,state_code
)
--all
SELECT s.circlename,equipment_type,year_wo,month_wo,'1.WO Received' Types ,Count(wo_no) 'NumberOf WO',max(statename)
from score_card_circle_tbl (NOLOCK) s
where wo_type = 'cwo'
and equipment_type = @eqip_type
GROUP by s.circlename,equipment_type,year_wo,month_wo
--all pending 
union ALL
SELECT s.circlename,equipment_type,year_wo,month_wo,'2.WO Pending'   Types ,Count(wo_no) 'NumberOf WO',max(statename)
from score_card_circle_tbl (NOLOCK) s
where wo_type = 'cwo'
and equipment_type = @eqip_type
and  wko_mst_status in ('OPE','RFS')
GROUP by s.circlename,equipment_type,year_wo,month_wo

--pending without mr
union ALL
SELECT s.circlename,equipment_type,year_wo,month_wo,'3.WO Pending without MR'   Types ,Count(wo_no) 'NumberOf WO',max(statename)
from score_card_circle_tbl (NOLOCK) s
where wo_type = 'cwo'
and equipment_type = @eqip_type
and  wko_mst_status in ('OPE','RFS')
and mr_no is null
GROUP by s.circlename,equipment_type,year_wo,month_wo



/*--commented by murugan for performance tuning
insert Scorecard_view_All_circle_temp

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
--and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA') -- commented based on haresh sir
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
--and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(wko_mst_org_date) ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date)
--having  Count(wko_mst_wo_no) > 0

UNION ALL
select 
Statecode 'State Name','New & Purchase' 'Equip.Type' , Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+ Datename(MONTH,wko_mst_org_date) 'Month OF WO', '1.PWO Scheduled' Types ,Count(wko_mst_wo_no) 'NumberO





f 



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
Statecode 'State Name','New & Purchase' 'Equip.Type',  Year(wko_mst_org_date) 'Year OF WO' ,right('00' +Convert(varchar,Month(wko_mst_org_date)),2)+'.'+Datename(MONTH,wko_mst_org_date) 'Month OF WO','2.PWO Pending' Types, Count(wko_mst_wo_no) 'NumberOf WO





'


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



--delete v1 from Scorecard_view_All_circle_temp v1 where
--not EXISTS (SELECT '' from Scorecard_view_All_circle_temp v2 (nolock) where v1.[Year OF WO] = v2.[Year OF WO] and v1.[Month OF WO] = v2.[Month OF WO]
--and v1.[circle Name] = v2.[circle Name] and v1.[Equip.Type] = v2.[Equip.Type]   and v2.Types='2.PWO Pending' and v2.[NumberOf WO] > 0)
 
 */--commented by murugan for performance tuning

 
delete v1 from Scorecard_view_All_circle_temp v1 where
not EXISTS (SELECT '' from Scorecard_view_All_circle_temp v2 (nolock) where v1.[Year OF WO] = v2.[Year OF WO] and v1.[Month OF WO] = v2.[Month OF WO]
and v1.state_code = v2.state_code and v1.[Equip.Type] = v2.[Equip.Type]   and v2.Types='2.WO Pending' and v2.[NumberOf WO] > 0)

 insert Scorecard_view_All_circle_temp
 (
[circle Name]
,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,[NumberOf WO]
,state_code
 )
 SELECT 'Z.Total'
 ,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,sum([NumberOf WO])
,max(state_code)
from Scorecard_view_All_circle_temp (NOLOCK)
group by [Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
 
SELECT  

[circle Name][circle Name]
,[Equip.Type]
,[Year OF WO]
,[Month OF WO]
,[Types]
,[NumberOf WO]


 from Scorecard_view_All_circle_temp (NOLOCK) t 
 --join circle_desc_qms d on t.[circle Name] =d.circle_desc
 
 --alter table Scorecard_view_All_circle_temp alter column types varchar(20)
--where [Year OF WO] = 2017 
 
set nocount OFF
end









