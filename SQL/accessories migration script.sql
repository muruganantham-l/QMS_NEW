--SELECT   * from accessory_report_tab_temp WHERE BENumber in ('WKNDED016' ,'MLK030626')
-- 'MLK030626'

 --Select * from ast_aud where ast_aud_asset_no  in ('WKNDED016' ,'MLK030626')

-- 'MLK030626'
--SELECT * from ast_mst m join ast_det d on m.RowID = d.mst_RowID and m.ast_mst_asset_no LIKE 'wpl000500%'

--SELECT m.RowID,d.mst_RowID,* from ast_mst m join ast_det d on m.RowID = d.mst_RowID and m.ast_mst_asset_no LIKE 'MLK030626%'

--alter table accessory_report_tab_temp  
--add be_category_accessories varchar(300)

--SELECT ast_mst_asset_grpcode,ast_mst_asset_longdesc,ast_mst_asset_shortdesc ,ast_mst_asset_type,ast_mst_wrk_grp ,ast_mst_cri_factor from ast_mst
--SELECT ast_det_depr_term,ast_det_varchar11,ast_det_numeric8,ast_det_asset_cost from ast_det

--alter table accessory_report_tab_temp
--add ast_mst_asset_grpcode		varchar(400)--ast_grp_grp_cd
--add ast_mst_asset_longdesc	varchar(400)--ast_grp_desc
--add ast_mst_asset_shortdesc	varchar(400)--ast_grp_general_name
--add ast_det_depr_term			varchar(400) --ast_grp_est_srv_life
--add ast_mst_asset_type		varchar(400)--ast_grp_group
--add ast_mst_wrk_grp			varchar(400)--ast_grp_classification
--add ast_mst_cri_factor		varchar(400)--ast_grp_cri_factor
--add ast_det_varchar11			varchar(400)--ast_grp_maint_freq
--add ast_det_varchar10			varchar(400) --ast_grp_maintenance_type
--add ast_det_numeric8			numeric(21,4) -- case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end
--add ast_det_asset_cost		numeric(21,4) --ast_grp_purchase_cost
--add ast_det_numeric1			numeric(21,4) -- case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end * 12
--add ast_det_numeric2			numeric(21,4) -- case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_rate_west when ast_det_varchar9= 'em' then ast_grp_maintenance_rate_east else null end  
--add ast_det_numeric9			numeric(21,4)--ast_grp_rental_value
--go
--SELECT *   from ast_grp g join accessory_report_tab_temp t on g.ast_grp_category = t.BECategory
--  where ast_grp_category = 'Micromotor'-- 'HP- High Speed'

--update t SET
-- ast_mst_asset_grpcode		=ast_grp_grp_cd
--,ast_mst_asset_longdesc		=ast_grp_desc
--,ast_mst_asset_shortdesc		=ast_grp_general_name
--,ast_det_depr_term			=ast_grp_est_srv_life
--,ast_mst_asset_type			=ast_grp_group
--,ast_mst_wrk_grp				=ast_grp_classification
--,ast_mst_cri_factor			=ast_grp_cri_factor
--,ast_det_varchar11			=ast_grp_maint_freq
--,ast_det_varchar10			=ast_grp_maintenance_type
--,ast_det_numeric8			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end
--,ast_det_asset_cost			=ast_grp_purchase_cost
--,ast_det_numeric1			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end * 12
--,ast_det_numeric2			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_rate_west when ast_det_varchar9= 'em' then ast_grp_maintenance_rate_east else null end  
--,ast_det_numeric9			=ast_grp_rental_value
--from ast_grp g join accessory_report_tab_temp t on g.ast_grp_category = t.BECategory
--join ast_mst m (NOLOCK) on m.ast_mst_asset_no = t.AccessoryNumber join ast_det d on d.mst_RowID = m.RowID


--SELECT  BECategory from accessory_report_tab_temp
--except 

--SELECT ast_grp_category   from ast_grp-- where ast_grp_category = 'Handpieces, Dental'
begin tran
insert ast_mst
(
site_cd
,ast_mst_asset_no
,ast_mst_asset_type
,ast_mst_asset_grpcode
,ast_mst_asset_status
,ast_mst_work_area
,ast_mst_cri_factor
,ast_mst_cost_center
,ast_mst_asset_locn
,ast_mst_safety_rqmts
,ast_mst_asset_shortdesc
,ast_mst_asset_longdesc
,ast_mst_perm_id
,ast_mst_parent_id
,ast_mst_asset_code
,ast_mst_assigned_to
,ast_mst_fda_code
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
,ast_mst_parent_flag
,ast_mst_auto_no
,ast_mst_create_by
,ast_mst_create_date
,ast_mst_wrk_grp
,ast_mst_print_count
,ast_mst_ast_lvl
)
SELECT

site_cd
--,ast_mst_asset_no
,a.AccessoryNumber
,m.ast_mst_asset_type
--,ast_mst_asset_grpcode
,a.category
,ast_mst_asset_status
,ast_mst_work_area
,m.ast_mst_cri_factor
,ast_mst_cost_center
,ast_mst_asset_locn
,ast_mst_safety_rqmts
,m.ast_mst_asset_shortdesc
,m.ast_mst_asset_longdesc
,ast_mst_perm_id
,ast_mst_parent_id
,ast_mst_asset_code
,ast_mst_assigned_to
,ast_mst_fda_code
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
,ast_mst_parent_flag
,ast_mst_auto_no
,ast_mst_create_by
,ast_mst_create_date
,m.ast_mst_wrk_grp
,ast_mst_print_count
,ast_mst_ast_lvl
from ast_mst m JOIN accessory_report_tab_temp a on m.ast_mst_asset_no = a.BENumber
where not EXISTS (SELECT '' from NBE n where n.[BE Number] = a.BENumber)
and a.BENumber <>'MLK030626'
--and a.BENumber NOT IN ( 'WKNDED016','MLK030626')
--and a.BECategory = 'Dental Delivery Units'
--join nbe n on a.BENumber = n.[BE Number]

update a
set a.mst_rowid = m.RowID

from accessory_report_tab_temp a
join ast_mst m on a.AccessoryNumber = m.ast_mst_asset_no
--and a.BENumber NOT IN ( 'WKNDED016','MLK030626')
--and a.BECategory = 'Dental Delivery Units'

 

insert ast_det 
(

site_cd
,mst_RowID
,ast_det_asset_cost
,ast_det_mtdlabcost
,ast_det_mtdmtlcost
,ast_det_mtdconcost
,ast_det_ytdlabcost
,ast_det_ytdmtlcost
,ast_det_ytdconcost
,ast_det_ltdlabcost
,ast_det_ltdmtlcost
,ast_det_ltdconcost
,ast_det_warranty_date
,ast_det_depr_term
,ast_det_eqhr_level
,ast_det_repl_cost
,ast_det_l_account
,ast_det_m_account
,ast_det_c_account
,ast_det_taxable
,ast_det_ent_date
,ast_det_varchar1
,ast_det_varchar2
,ast_det_varchar3
,ast_det_varchar4
,ast_det_varchar5
,ast_det_varchar6
,ast_det_varchar7
,ast_det_varchar8
,ast_det_varchar9
,ast_det_varchar10
,ast_det_varchar11
,ast_det_varchar12
,ast_det_varchar13
,ast_det_varchar14
,ast_det_varchar15
,ast_det_varchar16
,ast_det_varchar17
,ast_det_varchar18
,ast_det_varchar19
,ast_det_varchar20
,ast_det_varchar21
,ast_det_varchar22
,ast_det_varchar23
,ast_det_varchar24
,ast_det_varchar25
,ast_det_varchar26
,ast_det_varchar27
,ast_det_varchar28
,ast_det_varchar29
,ast_det_varchar30
,ast_det_numeric1
,ast_det_numeric2
,ast_det_numeric3
,ast_det_numeric4
,ast_det_numeric5
,ast_det_numeric6
,ast_det_numeric7
,ast_det_numeric8
,ast_det_numeric9
,ast_det_numeric10
,ast_det_numeric11
,ast_det_numeric12
,ast_det_numeric13
,ast_det_numeric14
,ast_det_numeric15
,ast_det_numeric16
,ast_det_numeric17
,ast_det_numeric18
,ast_det_numeric19
,ast_det_numeric20
,ast_det_datetime1
,ast_det_datetime2
,ast_det_datetime3
,ast_det_datetime4
,ast_det_datetime5
,ast_det_datetime6
,ast_det_datetime7
,ast_det_datetime8
,ast_det_datetime9
,ast_det_datetime10
,ast_det_datetime11
,ast_det_datetime12
,ast_det_datetime13
,ast_det_datetime14
,ast_det_datetime15
,ast_det_datetime16
,ast_det_datetime17
,ast_det_datetime18
,ast_det_datetime19
,ast_det_datetime20
,ast_det_note1
,ast_det_note2
,ast_det_note3
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
--RowID
,ast_det_purchase_date
,ast_det_depr_date
,ast_det_acc_depr_cost
,ast_det_net_book_value
,ast_det_depr_by
,ast_det_depr_method
,ast_det_dispose_date
,ast_det_dispose_value
,ast_det_dispose_type
,ast_det_dispose_by
,ast_det_cus_code
,ast_det_mtdmisccost
,ast_det_ytdmisccost
,ast_det_ltdmisccost
,ast_det_s_account
,ast_det_mfg_cd
,ast_det_modelno

)


SELECT
 d.site_cd
,t.mst_rowid
,d.ast_det_asset_cost
,d.ast_det_mtdlabcost
,d.ast_det_mtdmtlcost
,d.ast_det_mtdconcost
,d.ast_det_ytdlabcost
,d.ast_det_ytdmtlcost
,d.ast_det_ytdconcost
,d.ast_det_ltdlabcost
,d.ast_det_ltdmtlcost
,d.ast_det_ltdconcost
,d.ast_det_warranty_date
,d.ast_det_depr_term
,d.ast_det_eqhr_level
,d.ast_det_repl_cost
,d.ast_det_l_account
,d.ast_det_m_account
,d.ast_det_c_account
,d.ast_det_taxable
,d.ast_det_ent_date
,d.ast_det_varchar1
,'NA'--ast_det_varchar2
,d.ast_det_varchar3
,d.ast_det_varchar4
,d.ast_det_varchar5
,d.ast_det_varchar6
,d.ast_det_varchar7
,d.ast_det_varchar8
,d.ast_det_varchar9
,d.ast_det_varchar10
,d.ast_det_varchar11
,d.ast_det_varchar12
,d.ast_det_varchar13
,d.ast_det_varchar14
,'Accessories'--,ast_det_varchar15
,ast_det_varchar16
,ast_det_varchar17
,ast_det_varchar18
,ast_det_varchar19
,ast_det_varchar20
,ast_det_varchar21
,ast_det_varchar22
,ast_det_varchar23
,ast_det_varchar24
,ast_det_varchar25
,ast_det_varchar26
,ast_det_varchar27
,ast_det_varchar28
,ast_det_varchar29
,ast_det_varchar30
,d.ast_det_numeric1
,d.ast_det_numeric2
,ast_det_numeric3
,ast_det_numeric4
,ast_det_numeric5
,ast_det_numeric6
,ast_det_numeric7
,d.ast_det_numeric8
,d.ast_det_numeric9
,ast_det_numeric10
,ast_det_numeric11
,ast_det_numeric12
,ast_det_numeric13
,ast_det_numeric14
,ast_det_numeric15
,ast_det_numeric16
,ast_det_numeric17
,ast_det_numeric18
,ast_det_numeric19
,ast_det_numeric20
,ast_det_datetime1
,ast_det_datetime2
,ast_det_datetime3
,ast_det_datetime4
,ast_det_datetime5
,ast_det_datetime6
,ast_det_datetime7
,ast_det_datetime8
,ast_det_datetime9
,ast_det_datetime10
,ast_det_datetime11
,ast_det_datetime12
,ast_det_datetime13
,ast_det_datetime14
,ast_det_datetime15
,ast_det_datetime16
,ast_det_datetime17
,ast_det_datetime18
,ast_det_datetime19
,ast_det_datetime20
,ast_det_note1
,ast_det_note2
,ast_det_note3
,d.audit_user
,d.audit_date
,d.column1
,d.column2
,d.column3
,d.column4
,d.column5
--RowID
,ast_det_purchase_date
,ast_det_depr_date
,ast_det_acc_depr_cost
,ast_det_net_book_value
,ast_det_depr_by
,ast_det_depr_method
,ast_det_dispose_date
,ast_det_dispose_value
,ast_det_dispose_type
,ast_det_dispose_by
,ast_det_cus_code
,ast_det_mtdmisccost
,ast_det_ytdmisccost
,ast_det_ltdmisccost
,ast_det_s_account
,'NA'
,'NA'
from ast_det d join ast_mst m on d.mst_RowID = m.RowID

join accessory_report_tab_temp t on t.BENumber = m.ast_mst_asset_no
where not EXISTS (SELECT '' from NBE n where n.[BE Number] = t.BENumber)
and t.BENumber <>'MLK030626'
--and t.BENumber = 'WKNDED016'
--and t.BENumber NOT IN ( 'WKNDED016','MLK030626')
--and t.BECategory = 'Dental Delivery Units'
--join nbe n on t.BENumber = n.[BE Number]
 
update t SET
 ast_mst_asset_grpcode		=ast_grp_grp_cd
,ast_mst_asset_longdesc		=ast_grp_desc
,ast_mst_asset_shortdesc		=ast_grp_general_name
,ast_det_depr_term			=ast_grp_est_srv_life
,ast_mst_asset_type			=ast_grp_group
,ast_mst_wrk_grp				=ast_grp_classification
,ast_mst_cri_factor			=ast_grp_cri_factor
,ast_det_varchar11			=ast_grp_maint_freq
,ast_det_varchar10			=ast_grp_maintenance_type
,ast_det_numeric8			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end
,ast_det_asset_cost			=ast_grp_purchase_cost
,ast_det_numeric1			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_value when ast_det_varchar9= 'em' then ast_grp_maintenance_value_east else null end * 12
,ast_det_numeric2			=case when ast_det_varchar9 = 'wm' then ast_grp_maintenance_rate_west when ast_det_varchar9= 'em' then ast_grp_maintenance_rate_east else null end  
,ast_det_numeric9			=ast_grp_rental_value
from ast_grp g join accessory_report_tab_temp t on g.ast_grp_category = t.be_category_accessories
join ast_mst m (NOLOCK) on m.ast_mst_asset_no = t.AccessoryNumber join ast_det d on d.mst_RowID = m.RowID
where not EXISTS (SELECT '' from NBE n where n.[BE Number] = t.BENumber)
and t.BENumber <>'MLK030626'

update m 
set 
ast_mst_asset_grpcode		= t. ast_mst_asset_grpcode
,ast_mst_asset_longdesc		 = t.ast_mst_asset_longdesc
,ast_mst_asset_shortdesc	= t.ast_mst_asset_shortdesc
,ast_mst_asset_type		= t.ast_mst_asset_type	
,ast_mst_wrk_grp		= t.ast_mst_wrk_grp	
,ast_mst_cri_factor		= t.ast_mst_cri_factor	
from ast_mst m 
join accessory_report_tab_temp t on m.ast_mst_asset_no = t.AccessoryNumber

 
 update d
 set 
  ast_det_varchar11		 = t.ast_det_varchar11
 ,ast_det_varchar10		= t.ast_det_varchar10
 ,ast_det_numeric8		= t.ast_det_numeric8
 ,ast_det_asset_cost	= t.ast_det_asset_cost	
 ,ast_det_numeric1	= t.ast_det_numeric1	
 ,ast_det_numeric2	= t.ast_det_numeric2	
 ,ast_det_numeric9		= t.ast_det_numeric9
 ,ast_det_depr_term		= t.ast_det_depr_term 
 ,ast_det_varchar2 = 'NA'
 ,ast_det_mfg_cd = 'NA'
 ,ast_det_modelno = 'NA'

  from ast_det d 
  join accessory_report_tab_temp t on t.mst_rowid = d.mst_RowID

--alter table accessory_report_tab_temp
--add mst_rowid int
--update t set  ast_det_depr_term = 1 from accessory_report_tab_temp t where ast_det_depr_term is not null
 
--set mst
--ast_det_varchar15
--Accessories



 insert ast_aud
 (
site_cd
,mst_RowID
,ast_aud_asset_no
,ast_aud_status
,ast_aud_originator
,ast_aud_start_date
,ast_aud_end_date
,ast_aud_duration
,audit_user
,audit_date
 )

 SELECT m.site_cd,m.RowID,m.ast_mst_asset_no,m.ast_mst_asset_status,m.audit_user,GETDATE(),NULL,NULL,m.audit_user,GETDATE()
 from ast_mst m join accessory_report_tab_temp t on m.ast_mst_asset_no = t.AccessoryNumber
 where not EXISTS (SELECT '' from NBE n where n.[BE Number] = t.BENumber)
 and t.BENumber <>'MLK030626'
-- and t.BENumber NOT IN ( 'WKNDED016','MLK030626')
--and t.BECategory = 'Dental Delivery Units'
--join nbe n on t.BENumber = n.[BE Number]
 
 insert ast_rat (site_cd,mst_RowID,ast_rat_uom,ast_rat_rating,ast_rat_desc,audit_user,audit_date)
 SELECT a.site_cd,a.RowID,'EACH',1,concat(t.be_category_accessories,',',t.AccessoryNumber),a.audit_user,a.audit_date
 from   ast_mst a join accessory_report_tab_temp t on a.ast_mst_asset_no = t.BENumber
  where not EXISTS (SELECT '' from NBE n where n.[BE Number] = t.BENumber)

  
  order by AccessoryNumber
   --7164
   SELECT * from ast_rat where ast_rat_desc like ',%'

   delete r from ast_rat r join   ast_mst a on r.mst_RowID = a.RowID join accessory_report_tab_temp t on a.ast_mst_asset_no = t.BENumber
  where not EXISTS (SELECT '' from NBE n where n.[BE Number] = t.BENumber)

  select * from accessory_report_tab_temp t join ast_rat r on t.mst_rowid = r.mst_rowid
  
  --SELECT * into ast_rat_bak_2018_10_10 from ast_rat

  SELECT * from accessory_report_tab_temp where BENumber = 'swk030145'
COMMIT
--6851
--SELECT be_category_accessories, * from accessory_report_tab_temp t join nbe n on t.BENumber = n.[BE Number] where -- BENumber = 'SLNDED013'
--  BECategory = 'Dental Delivery Units'
  --and be_category_accessories is NOT  NULL
----6916
--SELECT BENumber from accessory_report_tab_temp
--EXCEPT
--SELECT ast_mst_asset_no from ast_mst
--nbe
--SELECT * from nbe WHERE [BE Number] IN ( 'WKNDED016','MLK030626')

--and be_category_accessories is NULL
 --BENumber = 'WKNDED016'
/*
begin tran
set IDENTITY_INSERT ast_mst on  
insert ast_mst
(
site_cd
,ast_mst_asset_no
,ast_mst_asset_type
,ast_mst_asset_grpcode
,ast_mst_asset_status
,ast_mst_work_area
,ast_mst_cri_factor
,ast_mst_cost_center
,ast_mst_asset_locn
,ast_mst_safety_rqmts
,ast_mst_asset_shortdesc
,ast_mst_asset_longdesc
,ast_mst_perm_id
,ast_mst_parent_id
,ast_mst_asset_code
,ast_mst_assigned_to
,ast_mst_fda_code
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
--,RowID
,ast_mst_parent_flag
,ast_mst_auto_no
,ast_mst_create_by
,ast_mst_create_date
,ast_mst_wrk_grp
,ast_mst_print_count
,ast_mst_ast_lvl

)
SELECT  



site_cd
,ast_mst_asset_no
,ast_mst_asset_type
,ast_mst_asset_grpcode
,ast_mst_asset_status
,ast_mst_work_area
,ast_mst_cri_factor
,ast_mst_cost_center
,ast_mst_asset_locn
,ast_mst_safety_rqmts
,ast_mst_asset_shortdesc
,ast_mst_asset_longdesc
,ast_mst_perm_id
,ast_mst_parent_id
,ast_mst_asset_code
,ast_mst_assigned_to
,ast_mst_fda_code
,audit_user
,audit_date
,column1
,column2
,column3
,column4
,column5
--,RowID
,ast_mst_parent_flag
,ast_mst_auto_no
,ast_mst_create_by
,ast_mst_create_date
,ast_mst_wrk_grp
,ast_mst_print_count
,ast_mst_ast_lvl

 from tomms_prod..ast_mst where ast_mst_asset_no = 'MLK030626'



set IDENTITY_INSERT ast_mst off  
ROLLBACK

 


 */
