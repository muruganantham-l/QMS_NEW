
Begin tran

Declare @audituser varchar(100)		= 'tomms'
Declare @auditdate datetime			= getdate()
Declare @issuenumber varchar(100)	= 'ISU124831'
Declare @stocknumber varchar(100)	= 'STK107316'
Declare @issuedate datetime			= '2017-01-01 00:00:00'
Declare @Costcenter varchar(100)	= 'TSD-HQ1-001'
Declare @accountcode varchar(100)	= '251109'
Declare @itm_mst_account varchar(100) 
Declare @location varchar(100)		= 'HQ-001-0001'
Declare @Qty numeric(10,4)  = 1.00
Declare @itm_cost numeric(10,4) 
Declare @mst_rowid int 
Declare @itemdesc varchar(300)
Declare @receiveno varchar(100)  
Declare @last_price numeric(10,4)


Select @mst_rowid  = itm_mst.Rowid ,
		@itm_mst_account =itm_mst_account, 
		@itemdesc= itm_mst_desc , 
		@last_price = itm_det_last_cost,
		@itm_cost = itm_mst_issue_price
from itm_mst (nolock) , 
	itm_det (nolock)
where itm_mst.rowid = mst_rowid
and itm_mst_stockno = @stocknumber


update itm_mst 
SET itm_mst_ttl_oh =COALESCE ( itm_mst_ttl_oh , 0 ) - @Qty , 
	itm_mst_issue_price = @itm_cost
WHERE ( itm_mst.RowID = @mst_rowid ) 
	

update itm_det 
SET itm_det_ttl_oh =COALESCE ( itm_det_ttl_oh , 0 ) - @Qty , 
	itm_det_ytd_usage =COALESCE ( itm_det_ytd_usage , 0 ) + @Qty , 
	itm_det_item_cost = @itm_cost , 
	itm_det_issue_price =@itm_cost , 
	itm_det_lastactdate =GetDate ( ) 
WHERE ( itm_det.mst_RowID = @mst_rowid ) 


update itm_loc 
SET itm_loc_oh_qty =COALESCE ( itm_loc_oh_qty , 0 ) - @Qty , 
	itm_loc_lastactdate =GetDate ( ) 
WHERE ( itm_loc.mst_RowID = @mst_rowid ) 
AND ( itm_loc_stk_loc =@location) 
	 
SELECT itm_mtc.site_cd,   
         itm_mtc.itm_mtc_grn_no,   
         itm_mtc.itm_mtc_grn_itm_no,   
         itm_mtc.itm_mtc_rcv_date,   
         itm_mtc.itm_mtc_rcv_empl_id,   
         itm_mtc.itm_mtc_stockno,   
         itm_mtc.itm_mtc_stk_locn,   
         itm_mtc.itm_mtc_uom,   
         itm_mtc.itm_mtc_costcenter,   
         itm_mtc.itm_mtc_account,   
         itm_mtc.itm_mtc_pono,   
         itm_mtc.itm_mtc_po_lineno,   
         itm_mtc.itm_mtc_nonstkitm,   
         itm_mtc.itm_mtc_rcv_qty,   
         itm_mtc.itm_mtc_rcv_cost,   
         itm_mtc.itm_mtc_isu_qty,   
         itm_mtc.itm_mtc_inv_qty,   
         itm_mtc.itm_mtc_inv_cost,   
         itm_mtc.audit_user,   
         itm_mtc.audit_date,   
         itm_mtc.column1,   
         itm_mtc.column2,   
         itm_mtc.column3,   
         itm_mtc.column4,   
         itm_mtc.column5,   
         itm_mtc.RowID  
    FROM itm_mtc
  WHERE ( itm_mtc.site_cd = 'QMS' )
   AND	( itm_mtc.itm_mtc_stockno = @stocknumber )
   AND 	( itm_mtc_stk_locn = @location )

   /*this block need to be repeat for multiple entries*/
Declare @mtc_rowid int 

select @mtc_rowid = itm_mtc.RowID  ,
@receiveno = itm_mtc_grn_no
    FROM itm_mtc (nolock)
  WHERE ( itm_mtc.site_cd = 'QMS' )
   AND	( itm_mtc.itm_mtc_stockno = @stocknumber )
   AND 	( itm_mtc_stk_locn = @location )

update itm_mtc 
SET itm_mtc_isu_qty =itm_mtc_isu_qty + @Qty 
WHERE RowID = @mtc_rowid

INSERT INTO itm_mtu ( site_cd , itm_mtu_activity_code , itm_mtu_doc_no , itm_mtu_wo , itm_mtu_stockno , 
itm_mtu_stk_locn , itm_mtu_mtr_no , itm_mtu_mtr_lineno , itm_mtu_desc , itm_mtu_usg_date , itm_mtu_cur_date , 
itm_mtu_used_qty , itm_mtu_used_uom , itm_mtu_item_cost , itm_mtu_chg_costcenter , itm_mtu_chg_account , 
itm_mtu_crd_costcenter , itm_mtu_crd_account , itm_mtu_assetno , itm_mtu_projectid , itm_mtu_nonstkitem , 
itm_mtu_supplier , itm_mtu_login_id , itm_mtu_work_type , itm_mtu_ref_doc_no , itm_mtu_cost_cat_id , 
itm_mtu_mt_special_idno , itm_mtu_mtc_id , itm_mtu_mts_id , itm_mtu_remark , audit_user , audit_date ) 
VALUES ( 'QMS' , '' ,@issuenumber , NULL , @stocknumber , @location , '' , 0 , @itemdesc , GetDate ( ) , 
GetDate ( ) , @Qty , 'UNIT' , @itm_cost , @Costcenter , @accountcode , @Costcenter , @accountcode , NULL , 
'' , '' , '' , @audituser , '' , @receiveno , 0 , 0 , @mtc_rowid , 0 , NULL , @audituser , GetDate ( ) ) 


INSERT INTO itm_trx ( site_cd , itm_trx_doc_no , itm_trx_trx_type , itm_trx_curr_date , itm_trx_trx_date , 
itm_trx_isu_empl_id , itm_trx_rcv_empl_id , itm_trx_stockno , itm_trx_desc , itm_trx_partno , itm_trx_com_code , itm_trx_isu_qty , 
itm_trx_rcv_qty , itm_trx_ord_qty , itm_trx_rtn_qty , itm_trx_bo_qty , itm_trx_chg_costcenter , itm_trx_chg_account , itm_trx_crd_costcenter , 
itm_trx_crd_account , itm_trx_assetno , itm_trx_wo , itm_trx_mtlrqnnum , itm_trx_item_cost , itm_trx_uom , itm_trx_cnv_qty , itm_trx_pkguom , 
itm_trx_ext_cost , itm_trx_porqnnum , itm_trx_approver , itm_trx_supplier , itm_trx_pono , itm_trx_po_lineno , itm_trx_ttl_oh , 
itm_trx_stk_locn , itm_trx_oh_qty , itm_trx_comments , itm_trx_to_stk_locn , itm_trx_mtlrqn_lineno , itm_trx_grn_no , itm_trx_grn_itm_no , 
itm_trx_posted , itm_trx_avg_cost , itm_trx_std_cost , itm_trx_last_cost , itm_trx_consigned , itm_trx_receive_doc_note , itm_trx_inv_qty , 
itm_trx_inv_uom , itm_trx_liability_acc , itm_trx_raw_cost , itm_trx_rcv_cost , itm_trx_rcv_date , 
itm_trx_pkg_slip_no , itm_trx_mt_special_idno , itm_trx_cost_cat_id , itm_trx_mtcs_ref_id , itm_trx_return_fee , 
itm_trx_mtrtnsup_ref_id , itm_trx_mtrtnsup_lineno , itm_trx_mtns_ref_id , itm_trx_inv_id , itm_trx_inv_lineno , 
itm_trx_rev_inv , itm_trx_ret_supp , itm_trx_mkey , itm_trx_status , itm_trx_projectid , itm_trx_login_id , 
itm_trx_cnx_qty , itm_trx_fifo_avg_cost , itm_trx_remark , audit_user , audit_date ) 
VALUES ( 'QMS' , @issuenumber , 'MT21' , GetDate ( ) , @issuedate , 'MMD4' , '' , @stocknumber , @itemdesc, '' , '' , 
@Qty , 0 , 0 , 0 , 0 , @Costcenter , @accountcode , @Costcenter , @itm_mst_account , NULL , NULL , NULL , 
@itm_cost , 'UNIT' , 0 , '' , @Qty*@itm_cost , '' , '' , '' , '' , 0 , 0 , @location , 0 , '' , '' , 0 , '' ,
0 , '' , @itm_cost , '0.0000' , @last_price , '' , 0 , NULL , '' , '' , @Qty*@itm_cost , 0 , 0 , 0 , '' ,
'' , 0 , 0 , 0 , 0 , 0 ,0 , 0 , '' , '' , '' , '' , '' , @audituser , 0 , @itm_cost , 
NULL , @audituser , GetDate ( ) ) 

update cf_budget_charge 
SET per1 =per1 + @itm_cost
WHERE site_cd ='QMS' 
AND budget_year =2017 
AND costcenter = @Costcenter 
AND account = @accountcode 

update cf_budget_credit 
SET per1 =per1 + @itm_cost
WHERE site_cd ='QMS' 
AND budget_year = 2017
AND costcenter =@Costcenter 
AND account =@accountcode

select * from itm_trx (nolock)
where itm_trx_doc_no ='ISU124831'

--rollback
commit


--itm_trx
--where itm_trx_doc_no ='ISU124831'

--itm_mst (nolock) , 
--	itm_det (nolock)
--where itm_mst.rowid = mst_rowid
--and itm_mst_stockno = 'STK101633'