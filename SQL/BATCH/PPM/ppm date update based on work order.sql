

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
,prm_mst_next_due = case when  m.prm_mst_freq_code = 2 then  dateadd(MONTH,6,a.wko_mst_org_date) else dateadd(year,1,a.wko_mst_org_date) end
,prm_mst_next_create = dateadd(dd,-m.prm_mst_lead_day, case when  m.prm_mst_freq_code = 2 then  dateadd(MONTH,6,a.wko_mst_org_date) else dateadd(year,1,a.wko_mst_org_date) end)
from (
SELECT pm.prm_mst_pm_no ,max(m.wko_mst_org_date) wko_mst_org_date,max(isnull(d.wko_det_clo_date,'2030-12-12')) wko_det_clo_date 
from prm_mst pm (NOLOCK) join prm_det pd (NOLOCK) on pm.RowID = pd.mst_RowID 
join wko_det d (NOLOCK) on pm.prm_mst_pm_no = d.wko_det_pm_idno
join wko_mst (NOLOCK) m on m.RowID = d.mst_RowID
and m.wko_mst_status = 'clo'
--and prm_mst_pm_no = 'PRM127029'
 group by prm_mst_pm_no 
 ) a
 join prm_mst m (NOLOCK) on m.prm_mst_pm_no = a.prm_mst_pm_no
 and m.prm_mst_pm_no ---= 'PRM127029'
  
in 

(
'PRM100918'
,'PRM100229'
,'PRM105526'
,'PRM102849'
,'PRM103003'
,'PRM103657'
,'PRM106058'
,'PRM105577'
,'PRM170330'
,'PRM169884'
,'PRM105807'
,'PRM105928'
,'PRM106160'
,'PRM106129'
,'PRM101672'
,'PRM103115'
,'PRM100410'
,'PRM102022'
,'PRM100641'
,'PRM100409'
,'PRM100292'
,'PRM106057'
,'PRM170439'
,'PRM106157'
,'PRM103626'
,'PRM103811'
,'PRM101026'
,'PRM103631'
,'PRM102439'
,'PRM100006'
,'PRM100927'
,'PRM105883'
,'PRM103460'
,'PRM102852'
,'PRM103651'
,'PRM105886'
,'PRM102403'
,'PRM105883'
,'PRM100237'
,'PRM100868'
,'PRM106061'
,'PRM106060'
,'PRM106106'
,'PRM103631'
,'PRM102439'
,'PRM102403'
,'PRM101026'
,'PRM170448'
,'PRM169885'
,'PRM169893'
,'PRM170954'
,'PRM170447'
,'PRM105870'
,'PRM170076'
,'PRM102554'
,'PRM106266'
,'PRM103379'
,'PRM104950'
,'PRM170286'
,'PRM169816'
,'PRM170776'
,'PRM104926'
,'PRM106227'
,'PRM102407'
,'PRM100930'
,'PRM100755'
,'PRM101951'
,'PRM102851'
,'PRM102958'
,'PRM104658'
,'PRM106104'
,'PRM169896'
,'PRM170920'
,'PRM169964'
,'PRM103543'
,'PRM102952'
,'PRM102823'
,'PRM101899'
,'PRM102218'
,'PRM104331'
,'PRM101000'
,'PRM100926'
,'PRM100408'
,'PRM100291'
,'PRM100921'
,'PRM171066'
,'PRM170212'
,'PRM171132'
,'PRM103544'
,'PRM104286'
,'PRM106301'
,'PRM101899'
,'PRM104286'
,'PRM170062'
,'PRM171108'
,'PRM102959'
,'PRM103378'
,'PRM101301'
,'PRM101296'
,'PRM101606'
,'PRM102114'
,'PRM105351'
,'PRM100864'
,'PRM106111'
,'PRM102422'
,'PRM171090'
,'PRM170557'
,'PRM170320'
,'PRM101296'
,'PRM102114'
,'PRM103309'
,'PRM102827'
,'PRM101429'
,'PRM100916'
,'PRM100075'
,'PRM100922'
,'PRM100639'
,'PRM101303'
,'PRM101429'
,'PRM170240'
,'PRM170267'
,'PRM170307'
,'PRM103242'
,'PRM171095'
) 

COMMIT