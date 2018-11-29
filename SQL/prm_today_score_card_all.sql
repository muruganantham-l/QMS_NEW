ALTER proc prm_today_score_card_all
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount ON
declare @sysdate date = getdate()

truncate table prmToday_scorecard_all
--select * into prmToday_scorecard_all from Today_scorecard_all


insert prmToday_scorecard_all
select 
Statecode 'State Name','Existing' 'Equip.Type' , Year(prm_mst_pm_date) 'Year OF PM' ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date) 'Month OF PM', '1.PM Received' Types ,Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and cast(p.prm_mst_pm_date as date) = @sysdate
and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(prm_mst_pm_date) ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date)

UNION ALL


select 
Statecode 'State Name','Existing' 'Equip.Type',  Year(prm_mst_pm_date) 'Year OF PM' ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+Datename(MONTH,prm_mst_pm_date) 'Month OF PM','2.PM Pending' Types, Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and cast(p.prm_mst_pm_date as date) = @sysdate
and ast_det_varchar22 in ('PUR-EX', 'NEW-BE' ,'EXISTING','NA')
and prm_mst_dflt_status = 'ope'
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(prm_mst_pm_date) ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date)

UNION ALL

select 
Statecode 'State Name','New & Purchase' 'Equip.Type' , Year(prm_mst_pm_date) 'Year OF PM' ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date) 'Month OF PM', '1.PM Received' Types ,Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and cast(p.prm_mst_pm_date as date) = @sysdate
and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
group by Statecode , Year(prm_mst_pm_date) ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date)

 
UNION ALL
 
select 
Statecode 'State Name','New & Purchase' 'Equip.Type' , Year(prm_mst_pm_date) 'Year OF PM' ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date) 'Month OF PM', '2.PM Pending' Types ,Count(prm_mst_pm_no) 'NumberOf PM'

from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and cast(p.prm_mst_pm_date as date) = @sysdate
and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and prm_mst_dflt_status = 'ope'
group by Statecode , Year(prm_mst_pm_date) ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date)


SELECT * from prmToday_scorecard_all (NOLOCK) where [Equip.Type] = @equip_type

set nocount OFF
end