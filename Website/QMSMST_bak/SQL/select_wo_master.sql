 alter proc select_wo_master
@state varchar(300) = null
as
begin 
set nocount on
if @state = 'all'
select @state = null

select 
wko_mst_wo_no						--			'WO Number',
,wko_mst_assetno					--				'BE Number',
,wko_det_parent_wo					--			'Parent WO',
,wko_det_pm_grp						--			'PM Group',
,wko_mst_status						--			'WO Status',
,wko_mst_descs						--			'Problem Reported',
,wko_mst_org_date					--						'WO Date & Time',
,wko_mst_due_date					--					'Due Date',
,wko_mst_chg_costcenter				--				'Charge Cost Center',
,wko_det_cmpl_date					--			'Competion Date & Time',
,wko_det_clo_date					--		'Close Date & Time',
,wko_det_assign_to					--			'Assign To',
,wko_det_planner					--							 'Planner',
,wko_mst_flt_code					--				'Problem Code',
,wko_det_cause_code					--					'Cause Code',
,wko_det_act_code					--			 'Action Code',
,wko_mst_originator					--				 'Requester Name',
,wko_mst_phone						--		'Requester Contact No',
,wko_mst_project_id					--				'Project ID',
,wko_mst_work_area					--				'Circle',
,wko_mst_asset_location				--						'District',
,wko_mst_asset_level				--						'WO State',
,wko_mst_asset_group_code			--					'BE Code',
,wko_mst_orig_priority				--							'Original Priority',
,wko_mst_plan_priority				--							'Plan Priority',
,wko_det_temp_asset					--						'Loaner Equipment',
,wko_det_wr_no						--								'WR Number',
,wko_det_perm_id					--								'Zone',
,wko_det_work_type					--				 'WO Conditional Status',
--,wko_det_work_type				--							'SM Type',
,wko_det_work_grp					--						'Work Group',
,wko_det_sc_date					--						'Status Change Date',
,wko_det_sched_date					--					'Acknowledge Date & Time',
,wko_det_contract_no				--							 'Contract No',
,wko_det_delay_cd					--				'Delay Code',
,wko_det_customer_cd				--							'Clinic Code',
,wko_det_supv_id					--								 'Supervisor ID',
,wko_det_est_con_cost				--				'Estimated Contract Cost',
,wko_det_con_cost					--					'Contract Cost',
,wko_det_est_mtl_cost				--				 'Estimated Material Cost',
,wko_det_mtl_cost					--					'Material Cost',
,wko_det_est_lab_cost				--					 'Estimated Labor Cost',
,wko_det_lab_cost					--						'Labor Cost',
,wko_det_varchar1					--						'Clinic Type',
,wko_det_varchar2					--						'Clinic Category',
,wko_det_varchar3					--						'Clinic Address',
,wko_det_varchar4					--						'Clinic Zone',
,wko_det_varchar5					--						'Manufacturer',
,wko_det_varchar6					--						'Model',
,wko_det_varchar7					--						'Serial No',
,wko_det_varchar8					--						'Ownership',
,wko_det_varchar9					--						'Clinic Contact',
,wko_det_numeric1					--						'VCM Proposed Amount',
,wko_det_numeric3					--						'VCM Agreed Amount',
,wko_det_datetime1					--						 'PPM Reschedule Date',
,wko_det_datetime4					--						 'Rejected Date',
,wko_det_exc_date					--						'Response Date & Time',
,wko_det_note1						--							 'Clinic Name',
,wko_mst_create_by					--							 'Created by',
,wko_mst_create_date				--									'Created Date & Time'
from wko_mst,
wko_det 
where wko_mst.rowid = wko_det.mst_RowID
 --and wko_mst_wo_no = 'CWO100002'
--and left(wko_mst_wo_no,3) = 'PWO'
--and year(wko_mst_org_date)
and (wko_mst_asset_level = @state or @state is null)
--and wko_mst_chg_costcenter like 'WKL%'
--and wko_mst_assetno like 'WK%'
--and wko_mst_status = 'OPE'
set nocount off
end


