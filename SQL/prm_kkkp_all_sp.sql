ALTER proc prm_kkkp_all_sp
 @equip_type varchar(50) = 'Existing'
as
begin
set nocount ON
declare @sysdate date = getdate()
,@year int = year(getdate())-1
--drop proc prm_kkkp_all
truncate table prm_kkkp_all
--select * into prm_kkkp_all from KKKP_ALL (nolock) where 1=2


insert prm_kkkp_all
select 
Statecode 'State Name'
,'Total' category
,'Existing' 'Equip.Type' ,
  Case 
							when pd.prm_det_varchar2 = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when prm_det_varchar2 = 'PERGIGIAN' 
							then 'Pending WO (KP)'end as Types
 ,Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and YEAR(p.prm_mst_pm_date ) >= @year
and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and P.prm_mst_dflt_status = 'ope'
group by Statecode , prm_det_varchar2
UNION ALL


select 
Statecode 'State Name'
,'Total' category
,'Existing' 'Equip.Type' ,
  'Pending WO (KP+KK)'  as Types
 ,Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and YEAR(p.prm_mst_pm_date ) >= @year
and ast_det_varchar22 in ('PUR-EX', 'NEW-EX' ,'EXISTING','NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and P.prm_mst_dflt_status = 'ope'
group by Statecode 

UNION ALL

select 
Statecode 'State Name'
,'Total' category
,'New & Purchase' 'Equip.Type'

,Case 
							when pd.prm_det_varchar2 = 'KESIHATAN' 
							then 'Pending WO (KK)'
							when prm_det_varchar2 = 'PERGIGIAN' 
							then 'Pending WO (KP)'end as Types

,Count(prm_mst_pm_no) 'NumberOf PM'
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
and YEAR(p.prm_mst_pm_date  ) >= @year
and P.prm_mst_dflt_status = 'ope'
group by Statecode , prm_det_varchar2

 
UNION ALL
 
select 
Statecode 'State Name'
,'Total' category
,'New & Purchase' 'Equip.Type'

,'Pending WO (KP+KK)'  as Types

,Count(prm_mst_pm_no) 'NumberOf PM'
from prm_mst (nolock) P
join prm_det pd (NOLOCK)
on p.RowID = pd.mst_RowID
join Stock_Location_mst_report (nolock) s
on s.SatateDesc = pd.prm_det_asset_level
join ast_mst (nolock) M
on m.ast_mst_asset_no = p.prm_mst_assetno
join ast_det (NOLOCK) D
on m.RowID = d.mst_RowID
and YEAR(p.prm_mst_pm_date ) >= @year
and ast_det_varchar22  in ('NEW', 'PUR' ,'NA')
and isnull(ast_mst_parent_id ,ast_mst_asset_no)= ast_mst_asset_no
and prm_mst_dflt_status = 'ope'
group by Statecode  


SELECT * from prm_kkkp_all (NOLOCK) where [Equip.Type] = @equip_type

set nocount OFF
end