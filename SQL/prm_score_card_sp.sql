ALTER proc prm_score_card_sp
as
begin
set nocount on
declare @year int = year(getdate())-1 
truncate table prm_Scorecard_view_All_temp

--select * into prm_Scorecard_view_All_temp from Scorecard_view_All_temp
insert prm_Scorecard_view_All_temp

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
and Year(p.prm_mst_pm_date) >= @year
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
and Year(p.prm_mst_pm_date) >= @year
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
and Year(p.prm_mst_pm_date) >= @year
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
and Year(p.prm_mst_pm_date) >= @year
and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and prm_mst_dflt_status = 'ope'
group by Statecode , Year(prm_mst_pm_date) ,right('00' +Convert(varchar,Month(prm_mst_pm_date)),2)+'.'+ Datename(MONTH,prm_mst_pm_date)



delete v1 from prm_Scorecard_view_All_temp v1 where
not EXISTS (SELECT '' from prm_Scorecard_view_All_temp v2 (nolock) where v1.[Year OF WO] = v2.[Year OF WO] and v1.[Month OF WO] = v2.[Month OF WO]
and v1.[State Name] = v2.[State Name] and v1.[Equip.Type] = v2.[Equip.Type]   and v2.Types='2.PM Pending' and v2.[NumberOf WO] > 0)
--and v1.[State Name] <> 'Z.Total'
 
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
 
--where [Year OF WO] = 2017 

set nocount OFF
end



