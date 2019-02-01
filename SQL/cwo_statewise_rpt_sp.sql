alter proc cwo_statewise_rpt_sp
@state varchar(100)
,@month_year  varchar(100)
as
begin

set nocount on
 


select 
replace(replace(wko_mst_wo_no				,char(10),''),chAR(13),'')						'WO Number',
replace(replace(wko_mst_assetno				,char(10),''),chAR(13),'')						'BE Number',
replace(replace(wko_det_parent_wo			,char(10),''),chAR(13),'')						'Parent WO',
replace(replace(wko_det_pm_grp				,char(10),''),chAR(13),'')						'PM Group',
replace(replace(wko_mst_status				,char(10),''),chAR(13),'')						'WO Status',
replace(replace(wko_mst_descs				,char(10),''),chAR(13),'')							'Problem Reported',
FORMAT(cast(replace(replace(wko_mst_org_date			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')						'WO Date & Time',
FORMAT(cast(replace(replace(wko_mst_due_date			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')						'Due Date',
replace(replace(wko_mst_chg_costcenter		,char(10),''),chAR(13),'')								'Charge Cost Center',
FORMAT(cast(replace(replace(wko_det_cmpl_date			,char(10),''),chAR(13),'') as DATETIME),'dd/MM/yyyy hh:mm:ss')							'Competion Date & Time',
FORMAT(cast(replace(replace(wko_det_clo_date			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')						'Close Date & Time',
replace(replace(wko_det_assign_to			,char(10),''),chAR(13),'')							'Assign To',
replace(replace(wko_det_planner				,char(10),''),chAR(13),'')							'Planner',
replace(replace(wko_mst_flt_code			,char(10),''),chAR(13),'')							'Problem Code',
replace(replace(wko_det_cause_code			,char(10),''),chAR(13),'')							'Cause Code',
replace(replace(wko_det_act_code			,char(10),''),chAR(13),'')							'Action Code',
replace(replace(wko_mst_originator			,char(10),''),chAR(13),'')							'Requester Name',
replace(replace(wko_mst_phone				,char(10),''),chAR(13),'')								'Requester Contact No',
replace(replace(wko_mst_project_id			,char(10),''),chAR(13),'')								'Project ID',
replace(replace(wko_mst_work_area			,char(10),''),chAR(13),'')								'Circle',
replace(replace(wko_mst_asset_location		,char(10),''),chAR(13),'')							'District',
replace(replace(wko_mst_asset_level			,char(10),''),chAR(13),'')								'WO State',
replace(replace(wko_mst_asset_group_code	,char(10),''),chAR(13),'')									'BE Code',
replace(replace(wko_mst_orig_priority		,char(10),''),chAR(13),'')						'Original Priority',
replace(replace(wko_mst_plan_priority		,char(10),''),chAR(13),'')								'Plan Priority',
replace(replace(wko_det_temp_asset			,char(10),''),chAR(13),'')										'Loaner Equipment',
replace(replace(wko_det_wr_no				,char(10),''),chAR(13),'')								'WR Number',
replace(replace(wko_det_perm_id				,char(10),''),chAR(13),'')								'Zone',
replace(replace(wko_det_work_type			,char(10),''),chAR(13),'')								'WO Conditional Status',
replace(replace(wko_det_work_type			,char(10),''),chAR(13),'')								'SM Type',
replace(replace(wko_det_work_grp			,char(10),''),chAR(13),'')									'Work Group',
replace(replace(wko_det_sc_date				,char(10),''),chAR(13),'')						'Status Change Date',
FORMAT(cast(replace(replace(wko_det_sched_date			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')				 'Acknowledge Date & Time',
replace(replace(wko_det_contract_no			,char(10),''),chAR(13),'')					'Contract No',
replace(replace(wko_det_delay_cd			,char(10),''),chAR(13),'')						'Delay Code',
replace(replace(wko_det_customer_cd			,char(10),''),chAR(13),'')						'Clinic Code',
replace(replace(wko_det_supv_id				,char(10),''),chAR(13),'')			'Supervisor ID',
replace(replace(wko_det_est_con_cost		,char(10),''),chAR(13),'')				'Estimated Contract Cost',
replace(replace(wko_det_con_cost			,char(10),''),chAR(13),'')				'Contract Cost',
replace(replace(wko_det_est_mtl_cost		,char(10),''),chAR(13),'')						'Estimated Material Cost',
replace(replace(wko_det_mtl_cost			,char(10),''),chAR(13),'')						'Material Cost',
replace(replace(wko_det_est_lab_cost		,char(10),''),chAR(13),'')					'Estimated Labor Cost',
replace(replace(wko_det_lab_cost			,char(10),''),chAR(13),'')									 'Labor Cost',
replace(replace(wko_det_varchar1			,char(10),''),chAR(13),'')									 'Clinic Type',
replace(replace(wko_det_varchar2			,char(10),''),chAR(13),'')									 'Clinic Category',
replace(replace(wko_det_varchar3			,char(10),''),chAR(13),'')									 'Clinic Address',
replace(replace(wko_det_varchar4			,char(10),''),chAR(13),'')									 'Clinic Zone',
replace(replace(wko_det_varchar5			,char(10),''),chAR(13),'')									 'Manufacturer',
replace(replace(wko_det_varchar6			,char(10),''),chAR(13),'')									 'Model',
replace(replace(wko_det_varchar7			,char(10),''),chAR(13),'')									 'Serial No',
replace(replace(wko_det_varchar8			,char(10),''),chAR(13),'')									 'Ownership',
replace(replace(wko_det_varchar9			,char(10),''),chAR(13),'')									 'Clinic Contact',
replace(replace(wko_det_numeric1			,char(10),''),chAR(13),'')									 'VCM Proposed Amount',
replace(replace(wko_det_numeric3			,char(10),''),chAR(13),'')									 'VCM Agreed Amount',
FORMAT(cast(replace(replace(wko_det_datetime1			,char(10),''),chAR(13),'')		as DATETIME),'dd/MM/yyyy hh:mm:ss')							'PPM Reschedule Date',
FORMAT(cast(replace(replace(wko_det_datetime4			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')							'Rejected Date',
FORMAT(cast(replace(replace(wko_det_exc_date			,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')							'Response Date & Time',
replace(replace(wko_det_note1				,char(10),''),chAR(13),'')								'Clinic Name',
replace(replace(wko_mst_create_by			,char(10),''),chAR(13),'')									'Created by',
FORMAT(cast(replace(replace(wko_mst_create_date			,char(10),''),chAR(13),'') as DATETIME)	,'dd/MM/yyyy hh:mm:ss')							'Created Date & Time'
--FORMAT(cast(replace(replace(m.wkr_mst_org_date,char(10),''),chAR(13),'')	as DATETIME),'dd/MM/yyyy hh:mm:ss')		'Work requst date time'
  	 									 
 
from wko_mst (nolock) join
wko_det  (nolock)
on wko_mst.rowid = wko_det.mst_RowID
--and left(wko_mst_wo_no,3) = 'CWO'
 --and wko_mst_wo_no = 'CWO184059'
--and year(wko_mst_org_date) = 2018
--and wko_mst_chg_costcenter like 'WKL%'
--join wkr_mst m on
--wko_det_wr_no = m.wkr_mst_wr_no
 join wo_pr_pending_rpt_tbl (NOLOCK) w on w.wo_no = wko_mst_wo_no
 and w.wo_state = @state
 and w.month_year = @month_year

set nocount OFF
end