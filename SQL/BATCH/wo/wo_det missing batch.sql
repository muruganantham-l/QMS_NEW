SELECT d.* from wko_mst m join wko_det d on m.RowID = d.mst_RowID  where m.wko_mst_wo_no	=	'CWO194054'--wrong

SELECT d.wko_det_parent_wo,d.wko_det_act_code, d.* from wko_mst m join wko_det d on m.RowID = d.mst_RowID where m.wko_mst_wo_no = 'CWO194132'--correct

update d set wko_det_approver ='NSNCC6' ,wko_det_perm_id = 'SOUTHERN'
,wko_det_approved = 0,wko_det_safety = 0,wko_det_sc_date = '2018-12-20 15:06:00.000',wko_det_exc_date = '2018-12-20 16:00:00.000'
,wko_det_sched_date = '2018-12-20 15:30:00.000',wko_det_corr_action = 'TEMPERATURE TOO HIGH',wko_det_maccount = 'NA'
,wko_det_est_lab_cost = 0,wko_det_est_mtl_cost=0,wko_det_est_con_cost=0,wko_det_lab_cost=0,wko_det_mtl_cost=0,wko_det_con_cost=0
,wko_det_chg_costcenter = 'NSB017-K-KPH',wko_det_budget = 0 ,wko_det_wo_limit=0,wko_det_wo_open = 'Y'
,wko_det_varchar1 = 'KK5',wko_det_varchar2 = 'KESIHATAN',wko_det_varchar4 = 'SOUTHERN',wko_det_varchar9 = 'BATCH 3',wko_det_varchar8 = 'New Biomedical'
,wko_det_varchar10 = 'TCL00001',wko_det_varchar5 = 'Thermo Fisher Scientific',wko_det_varchar6 = 'PLR386',wko_det_varchar7 = '38600315080468'
,wko_det_customer_cd = 'NSB017',wko_det_note1 ='Klinik Kesihatan Sri Menanti',wko_det_varchar3 = 'Jalan Tanah Datar,Seri Menanti 71550 Kuala Pilah'
 from wko_mst m join wko_det d on m.RowID = d.mst_RowID  where m.wko_mst_wo_no	=	'CWO194054'

 SELECT * from wko_mst m join wko_ls2 l on m.RowID =l.mst_RowID and m.wko_mst_wo_no = 'CWO194132'
 SELECT cus_mst_shipvia,* from cus_mst m join cus_det d on m.RowID = d.mst_RowID where m.cus_mst_customer_cd = 'NSB017'