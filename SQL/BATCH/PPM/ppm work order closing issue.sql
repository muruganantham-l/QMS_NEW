--select * from prm_mst where prm_mst_pm_no =

--'prm173424'

--SELECT * INTO PRM_score_card_district_tbl FROM score_card_district_tbl

--perak_2019


--update m set wko_mst_org_date = wo_date,wko_mst_due_date = EOMONTH ( wo_date ) from wko_mst m join 
--perak_2019 l on l.wo_number = m.wko_mst_wo_no
--alter table pm_2019 add wo_number varchar(200)

update s set wo_number = wko_mst_wo_no
from  pm_2019 s join (
SELECT pm_no,  wko_mst_org_date,m.wko_mst_wo_no
 from wko_mst m join wko_det d on m.RowID = d.mst_RowID join  pm_2019 a
on d.wko_det_pm_idno = a.pm_no
and m.wko_mst_status = 'clo'
and wko_mst_org_date = wo_date
and left( wko_mst_wo_no ,3) = 'pwo'
--and pm_no = 'PRM116928'
--group by pm_no

) a on s.pm_no = a.pm_no

--alter table pm_2019 add wo_sts_flag varchar(10)


update w SET wko_sts_end_date = dateadd(MINUTE,4, wko_det_clo_date) from pm_2019 p join wko_sts w on p.wo_number = w.wko_sts_wo_no 
 join wko_det d on w.mst_rowid = d.mst_RowID where  wko_sts_status = 'CMP'

SELECT d.wko_det_cmpl_date,d.wko_det_clo_date,w.wko_sts_start_date,w.wko_sts_end_date, * 
from wko_sts w join 
wko_det d on w.mst_rowid = d.mst_RowID where  wko_sts_status = 'clo'

insert wko_sts
 (
site_cd
,mst_RowID
,wko_sts_wo_no
,wko_sts_status
,wko_sts_originator
,wko_sts_start_date
,wko_sts_end_date
,wko_sts_duration
,audit_user
,audit_date
)

SELECT 'QMS',m.RowID,M.wko_mst_wo_no,'CLO','tomms', dateadd(minute,4,wko_det_clo_date) , null,null,'tomms',getdate()
FROM WKO_MST M
join (

select 'PWO313756' wo_number union
SELECT 'PWO314200' union
SELECT 'PWO313709' union
SELECT 'PWO313745' union
SELECT 'PWO313659' union
SELECT 'PWO314179' union
SELECT 'PWO313360' union
SELECT 'PWO314256' union
SELECT 'PWO313778' union
SELECT 'PWO313853' union
SELECT 'PWO314123' union
SELECT 'PWO313652' union
SELECT 'PWO314152' union
SELECT 'PWO314154' union
SELECT 'PWO314190' union
SELECT 'PWO375091'
) P



 on m.wko_mst_wo_no = p.wo_number join wko_det d on m.RowID = d.mst_RowID

SELECT * from wko_sts where wko_sts_status = 'clo'

SELECT * from pm_2019 where 
wo_number is null

 SELECT * from pm_2019  where pm_no =  'prm116189'


 SELECT * from pm_2019


 SELECT * into pm_2019_bak from pm_2019

 update pm_2019_bak set wo_number = null,wo_date = null

 SELECT pm_no,  wko_mst_org_date,m.wko_mst_wo_no
 from wko_mst m join wko_det d on m.RowID = d.mst_RowID join  pm_2019 a
on d.wko_det_pm_idno = a.pm_no
and m.wko_mst_status = 'cmp'

update d set wko_det_wo_open = 'N',
  wko_det_clo_date = dateadd(minute,5,wko_det_cmpl_date)
  
  update m set wko_mst_status = 'CLO'
   from wko_mst m join wko_det d on m.RowID = d.mst_RowID

where m.wko_mst_wo_no in 
(

'PWO313756'
,'PWO314200'
,'PWO313709'
,'PWO313745'
,'PWO313659'
,'PWO314179'
,'PWO313360'
,'PWO314256'
,'PWO313778'
,'PWO313853'
,'PWO314123'
,'PWO313652'
,'PWO314152'
,'PWO314154'
,'PWO314190'
,'PWO375091'
)




update w SET wko_sts_end_date = dateadd(MINUTE,4, wko_det_clo_date) from --pm_2019 p 
(

select 'PWO313756' wo_number union
SELECT 'PWO314200' union
SELECT 'PWO313709' union
SELECT 'PWO313745' union
SELECT 'PWO313659' union
SELECT 'PWO314179' union
SELECT 'PWO313360' union
SELECT 'PWO314256' union
SELECT 'PWO313778' union
SELECT 'PWO313853' union
SELECT 'PWO314123' union
SELECT 'PWO313652' union
SELECT 'PWO314152' union
SELECT 'PWO314154' union
SELECT 'PWO314190' union
SELECT 'PWO375091'
) P
join wko_sts w on p.wo_number = w.wko_sts_wo_no 
 join wko_det d on w.mst_rowid = d.mst_RowID where  wko_sts_status = 'CMP'

  prm_mst pm (NOLOCK) join prm_det pd (NOLOCK) on pm.RowID = pd.mst_RowID 
join wko_det d (NOLOCK) on pm.prm_mst_pm_no = d.wko_det_pm_idno
join wko_mst (NOLOCK) m on m.RowID = d.mst_RowID
join 
(

select 'PWO313756' wo_number union
SELECT 'PWO314200' union
SELECT 'PWO313709' union
SELECT 'PWO313745' union
SELECT 'PWO313659' union
SELECT 'PWO314179' union
SELECT 'PWO313360' union
SELECT 'PWO314256' union
SELECT 'PWO313778' union
SELECT 'PWO313853' union
SELECT 'PWO314123' union
SELECT 'PWO313652' union
SELECT 'PWO314152' union
SELECT 'PWO314154' union
SELECT 'PWO314190' union
SELECT 'PWO375091'
) P on p.wo_number = m.wko_mst_wo_no