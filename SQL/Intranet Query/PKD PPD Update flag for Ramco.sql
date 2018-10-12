select 
* from ast_mst (nolock) , 
ast_det (nolock)
where ast_mst.rowid = ast_det.mst_rowid
--and 
 
update ast_det
set ast_det_varchar23 = left(ast_mst_cost_center,3)+right(ast_mst_cost_center ,6) , audit_date = getdate()
from  ast_mst (nolock) , 
ast_det (nolock)
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar23 is NULL

update ast_det
set ast_det_varchar23 = cus_det_varchar2 --left(ast_mst_cost_center,3)+right(ast_mst_cost_center ,6) 
, audit_date = getdate()
from  ast_mst (nolock) , 
ast_det (nolock) ,
cus_mst (nolock) , 
	cus_det (nolock)
where ast_mst.rowid = ast_det.mst_rowid
and cus_mst.rowid = cus_det.mst_rowid
and ast_det_cus_code = cus_mst_customer_cd
and cus_det_varchar2 <> ast_det_varchar23
and ast_det_varchar23 is null


ast_det
where ast_det_varchar23 is null

ast_det_varchar22
EXISTING


PNG002975	PWO249047	PWO248965
PNG002959	PWO248538	PWO247225

update ppm_completion_table
set newPwonumber = 'PWO248965' , error_log = NULL
where asset_number = 'PNG002975'
and createtime = '2017-11-14 11:08:56.620'

update ppm_completion_table
set newPwonumber = 'PWO247225' , error_log = NULL
where asset_number = 'PNG002959'
and createtime = '2017-11-14 11:08:56.590'

select distinct cus_det_varchar2
from 
cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	update cus_det
	set cus_det_varchar2   = left(cus_mst_seller,3)+right(cus_mst_seller ,6) , audit_date = getdate()
	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_det_varchar2 is null

	="update cus_det	set cus_det_varchar2 = '"&&"' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 is NOT null and cus_det_city ='"&&"' and cus_mst_shipvia= 'KESIHATAN'"
	--and cus_det_varchar2='Exclusion Clinic'

--update cus_det set cus_det_varchar2 = 'WKL-K-CHS' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-K-KUL' and cus_det_city ='CHERAS'  and cus_mst_shipvia= 'KESIHATAN' 
--update cus_det set cus_det_varchar2 = 'WKL-K-KPG' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-K-KUL' and cus_det_city ='KEPONG'  and cus_mst_shipvia= 'KESIHATAN' 
--update cus_det set cus_det_varchar2 = 'WKL-K-LPT' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-K-KUL' and cus_det_city ='LEMBAH PANTAI'  and cus_mst_shipvia= 'KESIHATAN' 
--update cus_det set cus_det_varchar2 = 'WKL-K-TTW' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-K-KUL' and cus_det_city ='TITIWANGSA'  and cus_mst_shipvia= 'KESIHATAN' 
--update cus_det set cus_det_varchar2 = 'WKL-P-CHS' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-P-KUL' and cus_det_city ='CHERAS'  and cus_mst_shipvia= 'PERGIGIAN' 
--update cus_det set cus_det_varchar2 = 'WKL-P-KPG' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-P-KUL' and cus_det_city ='KEPONG'  and cus_mst_shipvia= 'PERGIGIAN' 
--update cus_det set cus_det_varchar2 = 'WKL-P-LPT' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-P-KUL' and cus_det_city ='LEMBAH PANTAI'  and cus_mst_shipvia= 'PERGIGIAN' 
--update cus_det set cus_det_varchar2 = 'WKL-P-PJA' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-P-KUL' and cus_det_city ='PUTRAJAYA'  and cus_mst_shipvia= 'PERGIGIAN' 
--update cus_det set cus_det_varchar2 = 'WKL-P-TTW' from cus_mst (nolock) , cus_det (nolock) where cus_mst.rowid = cus_det.mst_rowid and cus_det_varchar2 ='WKL-P-KUL' and cus_det_city ='TITIWANGSA'  and cus_mst_shipvia= 'PERGIGIAN' 

	update cus_det
	----set cus_det_varchar2='SWK-K-KCG'

	select distinct cus_det_city ,cus_det_varchar2

	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and left(cus_mst_seller,3)+right(cus_mst_seller ,6) <> cus_det_varchar2 --= 'SWK-K-BAU'

	update cus_det
	set cus_det_varchar2='SWK-K-KCG'
	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_det_varchar2 = 'SWK-K-LUU'

	update cus_det
	set cus_det_varchar2='SWK-K-BTG'
	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_det_varchar2 = 'SWK-K-STK'

	update cus_det
	set cus_det_varchar2='SWK-P-BTG'
	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_det_varchar2 = 'SWK-P-STK'

	update cus_det
	set cus_det_varchar2='SBH-K-PPG'
	from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_det_varchar2 = 'SBH-K-PUN'

	cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and cus_mst_seller like '%-PUN'

	559

	update ast_det
	set ast_det_varchar23 = cus_det_varchar2 
	from
	cus_mst (nolock) ,
	cus_det (nolock) ,
	ast_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid 
	and  ast_det_cus_code = cus_mst.cus_mst_customer_cd
	and  cus_det_city in ('CHERAS','KEPONG','LEMBAH PANTAI','TITIWANGSA','PUTRAJAYA' ,'LUNDU','BAU')
	and ast_det_varchar23 <> cus_det_varchar2 


	ast_det
	where ast_det_varchar23='SWK-K-LUN'

	select * from cus_mst (nolock) , 
	cus_det (nolock)
	where cus_mst.rowid = cus_det.mst_rowid
	and left(cus_mst_seller,3)+right(cus_mst_seller ,6) ='SWK-K-LUN'

	itm_mst
	where itm_mst_stockno = 'STK104651'

	itm_trx
	where itm_trx_stockno = 'STK104651'

ast_mst

alter table wkr_mst
alter column wko_isp 25


wko_det