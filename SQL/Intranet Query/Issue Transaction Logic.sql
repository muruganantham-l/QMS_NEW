exec sp_executesql N'Select trx_cnt_prefix , trx_cnt_counter From trx_cnt WITH ( UPDLOCK ) Where site_cd =@P1 And trx_cnt_module_cd =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(4)',N'QMS',N'ISU'

exec sp_executesql N'update trx_cnt WITH ( UPDLOCK ) SET trx_cnt_counter =trx_cnt_counter + 1 WHERE site_cd =@P1 AND trx_cnt_module_cd =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(4)',N'QMS',N'ISU'

exec sp_executesql N'Select Count ( *) From itm_trx Where site_cd =@P1 And itm_trx_doc_no =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(11)',N'QMS',N'ISU124831'

exec sp_executesql N'SELECT itm_mst.itm_mst_partno , itm_mst.itm_mst_mstr_locn , itm_mst.itm_mst_ttl_oh , itm_mst.itm_mst_issue_uom , itm_det.itm_det_cr_code , itm_det.itm_det_item_cost , itm_det.itm_det_std_cost , itm_det.itm_det_avg_cost , itm_det.itm_det_last_cost , itm_mst.RowID , itm_mst.itm_mst_desc , itm_det.itm_det_auto_spare FROM itm_mst , itm_det WHERE ( itm_mst.RowID =itm_det.mst_RowID ) AND ( itm_mst.itm_mst_stockno =@P1 ) AND ( itm_mst.site_cd =@P2 ) ',N'@P1 nvarchar(25),@P2 nvarchar(4)',N'STK101449',N'QMS'
go
exec sp_executesql N'SELECT itm_loc_stock_cost_flag FROM itm_loc WHERE site_cd =@P1 AND mst_RowID =@P2 AND itm_loc_stk_loc =@P3 ',N'@P1 nvarchar(4),@P2 int,@P3 nvarchar(30)',N'QMS',2472,N'HQ-001-0001'
go
exec sp_executesql N'SELECT RowID FROM wko_mst WHERE wko_mst.site_cd =@P1 AND wko_mst.wko_mst_wo_no =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(11)',N'QMS',NULL
go
exec sp_executesql N'SELECT RowID FROM ast_mst WHERE ast_mst.site_cd =@P1 AND ast_mst.ast_mst_asset_no =@P2 ',N'@P1 nvarchar(4),@P2 nvarchar(30)',N'QMS',NULL
go


exec sp_executesql N'update itm_mst SET itm_mst_ttl_oh =COALESCE ( itm_mst_ttl_oh , 0 ) - @P1 , itm_mst_issue_price =@P2 WHERE ( itm_mst.RowID =@P3 ) ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 int',N'2.0000',N'517.1429',2472
go
exec sp_executesql N'update itm_det SET itm_det_ttl_oh =COALESCE ( itm_det_ttl_oh , 0 ) - @P1 , itm_det_ytd_usage =COALESCE ( itm_det_ytd_usage , 0 ) + @P2 , itm_det_item_cost =@P3 , itm_det_issue_price =@P4 , itm_det_lastactdate =GetDate ( ) WHERE ( itm_det.mst_RowID =@P5 ) ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 nvarchar(79),@P4 nvarchar(79),@P5 int',N'2.0000',N'2.0000',N'517.1429',N'517.1429',2472
go
exec sp_executesql N'update itm_loc SET itm_loc_oh_qty =COALESCE ( itm_loc_oh_qty , 0 ) - @P1 , itm_loc_lastactdate =GetDate ( ) WHERE ( itm_loc.mst_RowID =@P2 ) AND ( itm_loc_stk_loc =@P3 ) ',N'@P1 nvarchar(79),@P2 int,@P3 nvarchar(30)',N'2.0000',2472,N'HQ-001-0001'
go


exec sp_executesql N'SELECT itm_mtc.site_cd,   
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
  WHERE ( itm_mtc.itm_mtc_rcv_qty > itm_mtc.itm_mtc_isu_qty )
   AND	( itm_mtc.site_cd = @P1 )
   AND	( itm_mtc.itm_mtc_stockno = @P2 )
   AND 	( itm_mtc_stk_locn = @P3 )
',N'@P1 nvarchar(4),@P2 nvarchar(25),@P3 nvarchar(30)',N'QMS',N'STK101449',N'HQ-001-0001'
go
exec sp_executesql N'update itm_mtc SET itm_mtc_isu_qty =itm_mtc_isu_qty + @P1 WHERE RowID =@P2 ',N'@P1 nvarchar(79),@P2 int',N'1.0000',84966
go
exec sp_executesql N'INSERT INTO itm_mtu ( site_cd , itm_mtu_activity_code , itm_mtu_doc_no , itm_mtu_wo , itm_mtu_stockno , itm_mtu_stk_locn , itm_mtu_mtr_no , itm_mtu_mtr_lineno , itm_mtu_desc , itm_mtu_usg_date , itm_mtu_cur_date , itm_mtu_used_qty , itm_mtu_used_uom , itm_mtu_item_cost , itm_mtu_chg_costcenter , itm_mtu_chg_account , itm_mtu_crd_costcenter , itm_mtu_crd_account , itm_mtu_assetno , itm_mtu_projectid , itm_mtu_nonstkitem , itm_mtu_supplier , itm_mtu_login_id , itm_mtu_work_type , itm_mtu_ref_doc_no , itm_mtu_cost_cat_id , itm_mtu_mt_special_idno , itm_mtu_mtc_id , itm_mtu_mts_id , itm_mtu_remark , audit_user , audit_date ) VALUES ( @P1 , '''' , @P2 , @P3 , @P4 , @P5 , '''' , 0 , @P6 , GetDate ( ) , GetDate ( ) , @P7 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , @P14 , '''' , '''' , '''' , @P15 , '''' , @P16 , 0 , 0 , @P17 , 0 , @P18 , @P19 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 nvarchar(11),@P4 nvarchar(25),@P5 nvarchar(30),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(8),@P9 nvarchar(79),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(50),@P13 nvarchar(50),@P14 nvarchar(30),@P15 nvarchar(25),@P16 nvarchar(11),@P17 int,@P18 nvarchar(100),@P19 nvarchar(50)',N'QMS',N'ISU124831',NULL,N'STK101449',N'HQ-001-0001',N'Bearing 
',N'1.0000',N'UNIT',N'517.1429',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,N'tomms',N'RCV110182',84966,NULL,N'tomms'
go
exec sp_executesql N'update itm_mtc SET itm_mtc_isu_qty =itm_mtc_isu_qty + @P1 WHERE RowID =@P2 ',N'@P1 nvarchar(79),@P2 int',N'1.0000',84968
go
exec sp_executesql N'INSERT INTO itm_mtu ( site_cd , itm_mtu_activity_code , itm_mtu_doc_no , itm_mtu_wo , itm_mtu_stockno , itm_mtu_stk_locn , itm_mtu_mtr_no , itm_mtu_mtr_lineno , itm_mtu_desc , itm_mtu_usg_date , itm_mtu_cur_date , itm_mtu_used_qty , itm_mtu_used_uom , itm_mtu_item_cost , itm_mtu_chg_costcenter , itm_mtu_chg_account , itm_mtu_crd_costcenter , itm_mtu_crd_account , itm_mtu_assetno , itm_mtu_projectid , itm_mtu_nonstkitem , itm_mtu_supplier , itm_mtu_login_id , itm_mtu_work_type , itm_mtu_ref_doc_no , itm_mtu_cost_cat_id , itm_mtu_mt_special_idno , itm_mtu_mtc_id , itm_mtu_mts_id , itm_mtu_remark , audit_user , audit_date ) VALUES ( @P1 , '''' , @P2 , @P3 , @P4 , @P5 , '''' , 0 , @P6 , GetDate ( ) , GetDate ( ) , @P7 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , @P14 , '''' , '''' , '''' , @P15 , '''' , @P16 , 0 , 0 , @P17 , 0 , @P18 , @P19 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 nvarchar(11),@P4 nvarchar(25),@P5 nvarchar(30),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(8),@P9 nvarchar(79),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(50),@P13 nvarchar(50),@P14 nvarchar(30),@P15 nvarchar(25),@P16 nvarchar(11),@P17 int,@P18 nvarchar(100),@P19 nvarchar(50)',N'QMS',N'ISU124831',NULL,N'STK101449',N'HQ-001-0001',N'Bearing 
',N'1.0000',N'UNIT',N'517.1429',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,N'tomms',N'RCV110182',84968,NULL,N'tomms'
go
exec sp_executesql N'INSERT INTO itm_trx ( site_cd , itm_trx_doc_no , itm_trx_trx_type , itm_trx_curr_date , itm_trx_trx_date , 
itm_trx_isu_empl_id , itm_trx_rcv_empl_id , itm_trx_stockno , itm_trx_desc , itm_trx_partno , itm_trx_com_code , itm_trx_isu_qty , 
itm_trx_rcv_qty , itm_trx_ord_qty , itm_trx_rtn_qty , itm_trx_bo_qty , itm_trx_chg_costcenter , itm_trx_chg_account , itm_trx_crd_costcenter , 
itm_trx_crd_account , itm_trx_assetno , itm_trx_wo , itm_trx_mtlrqnnum , itm_trx_item_cost , itm_trx_uom , itm_trx_cnv_qty , itm_trx_pkguom , 
itm_trx_ext_cost , itm_trx_porqnnum , itm_trx_approver , itm_trx_supplier , itm_trx_pono , itm_trx_po_lineno , itm_trx_ttl_oh , itm_trx_stk_locn , itm_trx_oh_qty , itm_trx_comments , itm_trx_to_stk_locn , itm_trx_mtlrqn_lineno , itm_trx_grn_no , itm_trx_grn_itm_no , itm_trx_posted , itm_trx_avg_cost , itm_trx_std_cost , itm_trx_last_cost , itm_trx_consigned , itm_trx_receive_doc_note , itm_trx_inv_qty , itm_trx_inv_uom , itm_trx_liability_acc , itm_trx_raw_cost , itm_trx_rcv_cost , itm_trx_rcv_date , itm_trx_pkg_slip_no , itm_trx_mt_special_idno , itm_trx_cost_cat_id , itm_trx_mtcs_ref_id , itm_trx_return_fee , itm_trx_mtrtnsup_ref_id , itm_trx_mtrtnsup_lineno , itm_trx_mtns_ref_id , itm_trx_inv_id , itm_trx_inv_lineno , itm_trx_rev_inv , itm_trx_ret_supp , itm_trx_mkey , itm_trx_status , itm_trx_projectid , itm_trx_login_id , itm_trx_cnx_qty , itm_trx_fifo_avg_cost , itm_trx_remark , audit_user , audit_date ) VALUES ( @P1 , @P2 , ''MT21'' , GetDate ( ) , @P3 , @P4 , '''' , @P5 , @P6 , '''' , '''' , @P7 , 0 , 0 , 0 , 0 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , NULL , @P14 , @P15 , 0 , '''' , @P16 , '''' , '''' , '''' , '''' , 0 , 0 , @P17 , 0 , '''' , '''' , 0 , '''' , 0 , '''' , @P18 , @P19 , @P20 , '''' , 0 , NULL , '''' , '''' , @P21 , 0 , 0 , 0 , '''' , '''' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '''' , '''' , '''' , '''' , '''' , @P22 , 0 , @P23 , @P24 , @P25 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 datetime,@P4 nvarchar(25),@P5 nvarchar(25),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(50),@P9 nvarchar(50),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(30),@P13 nvarchar(11),@P14 nvarchar(79),@P15 nvarchar(8),@P16 nvarchar(79),@P17 nvarchar(30),@P18 nvarchar(79),@P19 nvarchar(79),@P20 nvarchar(79),@P21 nvarchar(79),@P22 nvarchar(25),@P23 nvarchar(79),@P24 nvarchar(255),@P25 nvarchar(50)',N'QMS',N'ISU124831','2017-01-01 00:00:00',N'MMD4',N'STK101449',N'Bearing 
',N'2.0000',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,NULL,N'517.1429',N'UNIT',N'1034.2858',N'HQ-001-0001',N'517.1429',N'0.0000',N'380.0000',N'1034.2858',N'tomms',N'517.1429',NULL,N'tomms'
go

exec sp_executesql N'update cf_budget_charge SET per1 =per1 + @P1 , per2 =per2 + @P2 , per3 =per3 + @P3 , per4 =per4 + @P4 , per5 =per5 + @P5 , per6 =per6 + @P6 , per7 =per7 + @P7 , per8 =per8 + @P8 , per9 =per9 + @P9 , per10 =per10 + @P10 , per11 =per11 + @P11 , per12 =per12 + @P12 WHERE site_cd =@P13 AND budget_year =@P14 AND costcenter =@P15 AND account =@P16 ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 nvarchar(79),@P4 nvarchar(79),@P5 nvarchar(79),@P6 nvarchar(79),@P7 nvarchar(79),@P8 nvarchar(79),@P9 nvarchar(79),@P10 nvarchar(79),@P11 nvarchar(79),@P12 nvarchar(79),@P13 nvarchar(4),@P14 smallint,@P15 nvarchar(50),@P16 nvarchar(50)',N'1034.2858',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'QMS',2017,N'TSD-HQ1-001',N'251109 '



exec sp_executesql N'SELECT itm_mst_stockno , itm_mst_costcenter , itm_mst_account , itm_mst_desc , itm_mst_order_rule , itm_det_cr_code , itm_det_std_cost , itm_det_avg_cost , itm_det_last_cost , itm_det_item_cost , itm_det_issue_uom , itm_det_rcv_uom , itm_det_ttl_oh , itm_det_maximum , itm_det_ttl_hard_resrv , itm_det_ttl_short , itm_det_pr_due_in , itm_det_due_in , itm_det_order_pt FROM itm_mst , itm_det WHERE itm_mst.site_cd =itm_det.site_cd AND itm_mst.RowID =itm_det.mst_RowID AND itm_mst.site_cd =@P1 AND itm_mst.RowID =@P2 ',N'@P1 nvarchar(4),@P2 int',N'QMS',2472
go
exec sp_executesql N'SELECT itm_mst.itm_mst_partno , itm_mst.itm_mst_mstr_locn , itm_mst.itm_mst_ttl_oh , itm_mst.itm_mst_issue_uom , itm_det.itm_det_cr_code , itm_det.itm_det_item_cost , itm_det.itm_det_std_cost , itm_det.itm_det_avg_cost , itm_det.itm_det_last_cost , itm_mst.RowID , itm_mst.itm_mst_desc , itm_det.itm_det_auto_spare FROM itm_mst , itm_det WHERE ( itm_mst.RowID =itm_det.mst_RowID ) AND ( itm_mst.itm_mst_stockno =@P1 ) AND ( itm_mst.site_cd =@P2 ) ',N'@P1 nvarchar(25),@P2 nvarchar(4)',N'STK101633',N'QMS'
go
exec sp_executesql N'SELECT itm_loc_stock_cost_flag FROM itm_loc WHERE site_cd =@P1 AND mst_RowID =@P2 AND itm_loc_stk_loc =@P3 ',N'@P1 nvarchar(4),@P2 int,@P3 nvarchar(30)',N'QMS',2656,N'HQ-001-0001'
go


exec sp_executesql N'update itm_mst SET itm_mst_ttl_oh =COALESCE ( itm_mst_ttl_oh , 0 ) - @P1 , itm_mst_issue_price =@P2 WHERE ( itm_mst.RowID =@P3 ) ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 int',N'2.0000',N'257.5733',2656
go
exec sp_executesql N'update itm_det SET itm_det_ttl_oh =COALESCE ( itm_det_ttl_oh , 0 ) - @P1 , itm_det_ytd_usage =COALESCE ( itm_det_ytd_usage , 0 ) + @P2 , itm_det_item_cost =@P3 , itm_det_issue_price =@P4 , itm_det_lastactdate =GetDate ( ) WHERE ( itm_det.mst_RowID =@P5 ) ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 nvarchar(79),@P4 nvarchar(79),@P5 int',N'2.0000',N'2.0000',N'257.5733',N'257.5733',2656
go
exec sp_executesql N'update itm_loc SET itm_loc_oh_qty =COALESCE ( itm_loc_oh_qty , 0 ) - @P1 , itm_loc_lastactdate =GetDate ( ) WHERE ( itm_loc.mst_RowID =@P2 ) AND ( itm_loc_stk_loc =@P3 ) ',N'@P1 nvarchar(79),@P2 int,@P3 nvarchar(30)',N'2.0000',2656,N'HQ-001-0001'
go


exec sp_executesql N'SELECT itm_mtc.site_cd,   
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
  WHERE ( itm_mtc.itm_mtc_rcv_qty > itm_mtc.itm_mtc_isu_qty )
   AND	( itm_mtc.site_cd = @P1 )
   AND	( itm_mtc.itm_mtc_stockno = @P2 )
   AND 	( itm_mtc_stk_locn = @P3 )
',N'@P1 nvarchar(4),@P2 nvarchar(25),@P3 nvarchar(30)',N'QMS',N'STK101633',N'HQ-001-0001'
go
exec sp_executesql N'update itm_mtc SET itm_mtc_isu_qty =itm_mtc_isu_qty + @P1 WHERE RowID =@P2 ',N'@P1 nvarchar(79),@P2 int',N'1.0000',84967
go


exec sp_executesql N'INSERT INTO itm_mtu ( site_cd , itm_mtu_activity_code , itm_mtu_doc_no , itm_mtu_wo , itm_mtu_stockno , itm_mtu_stk_locn , itm_mtu_mtr_no , itm_mtu_mtr_lineno , itm_mtu_desc , itm_mtu_usg_date , itm_mtu_cur_date , itm_mtu_used_qty , itm_mtu_used_uom , itm_mtu_item_cost , itm_mtu_chg_costcenter , itm_mtu_chg_account , itm_mtu_crd_costcenter , itm_mtu_crd_account , itm_mtu_assetno , itm_mtu_projectid , itm_mtu_nonstkitem , itm_mtu_supplier , itm_mtu_login_id , itm_mtu_work_type , itm_mtu_ref_doc_no , itm_mtu_cost_cat_id , itm_mtu_mt_special_idno , itm_mtu_mtc_id , itm_mtu_mts_id , itm_mtu_remark , audit_user , audit_date ) VALUES ( @P1 , '''' , @P2 , @P3 , @P4 , @P5 , '''' , 0 , @P6 , GetDate ( ) , GetDate ( ) , @P7 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , @P14 , '''' , '''' , '''' , @P15 , '''' , @P16 , 0 , 0 , @P17 , 0 , @P18 , @P19 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 nvarchar(11),@P4 nvarchar(25),@P5 nvarchar(30),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(8),@P9 nvarchar(79),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(50),@P13 nvarchar(50),@P14 nvarchar(30),@P15 nvarchar(25),@P16 nvarchar(11),@P17 int,@P18 nvarchar(100),@P19 nvarchar(50)',N'QMS',N'ISU124831',NULL,N'STK101633',N'HQ-001-0001',N'Ball bearing ',N'1.0000',N'UNIT',N'257.5733',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,N'tomms',N'RCV110182',84967,NULL,N'tomms'
go
exec sp_executesql N'update itm_mtc SET itm_mtc_isu_qty =itm_mtc_isu_qty + @P1 WHERE RowID =@P2 ',N'@P1 nvarchar(79),@P2 int',N'1.0000',84969
go
exec sp_executesql N'INSERT INTO itm_mtu ( site_cd , itm_mtu_activity_code , itm_mtu_doc_no , itm_mtu_wo , itm_mtu_stockno , itm_mtu_stk_locn , itm_mtu_mtr_no , itm_mtu_mtr_lineno , itm_mtu_desc , itm_mtu_usg_date , itm_mtu_cur_date , itm_mtu_used_qty , itm_mtu_used_uom , itm_mtu_item_cost , itm_mtu_chg_costcenter , itm_mtu_chg_account , itm_mtu_crd_costcenter , itm_mtu_crd_account , itm_mtu_assetno , itm_mtu_projectid , itm_mtu_nonstkitem , itm_mtu_supplier , itm_mtu_login_id , itm_mtu_work_type , itm_mtu_ref_doc_no , itm_mtu_cost_cat_id , itm_mtu_mt_special_idno , itm_mtu_mtc_id , itm_mtu_mts_id , itm_mtu_remark , audit_user , audit_date ) VALUES ( @P1 , '''' , @P2 , @P3 , @P4 , @P5 , '''' , 0 , @P6 , GetDate ( ) , GetDate ( ) , @P7 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , @P14 , '''' , '''' , '''' , @P15 , '''' , @P16 , 0 , 0 , @P17 , 0 , @P18 , @P19 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 nvarchar(11),@P4 nvarchar(25),@P5 nvarchar(30),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(8),@P9 nvarchar(79),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(50),@P13 nvarchar(50),@P14 nvarchar(30),@P15 nvarchar(25),@P16 nvarchar(11),@P17 int,@P18 nvarchar(100),@P19 nvarchar(50)',N'QMS',N'ISU124831',NULL,N'STK101633',N'HQ-001-0001',N'Ball bearing ',N'1.0000',N'UNIT',N'257.5733',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,N'tomms',N'RCV110182',84969,NULL,N'tomms'
go
exec sp_executesql N'INSERT INTO itm_trx ( site_cd , itm_trx_doc_no , itm_trx_trx_type , itm_trx_curr_date , itm_trx_trx_date , 
itm_trx_isu_empl_id , itm_trx_rcv_empl_id , itm_trx_stockno , itm_trx_desc , itm_trx_partno , itm_trx_com_code , itm_trx_isu_qty , 
itm_trx_rcv_qty , itm_trx_ord_qty , itm_trx_rtn_qty , itm_trx_bo_qty , itm_trx_chg_costcenter , itm_trx_chg_account , itm_trx_crd_costcenter , 
itm_trx_crd_account , itm_trx_assetno , itm_trx_wo , itm_trx_mtlrqnnum , itm_trx_item_cost , itm_trx_uom , itm_trx_cnv_qty , itm_trx_pkguom , 
itm_trx_ext_cost , itm_trx_porqnnum , itm_trx_approver , itm_trx_supplier , itm_trx_pono , itm_trx_po_lineno , itm_trx_ttl_oh , 
itm_trx_stk_locn , itm_trx_oh_qty , itm_trx_comments , itm_trx_to_stk_locn , itm_trx_mtlrqn_lineno , itm_trx_grn_no , itm_trx_grn_itm_no , itm_trx_posted , itm_trx_avg_cost , itm_trx_std_cost , itm_trx_last_cost , itm_trx_consigned , itm_trx_receive_doc_note , itm_trx_inv_qty , itm_trx_inv_uom , itm_trx_liability_acc , itm_trx_raw_cost , itm_trx_rcv_cost , itm_trx_rcv_date , itm_trx_pkg_slip_no , itm_trx_mt_special_idno , itm_trx_cost_cat_id , itm_trx_mtcs_ref_id , itm_trx_return_fee , itm_trx_mtrtnsup_ref_id , itm_trx_mtrtnsup_lineno , itm_trx_mtns_ref_id , itm_trx_inv_id , itm_trx_inv_lineno , itm_trx_rev_inv , itm_trx_ret_supp , itm_trx_mkey , itm_trx_status , itm_trx_projectid , itm_trx_login_id , itm_trx_cnx_qty , itm_trx_fifo_avg_cost , itm_trx_remark , audit_user , audit_date ) VALUES ( @P1 , @P2 , ''MT21'' , GetDate ( ) , @P3 , @P4 , '''' , @P5 , @P6 , '''' , '''' , @P7 , 0 , 0 , 0 , 0 , @P8 , @P9 , @P10 , @P11 , @P12 , @P13 , NULL , @P14 , @P15 , 0 , '''' , @P16 , '''' , '''' , '''' , '''' , 0 , 0 , @P17 , 0 , '''' , '''' , 0 , '''' , 0 , '''' , @P18 , @P19 , @P20 , '''' , 0 , NULL , '''' , '''' , @P21 , 0 , 0 , 0 , '''' , '''' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , '''' , '''' , '''' , '''' , '''' , @P22 , 0 , @P23 , @P24 , @P25 , GetDate ( ) ) ',N'@P1 nvarchar(4),@P2 nvarchar(11),@P3 datetime,@P4 nvarchar(25),@P5 nvarchar(25),@P6 nvarchar(2000),@P7 nvarchar(79),@P8 nvarchar(50),@P9 nvarchar(50),@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(30),@P13 nvarchar(11),@P14 nvarchar(79),@P15 nvarchar(8),@P16 nvarchar(79),@P17 nvarchar(30),@P18 nvarchar(79),@P19 nvarchar(79),@P20 nvarchar(79),@P21 nvarchar(79),@P22 nvarchar(25),@P23 nvarchar(79),@P24 nvarchar(255),@P25 nvarchar(50)',N'QMS',N'ISU124831','2017-01-01 00:00:00',N'MMD4',N'STK101633',N'Ball bearing ',N'2.0000',N'TSD-HQ1-001',N'251109 ',N'TSD-HQ1-001',N'251102',NULL,NULL,N'257.5733',N'UNIT',N'515.1466',N'HQ-001-0001',N'257.5733',N'0.0000',N'12.7200',N'515.1466',N'tomms',N'257.5733',NULL,N'tomms'
go

exec sp_executesql N'update cf_budget_charge SET per1 =per1 + @P1 , per2 =per2 + @P2 , per3 =per3 + @P3 , per4 =per4 + @P4 , per5 =per5 + @P5 , per6 =per6 + @P6 , per7 =per7 + @P7 , per8 =per8 + @P8 , per9 =per9 + @P9 , per10 =per10 + @P10 , per11 =per11 + @P11 , per12 =per12 + @P12 WHERE site_cd =@P13 AND budget_year =@P14 AND costcenter =@P15 AND account =@P16 ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 nvarchar(79),@P4 nvarchar(79),@P5 nvarchar(79),@P6 nvarchar(79),@P7 nvarchar(79),@P8 nvarchar(79),@P9 nvarchar(79),@P10 nvarchar(79),@P11 nvarchar(79),@P12 nvarchar(79),@P13 nvarchar(4),@P14 smallint,@P15 nvarchar(50),@P16 nvarchar(50)',N'270.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'QMS',2017,N'TSD-HQ1-001',N'251109 '
go
exec sp_executesql N'update cf_budget_credit SET per1 =per1 + @P1 , per2 =per2 + @P2 , per3 =per3 + @P3 , per4 =per4 + @P4 , per5 =per5 + @P5 , per6 =per6 + @P6 , per7 =per7 + @P7 , per8 =per8 + @P8 , per9 =per9 + @P9 , per10 =per10 + @P10 , per11 =per11 + @P11 , per12 =per12 + @P12 WHERE site_cd =@P13 AND budget_year =@P14 AND costcenter =@P15 AND account =@P16 ',N'@P1 nvarchar(79),@P2 nvarchar(79),@P3 nvarchar(79),@P4 nvarchar(79),@P5 nvarchar(79),@P6 nvarchar(79),@P7 nvarchar(79),@P8 nvarchar(79),@P9 nvarchar(79),@P10 nvarchar(79),@P11 nvarchar(79),@P12 nvarchar(79),@P13 nvarchar(4),@P14 smallint,@P15 nvarchar(50),@P16 nvarchar(50)',N'270.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'0.0000',N'QMS',2017,N'TSD-HQ1-001',N'251101'

