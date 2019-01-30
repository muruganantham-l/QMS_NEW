

--select  


--PM_NO
--,LPM_Date,cast(LPM_Date as date)
--,Lead_Create_Date
--,Next_Creation_Date

--from perak_pwo_date	


--drop table perak_pwo_date

--perak_pwo_date


--update m set m.prm_mst_lpm_date = LPM_Date,m.prm_mst_next_create=Lead_Create_Date,m.prm_mst_next_due=Next_Creation_Date
-- from prm_mst m
-- join  perak_pwo_date p on m.prm_mst_pm_no = p.pm_no
begin tran
update m set  m.prm_mst_lpm_date = a.wko_mst_org_date
,m.prm_mst_lpm_closed_date = iif(a.wko_det_clo_date = '2030-12-12',null,a.wko_det_clo_date)
,prm_mst_next_due = dateadd(MONTH,6,a.wko_mst_org_date)
,prm_mst_next_create = dateadd(dd,m.prm_mst_lead_day, dateadd(MONTH,6,a.wko_mst_org_date))
from (
SELECT pm.prm_mst_pm_no ,max(m.wko_mst_org_date) wko_mst_org_date,max(isnull(d.wko_det_clo_date,'2030-12-12')) wko_det_clo_date 
from prm_mst pm (NOLOCK) join prm_det pd (NOLOCK) on pm.RowID = pd.mst_RowID 
join wko_det d (NOLOCK) on pm.prm_mst_pm_no = d.wko_det_pm_idno
join wko_mst (NOLOCK) m on m.RowID = d.mst_RowID
--and m.wko_mst_status = 'clo'
--and prm_mst_pm_no = 'PRM127029'
 group by prm_mst_pm_no 
 ) a
 join prm_mst m (NOLOCK) on m.prm_mst_pm_no = a.prm_mst_pm_no
 and m.prm_mst_pm_no ---= 'PRM127029'
  
in 

(
'PRM107342'
,'PRM110579'
,'PRM110714'
,'PRM110096'
,'PRM113796'
,'PRM166785'
,'PRM108597'
,'PRM166770'
,'PRM166769'
,'PRM113304'
,'PRM110097'
,'PRM108599'
,'PRM110510'
,'PRM110098'
,'PRM110208'
,'PRM111040'
,'PRM110449'
,'PRM110548'
,'PRM110761'
,'PRM110101'
,'PRM110755'
,'PRM110448'
,'PRM107883'
,'PRM110095'
,'PRM113362'
,'PRM110134'
,'PRM110102'
,'PRM110789'
,'PRM110580'
,'PRM110539'
,'PRM108601'
,'PRM110207'
,'PRM110994'
,'PRM167483'
,'PRM110766'
,'PRM110790'
,'PRM110253'
,'PRM110254'
,'PRM110866'
,'PRM113795'
,'PRM110715'
,'PRM110184'
,'PRM110902'
,'PRM113379'
,'PRM107885'
,'PRM110717'
,'PRM110534'
,'PRM110655'
,'PRM110210'
,'PRM110181'
,'PRM110212'
,'PRM110724'
,'PRM110740'
,'PRM110186'
,'PRM110759'
,'PRM107470'
,'PRM110213'
,'PRM110943'
,'PRM110180'
,'PRM110771'
,'PRM106451'
,'PRM110720'
,'PRM106447'
,'PRM166822'
,'PRM107389'
,'PRM110739'
,'PRM110758'
,'PRM110285'
,'PRM110340'
,'PRM106450'
,'PRM110211'
,'PRM110215'
,'PRM108260'
,'PRM166786'
,'PRM110532'
,'PRM106418'
,'PRM110953'
,'PRM108653'
,'PRM110757'
,'PRM110609'
,'PRM110704'


) 

COMMIT