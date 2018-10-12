
select left(prm_mst_assetno,3) [State Name] , prm_mst_assetno , prm_mst_curr_wo , prm_mst_next_due , prm_mst_assetlocn from prm_mst
where prm_mst_assetno in (
select 
wko_mst_assetno --, count(wko_mst_wo_no) tot
from wko_mst (nolock) ,
wko_det (nolock)
where  wko_det.site_cd = wko_mst.site_cd
and wko_det.mst_rowid = wko_mst.rowid
and wko_mst.site_cd = 'QMS'
and left(wko_mst_wo_no,3) = 'PWO'
and year(wko_mst_org_date)= 2017
and wko_mst_assetno in (select prm_mst_assetno from prm_mst (nolock) where site_cd = 'QMS' and prm_mst_freq_code = 2 and prm_mst_dflt_status = 'OPE')
group by wko_mst_assetno
having count(wko_mst_wo_no) = 1
)
and year(prm_mst_next_due ) = 2017
and site_cd= 'QMS'
and prm_mst_curr_wo is not null
and month(prm_mst_next_due) < 7
order by left(prm_mst_assetno,3) 

JHR020247

prm_mst (nolock) 
where site_cd = 'QMS' 
--and prm_mst_freq_code = 2 
and prm_mst_dflt_status = 'OPE'
--and  year(prm_mst_next_due ) = 2017
--and month(prm_mst_next_due) < 7
and prm_mst_curr_wo is not null
and prm_mst_curr_wo in (select wko_mst_wo_no from wko_mst (nolock) where year(wko_mst_org_date) = 2018)

select   asset_number,
newPwonumber,
oldpwonumber,
completiondate
from 
ppm_completion_table (nolock)
where convert(date,createtime ) = convert(date,getdate())

--PWO267617

