alter  proc ppm_pwo_clo_date_update
as
begin
set nocount on
declare @sysdate date = getdate()

update m set  m.prm_mst_lpm_date = a.wko_mst_org_date
,m.prm_mst_lpm_closed_date = iif(a.wko_det_clo_date = '2030-12-12',null,a.wko_det_clo_date)
,prm_mst_next_due = case when  m.prm_mst_freq_code = 2 then  dateadd(MONTH,6,a.wko_mst_org_date) else dateadd(year,1,a.wko_mst_org_date) end
,prm_mst_next_create = dateadd(dd,-m.prm_mst_lead_day, case when  m.prm_mst_freq_code = 2 then  dateadd(MONTH,6,a.wko_mst_org_date) else dateadd(year,1,a.wko_mst_org_date) end)
,prm_mst_curr_wo = NULL
from (
SELECT pm.prm_mst_pm_no ,max(m.wko_mst_org_date) wko_mst_org_date,max(isnull(d.wko_det_clo_date,'2030-12-12')) wko_det_clo_date 
from prm_mst pm (NOLOCK) join prm_det pd (NOLOCK) on pm.RowID = pd.mst_RowID 
join wko_det d (NOLOCK) on pm.prm_mst_pm_no = d.wko_det_pm_idno
join wko_mst (NOLOCK) m on m.RowID = d.mst_RowID
and m.wko_mst_status = 'clo'
and cast(d.wko_det_clo_date as DATE) = @sysdate
--and prm_mst_pm_no = 'PRM127029'
 group by prm_mst_pm_no 
 ) a
 join prm_mst m (NOLOCK) on m.prm_mst_pm_no = a.prm_mst_pm_no

 
update d set  pur_det_varchar14 = pur_ls1_supplier  from pur_mst m (nolock) join pur_det d on m.rowid  = d.mst_rowid
join pur_ls1 (nolock) l on m.rowid = l.mst_rowid
 

update d set  pur_det_varchar14 = sup_mst_desc from pur_det d join sup_mst (nolock) s on  pur_det_varchar14 = sup_mst_supplier_cd

 set NOCOUNT OFF
 end

