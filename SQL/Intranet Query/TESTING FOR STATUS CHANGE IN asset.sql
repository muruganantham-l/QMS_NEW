Declare @ex_rate numeric(5,4) = 5.606
select 1.0000/@ex_rate
select * from  puo_mst
where puo_mst_po_no = 'PO108507'

update puo_ls1
--set puo_ls1_item_cost = puo_ls1_retail_price * @ex_rate,
--puo_ls1_cur_exchange_rate = 1/@ex_rate
where mst_rowid in (select rowid from puo_mst
where puo_mst_po_no = 'PO108507')
update puo_mst
--set puo_mst_exchange_rate = 1/@ex_rate
where puo_mst_po_no = 'PO108507'

ast_mst_trigger
ktgbme2

FROM sys.dm_exec_requests er
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st

master..logonauditing
order by logontime desc

st.text



JHRSC2


select execquery.last_execution_time as [datetime],
execsql.text as script 
from sys.dm_exec_query_stats as execquery 
cross apply sys.dm_exec_sql_text(execquery.sql_handle) as execsql 
where last_execution_time between convert(datetime,'2017-05-07 22:17') and convert(datetime,'2017-05-07 22:27')
ORDER BY last_execution_time DESC

JHR024099

SELECT 	wko_mst.site_cd,     			wko_mst.wko_mst_wo_no,     			
wko_mst.wko_mst_originator,     			wko_mst.wko_mst_phone,     			
wko_mst.wko_mst_asset_level,     			wko_mst.wko_mst_assetno,     			
wko_mst.wko_mst_flt_code,     			wko_mst.wko_mst_status,      			
wko_mst.wko_mst_due_date,     			wko_mst.wko_mst_descs,     			wko_mst.wko_mst_project_id,     			wko_mst.wko_mst_org_date,     			wko_mst.wko_mst_chg_costcenter,     			wko_mst.wko_mst_work_area,     			wko_mst.wko_mst_asset_location,     			
wko_mst.wko_mst_asset_group_code,     			wko_mst.wko_mst_orig_priority,     			
wko_mst.wko_mst_plan_priority,     			wko_mst.wko_mst_type,     			wko_mst.wko_mst_pm_grp,
     			wko_mst.audit_user,     			wko_mst.audit_date,     			
				wko_mst.wko_mst_create_by,     			wko_mst.wko_mst_create_date,     			
				wko_mst.column1,     			wko_mst.column2,     			wko_mst.column3,     			
				wko_mst.column4,     			wko_mst.column5,     			wko_mst.RowID,     			
				wko_det.wko_det_cmpl_date,     			wko_det.wko_det_planner,     			
				wko_det.wko_det_assign_to,     			wko_det.wko_det_wr_no,     			
				wko_det.wko_det_supv_id,     			wko_det.wko_det_approver,     			
				wko_det.wko_det_perm_id,     			wko_det.wko_det_approved,     			
				wko_det.wko_det_safety,     			wko_det.wko_det_pm_grp,     			
				wko_det.wko_det_grp_code,     			wko_det.wko_det_pm_idno,     			
				wko_det.wko_det_work_type,     			wko_det.wko_det_work_locn,     			
				wko_det.wko_det_work_grp,     	      wko_det.wko_det_work_class,     			
				wko_det.wko_det_clo_date,     			wko_det.wko_det_sched_date,    			wko_det.wko_det_sc_date,    			wko_det.wko_det_est_lab_cost,     			wko_det.wko_det_est_mtl_cost,     			wko_det.wko_det_est_con_cost,     			wko_det.wko_det_lab_cost,     			wko_det.wko_det_mtl_cost,     			wko_det.wko_det_con_cost,     			wko_det.wko_det_corr_action,     			wko_det.wko_det_chg_costcenter,     			wko_det.wko_det_crd_costcenter,     			wko_det.wko_det_laccount,     			wko_det.wko_det_maccount,     			wko_det.wko_det_caccount,     			wko_det.wko_det_wo_limit,     			wko_det.wko_det_wo_open,     			wko_det.wko_det_cause_code,  			wko_det.wko_det_act_code ,  			wko_det.wko_det_parent_wo,  			wko_det.wko_det_varchar1,     			wko_det.wko_det_varchar2,     			wko_det.wko_det_varchar3,     			wko_det.wko_det_varchar4,     			wko_det.wko_det_varchar5,     			wko_det.wko_det_varchar6,     			wko_det.wko_det_varchar7,     			wko_det.wko_det_varchar8,     			wko_det.wko_det_varchar9,     			wko_det.wko_det_varchar10,     			wko_det.wko_det_numeric1,     			wko_det.wko_det_numeric2,     			wko_det.wko_det_numeric3,     			wko_det.wko_det_numeric4,     			wko_det.wko_det_numeric5,  			wko_det.wko_det_datetime1,     			wko_det.wko_det_datetime2,     			wko_det.wko_det_datetime3,     			wko_det.wko_det_datetime4,     			wko_det.wko_det_datetime5,     	      wko_det.wko_det_customer_cd,  			wko_det.wko_det_temp_asset,  			wko_det.wko_det_contract_no,  			wko_det.wko_det_delay_cd,  			start_date = Convert(Datetime, ''),  			due_date = Convert(Datetime, '')  FROM 	wko_mst,     		wko_det  WHERE	wko_mst.site_cd = wko_det.site_cd  AND 	wko_mst.rowid = wko_det.mst_rowid  AND	wko_mst.wko_mst_wo_no like 'C%'  AND	wko_mst.wko_mst_status <> 'CLO'  
 AND wko_det.wko_det_assign_to = 'KTGBME2' AND wko_det.wko_det_assign_to = 'KTGBME2'
 AND wko_mst_assetno = 'JHR024099'


 master..logonauditing
 WHERE LoginName = 'ktgbme2'
order by logontime desc

