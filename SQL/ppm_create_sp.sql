create proc ppm_create_sp
@be_number varchar(200) = 'PRK031958'
,@site_code varchar(100) = 'QMS'
,@freq_code int = 2
,@lpm_date datetime = '2018-07-01'
,@lpm_close_date datetime = '2018-07-31'
,@lpm_due_date datetime = '2019-01-01'
,@lead_days int = 28--  guided by promothan
,@plan_priority int = 2-- guided by promothan
,@description nvarchar(max) = 'Scheduled Maintenance For Sterilizing Units, Steam, Tabletop'
,@pm_no_out varchar(100) output
as
begin
set nocount ON
--alter table ppm_asset_prk add   error_desc varchar(max)
declare @count int
, @ast_mst_asset_locn				varchar(300)
, @ast_mst_asset_grpcode 		varchar(300)
, @ast_mst_cost_center 			varchar(300)
, @ast_mst_wrk_grp 				varchar(300)
, @ast_mst_work_area 			varchar(300)
, @ast_mst_ast_lvl 				varchar(300)
, @ast_det_cus_code 				varchar(300)
,@ast_mst_asset_shortdesc varchar(300)
,@pm_no varchar(300)
, @prm_fcd_freq_code			varchar(300)
, @prm_fcd_freq_type 			varchar(300)
, @prm_fcd_desc 				varchar(300)
, @prm_fcd_cal_days 			int
, @prm_fcd_band 				varchar(300)
, @prm_fcd_lead_pct 			varchar(300)
, @prm_fcd_usg 					varchar(300)
, @prm_fcd_usg_uom 				varchar(300)
, @prm_fcd_dayofweek 			varchar(300)
, @prm_fcd_dayofmonth 			varchar(300)
, @prm_fcd_weekofmonth 			varchar(300)
,@mst_rowid numeric(12)
, @cus_mst_desc				varchar(500)
, @cus_mst_fob 				varchar(500)
, @cus_mst_shipvia 			varchar(500)
, @cus_det_address1  		varchar(500)
, @cus_det_city 			varchar(500)
, @cus_det_email_id 		varchar(500)
, @cus_det_state 			varchar(500)
 , @cus_det_province 		varchar(500)
 , @cus_det_contact1		varchar(500)
 , @ast_mst_perm_id			varchar(500)
 , @RowID 					varchar(500)
 , @ast_det_mfg_cd 			varchar(500)
 , @ast_det_modelno 		varchar(500)
 , @ast_det_varchar2 		varchar(500)
 , @ast_det_varchar15		varchar(500)
 ,@sysdate datetime = getdate()
 ,@prm_fcd_desc1 varchar(3000)
 ,@sm_type varchar(300)
 ,@pm_date datetime

select @count = count(*) FROM 		
ast_mst (NOLOCK),
				ast_det (NOLOCK),
				ast_sts (NOLOCK) WHERE ((	ast_mst.site_cd = ast_det.site_cd
AND			ast_mst.RowID = ast_det.mst_RowID
AND			ast_mst.site_cd = ast_sts.site_cd
AND			ast_mst.ast_mst_asset_status = ast_sts.ast_sts_status
AND			ast_sts.ast_sts_typ_cd NOT IN ('AWA-DISPOSED', 'DISPOSED', 'OUT-OF-SERVICE')) 
AND ast_mst.site_cd = @site_code AND  ast_mst_asset_status IN ( 'ACT','BER','DEA','MNR','N/A','PBR') ) 
AND ast_mst.ast_mst_asset_no = @be_number--'PRK031958' 
and ast_det_varchar15 ! = 'Accessories'--added by murugan
if @count = 0
begin 
RAISERROR('Asset does not exists',16,1);RETURN
end 

 SELECT @ast_mst_asset_locn=ast_mst_asset_locn , @ast_mst_asset_grpcode=ast_mst_asset_grpcode , @ast_mst_cost_center=ast_mst_cost_center 
 ,@ast_mst_wrk_grp= ast_mst_wrk_grp , @ast_mst_work_area=ast_mst_work_area , @ast_mst_ast_lvl=ast_mst_ast_lvl , @ast_mst_ast_lvl=ast_det_cus_code 
 ,@sm_type= ast_det_varchar10
 FROM ast_mst (NOLOCK), ast_det (NOLOCK)
 WHERE ast_mst.site_cd =ast_det.site_cd 
 AND ast_mst.RowID =ast_det.mst_RowID 
 AND ast_mst.site_cd =@site_code 
 AND ast_mst.ast_mst_asset_no =@be_number  
 /*
 SELECT 	agc_job.site_cd,   
			agc_job.agc_job_grp_cd,   
			agc_job.agc_job_job_cd,   
			job_mst.job_mst_job_cd,   
			job_mst.job_mst_desc,    
			job_mst.rowid,
			agc_job.audit_user,   
			agc_job.audit_date,    
			agc_job.column1,   
			agc_job.column2,   
			agc_job.column3,   
			agc_job.column4,   
			agc_job.column5,   
			agc_job.RowID  
FROM 	agc_job,
			job_mst   
WHERE 	( agc_job.site_cd = job_mst.site_cd ) 
AND		( agc_job.agc_job_job_cd = job_mst.job_mst_job_cd ) 
AND	    ( agc_job.site_cd = @site_code )
AND 		( agc_job.agc_job_grp_cd = @ast_mst_asset_grpcode ) 

 SELECT @count=COUNT ( *) FROM ast_mst , ast_ref
  WHERE ast_mst.site_cd =@site_code AND ast_mst.ast_mst_asset_no =@be_number 
  AND ast_mst.RowID =ast_ref.mst_RowID AND ast_ref.type ='P' 
 if @count = 0
begin 
RAISERROR('Picture not available for the given BE Number',16,1);RETURN
end 

*/
 SELECT @ast_det_cus_code=ast_det_cus_code FROM ast_mst(NOLOCK) , ast_det(NOLOCK) WHERE ast_mst.site_cd =ast_det.site_cd
  AND ast_mst.RowID =ast_det.mst_RowID AND ast_mst.site_cd =@site_code AND ast_mst.ast_mst_asset_no =@be_number 
  
 SELECT @cus_mst_desc=cus_mst_desc ,@cus_mst_fob= cus_mst_fob ,@cus_mst_shipvia= cus_mst_shipvia ,@cus_det_address1= cus_det_address1 + ' ' + cus_det_address2 
 ,@cus_det_city= cus_det_city ,@cus_det_email_id= cus_det_email_id ,@cus_det_state= cus_det_state 
 ,@cus_det_province= cus_det_province ,@cus_det_contact1= cus_det_contact1 
 FROM cus_mst (NOLOCK), cus_det(NOLOCK) WHERE cus_mst.rowid =cus_det.mst_rowid AND cus_mst.site_cd =@site_code AND cus_mst.cus_mst_customer_cd =@ast_det_cus_code
 
 SELECT @ast_mst_perm_id= ast_mst.ast_mst_perm_id , @RowID=ast_mst.RowID , @ast_det_mfg_cd=ast_det.ast_det_mfg_cd ,@ast_det_modelno=
 ast_det.ast_det_modelno ,@ast_det_varchar2= ast_det.ast_det_varchar2 ,@ast_det_varchar15= ast_det.ast_det_varchar15
  FROM ast_mst (NOLOCK), ast_det(NOLOCK) WHERE ast_mst.site_cd =ast_det.site_cd AND ast_mst.rowid =ast_det.mst_rowid
   AND ast_mst.site_cd =@site_code AND ast_mst.ast_mst_asset_no =@be_number 

   /*
 SELECT 	usg_ast.site_cd,   
			usg_ast.usg_ast_usr_grp,   
			usg_ast.usg_ast_loc, 
			ast_loc.ast_loc_desc
FROM 	usg_ast,
			ast_loc
WHERE	( usg_ast.site_cd = ast_loc.site_cd )
AND		( usg_ast.usg_ast_loc = ast_loc.ast_loc_ast_loc )
--and  usg_ast.usg_ast_loc= @ast_mst_asset_locn--added by murugan
AND 		( usg_ast.usg_ast_list = '1' )
AND 		( usg_ast.site_cd= @site_code )
AND 		( usg_ast.usg_ast_usr_grp = 'ceo'/*@P2*/ )--',N'@P1 nvarchar(4),@P2 nvarchar(5)',N'QMS',N'CEO'
*/
 SELECT @ast_mst_asset_shortdesc = COALESCE ( ast_mst_asset_shortdesc , '''' )
  FROM ast_mst(NOLOCK) WHERE site_cd =@site_code AND ast_mst_asset_no =@be_number  

  select @count = count(*) ,@prm_fcd_desc1 = max(prm_fcd_desc) FROM 	prm_fcd  (NOLOCK) WHERE ((	prm_fcd.prm_fcd_disable_flag = 0    
) AND prm_fcd.site_cd = @site_code ) AND prm_fcd.prm_fcd_freq_code = @freq_code

if @count = 0
begin 
RAISERROR('Frequency code not enabled',16,1);RETURN
end 

 Select @prm_fcd_freq_code=prm_fcd_freq_code , @prm_fcd_freq_type=prm_fcd_freq_type , @prm_fcd_desc=prm_fcd_desc 
 , @prm_fcd_cal_days=prm_fcd_cal_days ,@prm_fcd_band= prm_fcd_band ,@prm_fcd_lead_pct= prm_fcd_lead_pct ,@prm_fcd_usg= prm_fcd_usg ,
 @prm_fcd_usg_uom= prm_fcd_usg_uom ,@prm_fcd_dayofweek= prm_fcd_dayofweek ,@prm_fcd_dayofmonth= prm_fcd_dayofmonth , @prm_fcd_weekofmonth=prm_fcd_weekofmonth 
  From prm_fcd(NOLOCK) Where site_cd = @site_code
   And prm_fcd_freq_code = @freq_code

 Select @pm_no =  cnt_mst_prefix + SUBSTRING ( CONVERT ( VARCHAR ( 7 ) , cnt_mst_counter + 1000000 ) , 2 , 6 )
  From cnt_mst WITH ( UPDLOCK ) Where site_cd =@site_code And cnt_mst_module_cd ='PM'

update cnt_mst WITH ( UPDLOCK ) 
SET cnt_mst_counter =cnt_mst_counter + 1 
WHERE site_cd =@site_code AND cnt_mst_module_cd ='PM'

Select @count= Count ( *) From prm_mst Where site_cd =@site_code And prm_mst_pm_no =@pm_no  
 if @count > 0 
 BEGIN
 RAISERROR('PM No already exists',16,1);RETURN

 END

 SELECT @pm_date = min(p.prm_mst_lpm_date) from prm_mst (NOLOCK) p where p.prm_mst_assetno = @be_number
 if @pm_date is not NULL
 BEGIN
  RAISERROR('BE Number alreay have PM No',16,1);RETURN;
 END

 if @pm_date is NULL
 BEGIN
   select @pm_date = @lpm_date
 END
 if @freq_code = 1
 begin
 SELECT @pm_date = dateadd(YEAR,-1,@pm_date)
 END
 if @freq_code = 2
 BEGIN
  SELECT @pm_date = dateadd(MONTH,-6,@pm_date)
 END

INSERT INTO prm_mst ( site_cd, prm_mst_type, prm_mst_pm_no, prm_mst_assetno, prm_mst_pm_grp, prm_mst_freq_code, prm_mst_pm_date, prm_mst_lpm_date,
 prm_mst_meter_id, prm_mst_lpm_usg, prm_mst_lpm_uom, prm_mst_flt_code, prm_mst_curr_wo, prm_mst_shadow_grp, prm_mst_lead_day,
  prm_mst_override_date, prm_mst_next_create, prm_mst_next_due, prm_mst_lpm_closed_date, prm_mst_closed_loop, prm_mst_cal_startdate,
   prm_mst_dflt_status, prm_mst_plan_priority, prm_mst_assetlocn, prm_mst_desc, prm_mst_create_by, prm_mst_create_date, audit_user,
    audit_date, column1, column2, column3, column4, column5 ) 
	VALUES ( @site_code, 'A', @pm_no, @be_number, null, @freq_code, @pm_date /*'doubt'*/ /*prm_mst_pm_date*/, @lpm_date
	
	, null, '0.0000', null,null,null,null,@lead_days
 ,NULL, dateadd(dd,-@lead_days,@lpm_due_date),@lpm_due_date,  @lpm_close_date,1,1
 ,'OPE',@plan_priority,@ast_mst_asset_locn,@description,'patch',@sysdate,'tomms'
 ,@sysdate,NULL,NULL,NULL,NULL,NULL)
 
 SELECT @mst_rowid = RowID from prm_mst (NOLOCK) where prm_mst_pm_no= @pm_no

 INSERT INTO prm_det ( site_cd, mst_RowID, prm_det_approver, prm_det_planner, prm_det_cause_code, prm_det_on_dispatch_q, prm_det_safety, 
prm_det_project_id, prm_det_chg_costcenter, prm_det_crd_costcenter, prm_det_l_account, prm_det_m_account, prm_det_c_account, prm_det_start_time, 
prm_det_act_code, prm_det_work_area, prm_det_work_locn, prm_det_work_grp, prm_det_work_type, prm_det_work_class, prm_det_freq_pct, prm_det_season, 
prm_det_season_beg, prm_det_season_end, prm_det_ent_date, prm_det_auto_replan, prm_det_originator, prm_det_varchar1, prm_det_varchar2, prm_det_varchar3, 
prm_det_varchar4, prm_det_varchar5, prm_det_varchar6, prm_det_varchar7, prm_det_varchar8, prm_det_varchar9, prm_det_varchar10, prm_det_varchar11, 
prm_det_varchar12, prm_det_varchar13, prm_det_varchar14, prm_det_varchar15, prm_det_varchar16, prm_det_varchar17, prm_det_varchar18, prm_det_varchar19, 
prm_det_varchar20, prm_det_numeric1, prm_det_numeric2, prm_det_numeric3, prm_det_numeric4, prm_det_numeric5, prm_det_numeric6, prm_det_numeric7, 
prm_det_numeric8, prm_det_numeric9, prm_det_numeric10, prm_det_datetime1, prm_det_datetime2, prm_det_datetime3, prm_det_datetime4, prm_det_datetime5, 
prm_det_datetime6, prm_det_datetime7, prm_det_datetime8, prm_det_datetime9, prm_det_datetime10, prm_det_note1, prm_det_note2, prm_det_asset_level, 
prm_det_customer_cd, audit_user, audit_date, column1, column2, column3, column4, column5 ) 
 SELECT @site_code, @mst_rowid, null, NULL, NULL, 0, 0,
null, @ast_mst_cost_center as prm_det_chg_costcenter,null as prm_det_crd_costcenter,null as prm_det_l_account  ,NULL as prm_det_m_account
,NULL as prm_det_c_account, null as prm_det_start_time,null as prm_det_act_code,@ast_mst_work_area as prm_det_work_area,null as prm_det_work_locn
,@ast_mst_wrk_grp as prm_det_work_grp
,null as prm_det_work_type,@sm_type as prm_det_work_class , null as prm_det_freq_pct,null as prm_det_season, 
null as prm_det_season_beg, null as prm_det_season_end,null as prm_det_ent_date,null as prm_det_auto_replan, 
null as prm_det_originator,@cus_mst_fob as  prm_det_varchar1,@cus_mst_shipvia as prm_det_varchar2,@cus_det_address1 as prm_det_varchar3, 
@cus_det_province as prm_det_varchar4,@ast_det_mfg_cd as prm_det_varchar5, @ast_det_modelno as  prm_det_varchar6
,@ast_det_varchar2 as  prm_det_varchar7, @ast_det_varchar15 as prm_det_varchar8,@cus_det_contact1 as prm_det_varchar9
,null as  prm_det_varchar10, null as prm_det_varchar11, 
null as prm_det_varchar12,null as prm_det_varchar13, null as prm_det_varchar14,null as  prm_det_varchar15,null as  prm_det_varchar16
, null as prm_det_varchar17,NULL as prm_det_varchar18,null as  prm_det_varchar19, 
null as prm_det_varchar20,null as prm_det_numeric1, null as prm_det_numeric2,null as prm_det_numeric3,null as prm_det_numeric4,null as prm_det_numeric5
,null as prm_det_numeric6, null as prm_det_numeric7, 
null as prm_det_numeric8,null as prm_det_numeric9,null as prm_det_numeric10,null as prm_det_datetime1,null as prm_det_datetime2,null as prm_det_datetime3
,null as prm_det_datetime4,null as prm_det_datetime5, 
null as prm_det_datetime6,null as prm_det_datetime7,null as prm_det_datetime8,null as prm_det_datetime9,null as prm_det_datetime10
,@cus_mst_desc as  prm_det_note1,null as  prm_det_note2,@ast_mst_ast_lvl as  prm_det_asset_level, 
@ast_det_cus_code as  prm_det_customer_cd, 'tomms' as audit_user, @sysdate as audit_date,null as column1,null as column2,null as column3,
null as column4,null as column5


SELECT @pm_no_out =  @pm_no  
  

 --doubt column prm_mst_pm_date
set nocount OFF
end

--GO
--begin tran
--exec ppm_create_sp
--ROLLBACK