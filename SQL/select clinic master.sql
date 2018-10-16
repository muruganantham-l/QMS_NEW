SELECT 
 m.cus_mst_customer_cd			'Clinic code'
,m.cus_mst_desc					'Clinic name'
,m.cus_mst_status			'Status'
,m.cus_mst_fob 'Clinic type'
,m.cus_mst_shipvia 'Clinic category'
,m.cus_mst_acct_no 'Region'
,m.cus_mst_seller 'Cost centre'
,d.cus_det_address1 'Clinic address'
,d.cus_det_province 'Zone'
,d.cus_det_state 'State'
,d.cus_det_city 'District'
,d.cus_det_email_id 'Circle'
,d.cus_det_contact1 'Clinic Contact No. 1:'
,d.cus_det_country 'Country'
,d.cus_det_varchar2 'Ramco pkd/ppd'
,d.cus_det_varchar3 'Clinic ownership'

from cus_mst m (NOLOCK)
join cus_det d on m.RowID =d.mst_RowID

/*

update m
set
  m.cus_mst_customer_cd	 =  replace(replace(REPLACE(cus_mst_customer_cd,char(9),''),CHAR(10),''),CHAR(13),'')
 ,m.cus_mst_desc		=  replace(replace(REPLACE(cus_mst_desc,char(9),''),CHAR(10),''),CHAR(13),'')	
 ,m.cus_mst_status		=  replace(replace(REPLACE(cus_mst_status,char(9),''),CHAR(10),''),CHAR(13),'')
 ,m.cus_mst_fob  = replace(replace(REPLACE(cus_mst_fob,char(9),''),CHAR(10),''),CHAR(13),'')
 ,m.cus_mst_shipvia = replace(replace(REPLACE(cus_mst_shipvia,char(9),''),CHAR(10),''),CHAR(13),'')
 ,m.cus_mst_acct_no  = replace(replace(REPLACE(cus_mst_acct_no,char(9),''),CHAR(10),''),CHAR(13),'')
 ,m.cus_mst_seller  = replace(replace(REPLACE(cus_mst_seller,char(9),''),CHAR(10),''),CHAR(13),'')


from   cus_mst m
 
 update d
 set
  d.cus_det_address1 =  replace(replace(REPLACE(cus_det_address1,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_province =  replace(replace(REPLACE(cus_det_province,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_state  =  replace(replace(REPLACE(cus_det_state,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_city  =  replace(replace(REPLACE(cus_det_city,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_email_id=  replace(replace(REPLACE(cus_det_email_id,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_contact1=  replace(replace(REPLACE(cus_det_contact1,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_country =  replace(replace(REPLACE(cus_det_country,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_varchar2=  replace(replace(REPLACE(cus_det_varchar2,char(9),''),CHAR(10),''),CHAR(13),'')
 ,d.cus_det_varchar3=  replace(replace(REPLACE(cus_det_varchar3,char(9),''),CHAR(10),''),CHAR(13),'')
 

 from cus_det d


 */