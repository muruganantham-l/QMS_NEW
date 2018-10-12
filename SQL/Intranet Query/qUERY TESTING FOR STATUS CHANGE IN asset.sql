UPDATE wko_mst
--SET wko_mst_status = 'CMP'
--	,audit_user = 'ktgbme2'
--	,audit_date = getdate()
WHERE RowID = 293061

SELECT wko_mst.wko_mst_status
	,wko_det.wko_det_wo_open
	,wko_det.wko_det_temp_asset
	,Coalesce(wko_mst.wko_mst_assetno, '')
	,wko_mst.wko_mst_type
	,wko_det.wko_det_exc_date
	,wko_det.wko_det_sched_date
	,wko_det.wko_det_cmpl_date
FROM wko_mst
	,wko_det
WHERE wko_mst.site_cd = wko_det.site_cd
	AND wko_mst.RowID = wko_det.mst_RowID
	AND wko_mst.site_cd = 'QMS'
	AND wko_mst.RowID = 293061

SELECT wko_mst.site_cd
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_originator
	,wko_mst.wko_mst_phone
	,wko_mst.wko_mst_asset_level
	,wko_mst.wko_mst_assetno
	,wko_mst.wko_mst_flt_code
	,wko_mst.wko_mst_status
	,wko_mst.wko_mst_due_date
	,wko_mst.wko_mst_descs
	,wko_mst.wko_mst_project_id
	,wko_mst.wko_mst_org_date
	,wko_mst.wko_mst_chg_costcenter
	,wko_mst.wko_mst_work_area
	,wko_mst.wko_mst_asset_location
	,wko_mst.wko_mst_asset_group_code
	,wko_mst.wko_mst_orig_priority
	,wko_mst.wko_mst_plan_priority
	,wko_mst.wko_mst_type
	,wko_mst.wko_mst_pm_grp
	,wko_mst.audit_user
	,wko_mst.audit_date
	,wko_mst.wko_mst_create_by
	,wko_mst.wko_mst_create_date
	,wko_mst.column1
	,wko_mst.column2
	,wko_mst.column3
	,wko_mst.column4
	,wko_mst.column5
	,wko_mst.RowID
	,wko_det.wko_det_cmpl_date
	,wko_det.wko_det_planner
	,wko_det.wko_det_assign_to
	,wko_det.wko_det_wr_no
	,wko_det.wko_det_supv_id
	,wko_det.wko_det_approver
	,wko_det.wko_det_perm_id
	,wko_det.wko_det_approved
	,wko_det.wko_det_safety
	,wko_det.wko_det_pm_grp
	,wko_det.wko_det_grp_code
	,wko_det.wko_det_pm_idno
	,wko_det.wko_det_work_type
	,wko_det.wko_det_work_locn
	,wko_det.wko_det_work_grp
	,wko_det.wko_det_work_class
	,wko_det.wko_det_clo_date
	,wko_det.wko_det_sched_date
	,wko_det.wko_det_sc_date
	,wko_det.wko_det_est_lab_cost
	,wko_det.wko_det_est_mtl_cost
	,wko_det.wko_det_est_con_cost
	,wko_det.wko_det_lab_cost
	,wko_det.wko_det_mtl_cost
	,wko_det.wko_det_con_cost
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_chg_costcenter
	,wko_det.wko_det_crd_costcenter
	,wko_det.wko_det_laccount
	,wko_det.wko_det_maccount
	,wko_det.wko_det_caccount
	,wko_det.wko_det_wo_limit
	,wko_det.wko_det_wo_open
	,wko_det.wko_det_cause_code
	,wko_det.wko_det_act_code
	,wko_det.wko_det_parent_wo
	,wko_det.wko_det_varchar1
	,wko_det.wko_det_varchar2
	,wko_det.wko_det_varchar3
	,wko_det.wko_det_varchar4
	,wko_det.wko_det_varchar5
	,wko_det.wko_det_varchar6
	,wko_det.wko_det_varchar7
	,wko_det.wko_det_varchar8
	,wko_det.wko_det_varchar9
	,wko_det.wko_det_varchar10
	,wko_det.wko_det_numeric1
	,wko_det.wko_det_numeric2
	,wko_det.wko_det_numeric3
	,wko_det.wko_det_numeric4
	,wko_det.wko_det_numeric5
	,wko_det.wko_det_datetime1
	,wko_det.wko_det_datetime2
	,wko_det.wko_det_datetime3
	,wko_det.wko_det_datetime4
	,wko_det.wko_det_datetime5
	,wko_det.wko_det_customer_cd
	,wko_det.wko_det_temp_asset
	,wko_det.wko_det_contract_no
	,wko_det.wko_det_delay_cd
	,start_date = Convert(DATETIME, '')
	,due_date = Convert(DATETIME, '')
FROM wko_mst
	,wko_det
WHERE wko_mst.site_cd = wko_det.site_cd
	AND wko_mst.rowid = wko_det.mst_rowid
	AND wko_mst.wko_mst_wo_no LIKE 'C%'
	AND wko_mst.wko_mst_status <> 'CLO'
	AND wko_det.wko_det_assign_to = 'KTGBME2'
	AND wko_det.wko_det_assign_to = 'KTGBME2'
	AND wko_det.wko_det_assign_to = 'KTGBME2'

UPDATE wko_mst
SET wko_mst_flt_code = 'P99'
WHERE rowid = 293061

UPDATE wko_mst
SET wko_mst_status = 'BER'
WHERE rowid = 293061

SELECT wko_det.wko_det_work_type
FROM wko_mst
	,wko_det
WHERE wko_mst.rowid = wko_det.mst_rowid
	AND wko_mst.site_cd = wko_det.site_cd
	AND wko_mst.wko_mst_wo_no = 'CWO152570'
	AND wko_mst.site_cd = 'QMS'

CREATE TRIGGER [dbo].[tr_Asset_Modified] ON [dbo].[ast_mst]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @LogonTriggerData XML
		,@LoginName VARCHAR(50)

	SET @LogonTriggerData = eventdata()
	SET @LoginName = @LogonTriggerData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(50)')

	IF 
		UPDATE (ast_mst_asset_status)

	BEGIN
		INSERT INTO ast_mst_trigger (
			benumber
			,Beforestatus
			,newstatsu
			,modifieddate
			,ModifiedUser
			,ModifiedHost
			,Loginame
			)
		SELECT S.ast_mst_asset_no
			,S.ast_mst_asset_status
			,I.ast_mst_asset_status
			,GETDATE()
			,SUSER_NAME()
			,HOST_NAME()
			,@LoginName
		FROM deleted S
		INNER JOIN Inserted I ON S.ast_mst_asset_no = I.ast_mst_asset_no
			AND S.site_cd = I.site_cd
			AND S.RowID = I.RowID
		WHERE S.ast_mst_asset_status <> I.ast_mst_asset_status
	END
END

CREATE TRIGGER [dbo].[tr_Asset_Modified] ON [dbo].[ast_mst]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @LogonTriggerData XML
		,@LoginName VARCHAR(50)

	SET @LogonTriggerData = eventdata()
	SET @LoginName = @LogonTriggerData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(50)')
	SELECT @LoginName
	IF 
		UPDATE (ast_mst_asset_status)

	BEGIN
		INSERT INTO ast_mst_trigger (
			benumber
			,Beforestatus
			,newstatsu
			,modifieddate
			,ModifiedUser
			,ModifiedHost
			,Loginame
			)
		SELECT S.ast_mst_asset_no
			,S.ast_mst_asset_status
			,I.ast_mst_asset_status
			,GETDATE()
			,SUSER_NAME()
			,HOST_NAME()
			,@LoginName
		FROM deleted S
		INNER JOIN Inserted I ON S.ast_mst_asset_no = I.ast_mst_asset_no
			AND S.site_cd = I.site_cd
			AND S.RowID = I.RowID
		WHERE S.ast_mst_asset_status <> I.ast_mst_asset_status
	END
END (
		@1 VARCHAR(8000)
		,@2 VARCHAR(8000)
		,@3 VARCHAR(8000)
		)

UPDATE [ast_mst]
--SET [ast_mst_asset_status] = @1
WHERE [ast_mst_asset_no] = 'JHR024099'
	AND [site_cd] = 'QMS'
	(@1 VARCHAR(8000), @2 INT, @3 VARCHAR(8000), @4 VARCHAR(8000), @5 VARCHAR(8000), @6 DATETIME, @7 VARCHAR(8000), @8 DATETIME)

INSERT INTO [wko_sts] (
	[site_cd]
	,[mst_RowID]
	,[wko_sts_wo_no]
	,[wko_sts_status]
	,[wko_sts_originator]
	,[wko_sts_start_date]
	,[wko_sts_end_date]
	,[wko_sts_duration]
	,[audit_user]
	,[audit_date]
	)
VALUES (
	@1
	,@2
	,@3
	,@4
	,@5
	,@6
	,NULL
	,NULL
	,@7
	,@8
	) (
	@1 DATETIME
	,@2 INT
	,@3 VARCHAR(8000)
	,@4 DATETIME
	,@5 VARCHAR(8000)
	,@6 VARCHAR(8000)
	,@7 VARCHAR(8000)
	)

UPDATE [wko_sts]
SET [wko_sts_end_date] = @1
	,[wko_sts_duration] = @2
	,[audit_user] = @3
	,[audit_date] = @4
WHERE [wko_sts_end_date] IS NULL
	AND [site_cd] = @5
	AND [wko_sts_wo_no] = @6
	AND [wko_sts_status] = @7(@1 VARCHAR(8000), @2 VARCHAR(8000))

SELECT [wko_mst_status]
FROM [wko_mst]
WHERE [wko_mst_wo_no] = 'CWO152570'
	AND [site_cd] = 'qms'

SELECT wko_mst.site_cd
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_originator
	,wko_mst.wko_mst_phone
	,wko_mst.wko_mst_asset_level
	,wko_mst.wko_mst_assetno
	,wko_mst.wko_mst_flt_code
	,wko_mst.wko_mst_status
	,wko_mst.wko_mst_due_date
	,wko_mst.wko_mst_descs
	,wko_mst.wko_mst_project_id
	,wko_mst.wko_mst_org_date
	,wko_mst.wko_mst_chg_costcenter
	,wko_mst.wko_mst_work_area
	,wko_mst.wko_mst_asset_location
	,wko_mst.wko_mst_asset_group_code
	,wko_mst.wko_mst_orig_priority
	,wko_mst.wko_mst_plan_priority
	,wko_mst.wko_mst_type
	,wko_mst.wko_mst_pm_grp
	,wko_mst.audit_user
	,wko_mst.audit_date
	,wko_mst.wko_mst_create_by
	,wko_mst.wko_mst_create_date
	,wko_mst.column1
	,wko_mst.column2
	,wko_mst.column3
	,wko_mst.column4
	,wko_mst.column5
	,wko_mst.RowID
	,wko_det.wko_det_cmpl_date
	,wko_det.wko_det_planner
	,wko_det.wko_det_assign_to
	,wko_det.wko_det_wr_no
	,wko_det.wko_det_supv_id
	,wko_det.wko_det_approver
	,wko_det.wko_det_perm_id
	,wko_det.wko_det_approved
	,wko_det.wko_det_safety
	,wko_det.wko_det_pm_grp
	,wko_det.wko_det_grp_code
	,wko_det.wko_det_pm_idno
	,wko_det.wko_det_work_type
	,wko_det.wko_det_work_locn
	,wko_det.wko_det_work_grp
	,wko_det.wko_det_work_class
	,wko_det.wko_det_clo_date
	,wko_det.wko_det_sched_date
	,wko_det.wko_det_sc_date
	,wko_det.wko_det_est_lab_cost
	,wko_det.wko_det_est_mtl_cost
	,wko_det.wko_det_est_con_cost
	,wko_det.wko_det_lab_cost
	,wko_det.wko_det_mtl_cost
	,wko_det.wko_det_con_cost
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_chg_costcenter
	,wko_det.wko_det_crd_costcenter
	,wko_det.wko_det_laccount
	,wko_det.wko_det_maccount
	,wko_det.wko_det_caccount
	,wko_det.wko_det_wo_limit
	,wko_det.wko_det_wo_open
	,wko_det.wko_det_cause_code
	,wko_det.wko_det_act_code
	,wko_det.wko_det_parent_wo
	,wko_det.wko_det_varchar1
	,wko_det.wko_det_varchar2
	,wko_det.wko_det_varchar3
	,wko_det.wko_det_varchar4
	,wko_det.wko_det_varchar5
	,wko_det.wko_det_varchar6
	,wko_det.wko_det_varchar7
	,wko_det.wko_det_varchar8
	,wko_det.wko_det_varchar9
	,wko_det.wko_det_varchar10
	,wko_det.wko_det_numeric1
	,wko_det.wko_det_numeric2
	,wko_det.wko_det_numeric3
	,wko_det.wko_det_numeric4
	,wko_det.wko_det_numeric5
	,wko_det.wko_det_datetime1
	,wko_det.wko_det_datetime2
	,wko_det.wko_det_datetime3
	,wko_det.wko_det_datetime4
	,wko_det.wko_det_datetime5
	,wko_det.wko_det_customer_cd
	,wko_det.wko_det_temp_asset
	,wko_det.wko_det_contract_no
	,wko_det.wko_det_delay_cd
	,start_date = Convert(DATETIME, '')
	,due_date = Convert(DATETIME, '')
FROM wko_mst
	,wko_det
WHERE wko_mst.site_cd = wko_det.site_cd
	AND wko_mst.rowid = wko_det.mst_rowid
	AND wko_mst.wko_mst_wo_no LIKE 'C%'
	AND wko_mst.wko_mst_status <> 'CLO'
	AND wko_det.wko_det_assign_to = 'KTGBME2'
	AND wko_det.wko_det_assign_to = 'KTGBME2'
	AND wko_mst_assetno = 'JHR024099'
SELECT MAX(wko_ls7_level)
FROM wko_ls7
WHERE mst_rowid = 293061
	AND site_cd = 'QMS'

SELECT ast_mst.site_cd
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_type
	,ast_mst.ast_mst_asset_grpcode
	,ast_mst.ast_mst_asset_status
	,ast_mst.ast_mst_work_area
	,ast_mst.ast_mst_cri_factor
	,ast_mst.ast_mst_cost_center
	,ast_mst.ast_mst_asset_locn
	,ast_mst.ast_mst_safety_rqmts
	,ast_mst.ast_mst_asset_shortdesc
	,ast_mst.ast_mst_asset_longdesc
	,ast_mst.ast_mst_perm_id
	,ast_mst.ast_mst_ast_lvl
	,ast_mst.ast_mst_parent_id
	,ast_mst.ast_mst_asset_code
	,ast_mst.ast_mst_assigned_to
	,ast_mst.ast_mst_fda_code
	,ast_mst.ast_mst_parent_flag
	,ast_mst.ast_mst_auto_no
	,ast_mst.audit_user
	,ast_mst.audit_date
	,ast_mst.ast_mst_create_by
	,ast_mst.ast_mst_create_date
	,ast_mst.ast_mst_print_count
	,ast_mst.ast_mst_wrk_grp
	,ast_sts.ast_sts_typ_cd
	,ast_det.ast_det_asset_cost
	,ast_det.ast_det_mtdlabcost
	,ast_det.ast_det_mtdmtlcost
	,ast_det.ast_det_mtdconcost
	,ast_det.ast_det_ytdlabcost
	,ast_det.ast_det_ytdmtlcost
	,ast_det.ast_det_ytdconcost
	,ast_det.ast_det_ltdlabcost
	,ast_det.ast_det_ltdmtlcost
	,ast_det.ast_det_ltdconcost
	,ast_det.ast_det_warranty_date
	,ast_det.ast_det_depr_term
	,ast_det.ast_det_repl_cost
	,ast_det.ast_det_l_account
	,ast_det.ast_det_m_account
	,ast_det.ast_det_c_account
	,ast_det.ast_det_ent_date
	,ast_det.ast_det_purchase_date
	,ast_det.ast_det_depr_date
	,ast_det.ast_det_acc_depr_cost
	,ast_det.ast_det_net_book_value
	,ast_det.ast_det_depr_by
	,ast_det.ast_det_depr_method
	,ast_det.ast_det_dispose_date
	,ast_det.ast_det_dispose_value
	,ast_det.ast_det_dispose_type
	,ast_det.ast_det_dispose_by
	,ast_det.ast_det_cus_code
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_varchar1
	,ast_det.ast_det_varchar2
	,ast_det.ast_det_varchar3
	,ast_det.ast_det_varchar4
	,ast_det.ast_det_varchar5
	,ast_det.ast_det_varchar6
	,ast_det.ast_det_varchar7
	,ast_det.ast_det_varchar8
	,ast_det.ast_det_varchar9
	,ast_det.ast_det_varchar10
	,ast_det.ast_det_varchar11
	,ast_det.ast_det_varchar12
	,ast_det.ast_det_varchar13
	,ast_det.ast_det_varchar14
	,ast_det.ast_det_varchar15
	,ast_det.ast_det_varchar16
	,ast_det.ast_det_varchar17
	,ast_det.ast_det_varchar18
	,ast_det.ast_det_varchar19
	,ast_det.ast_det_varchar20
	,ast_det.ast_det_numeric1
	,ast_det.ast_det_numeric2
	,ast_det.ast_det_numeric3
	,ast_det.ast_det_numeric4
	,ast_det.ast_det_numeric5
	,ast_det.ast_det_numeric6
	,ast_det.ast_det_numeric7
	,ast_det.ast_det_numeric8
	,ast_det.ast_det_numeric9
	,ast_det.ast_det_numeric10
	,ast_det.ast_det_datetime1
	,ast_det.ast_det_datetime2
	,ast_det.ast_det_datetime3
	,ast_det.ast_det_datetime4
	,ast_det.ast_det_datetime5
	,ast_det.ast_det_datetime6
	,ast_det.ast_det_datetime7
	,ast_det.ast_det_datetime8
	,ast_det.ast_det_datetime9
	,ast_det.ast_det_datetime10
	,ast_det.ast_det_note1
	,ast_det.ast_det_note2
	,ast_mst.column1
	,ast_mst.column2
	,ast_mst.column3
	,ast_mst.column4
	,ast_mst.column5
	,ast_mst.RowID
FROM ast_mst
	,ast_det
	,ast_sts
WHERE (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.rowid = ast_det.mst_rowid)
	AND (ast_mst.site_cd = ast_sts.site_cd)
	AND (ast_mst.ast_mst_asset_status = ast_sts.ast_sts_status)
	AND (ast_mst.site_cd = 'QMS')
	AND ast_mst_asset_locn IN (
		'BATU PAHAT'
		,'KLUANG'
		,'MERSING'
		)

SELECT ast_mst.site_cd
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_type
	,ast_mst.ast_mst_asset_grpcode
	,ast_mst.ast_mst_asset_status
	,ast_mst.ast_mst_work_area
	,ast_mst.ast_mst_cri_factor
	,ast_mst.ast_mst_cost_center
	,ast_mst.ast_mst_asset_locn
	,ast_mst.ast_mst_safety_rqmts
	,ast_mst.ast_mst_asset_shortdesc
	,ast_mst.ast_mst_asset_longdesc
	,ast_mst.ast_mst_perm_id
	,ast_mst.ast_mst_ast_lvl
	,ast_mst.ast_mst_parent_id
	,ast_mst.ast_mst_asset_code
	,ast_mst.ast_mst_assigned_to
	,ast_mst.ast_mst_fda_code
	,ast_mst.ast_mst_parent_flag
	,ast_mst.ast_mst_auto_no
	,ast_mst.audit_user
	,ast_mst.audit_date
	,ast_mst.ast_mst_create_by
	,ast_mst.ast_mst_create_date
	,ast_mst.ast_mst_print_count
	,ast_mst.ast_mst_wrk_grp
	,ast_sts.ast_sts_typ_cd
	,ast_det.ast_det_asset_cost
	,ast_det.ast_det_mtdlabcost
	,ast_det.ast_det_mtdmtlcost
	,ast_det.ast_det_mtdconcost
	,ast_det.ast_det_ytdlabcost
	,ast_det.ast_det_ytdmtlcost
	,ast_det.ast_det_ytdconcost
	,ast_det.ast_det_ltdlabcost
	,ast_det.ast_det_ltdmtlcost
	,ast_det.ast_det_ltdconcost
	,ast_det.ast_det_warranty_date
	,ast_det.ast_det_depr_term
	,ast_det.ast_det_repl_cost
	,ast_det.ast_det_l_account
	,ast_det.ast_det_m_account
	,ast_det.ast_det_c_account
	,ast_det.ast_det_ent_date
	,ast_det.ast_det_purchase_date
	,ast_det.ast_det_depr_date
	,ast_det.ast_det_acc_depr_cost
	,ast_det.ast_det_net_book_value
	,ast_det.ast_det_depr_by
	,ast_det.ast_det_depr_method
	,ast_det.ast_det_dispose_date
	,ast_det.ast_det_dispose_value
	,ast_det.ast_det_dispose_type
	,ast_det.ast_det_dispose_by
	,ast_det.ast_det_cus_code
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_varchar1
	,ast_det.ast_det_varchar2
	,ast_det.ast_det_varchar3
	,ast_det.ast_det_varchar4
	,ast_det.ast_det_varchar5
	,ast_det.ast_det_varchar6
	,ast_det.ast_det_varchar7
	,ast_det.ast_det_varchar8
	,ast_det.ast_det_varchar9
	,ast_det.ast_det_varchar10
	,ast_det.ast_det_varchar11
	,ast_det.ast_det_varchar12
	,ast_det.ast_det_varchar13
	,ast_det.ast_det_varchar14
	,ast_det.ast_det_varchar15
	,ast_det.ast_det_varchar16
	,ast_det.ast_det_varchar17
	,ast_det.ast_det_varchar18
	,ast_det.ast_det_varchar19
	,ast_det.ast_det_varchar20
	,ast_det.ast_det_numeric1
	,ast_det.ast_det_numeric2
	,ast_det.ast_det_numeric3
	,ast_det.ast_det_numeric4
	,ast_det.ast_det_numeric5
	,ast_det.ast_det_numeric6
	,ast_det.ast_det_numeric7
	,ast_det.ast_det_numeric8
	,ast_det.ast_det_numeric9
	,ast_det.ast_det_numeric10
	,ast_det.ast_det_datetime1
	,ast_det.ast_det_datetime2
	,ast_det.ast_det_datetime3
	,ast_det.ast_det_datetime4
	,ast_det.ast_det_datetime5
	,ast_det.ast_det_datetime6
	,ast_det.ast_det_datetime7
	,ast_det.ast_det_datetime8
	,ast_det.ast_det_datetime9
	,ast_det.ast_det_datetime10
	,ast_det.ast_det_note1
	,ast_det.ast_det_note2
	,ast_mst.column1
	,ast_mst.column2
	,ast_mst.column3
	,ast_mst.column4
	,ast_mst.column5
	,ast_mst.RowID
FROM ast_mst
	,ast_det
	,ast_sts
WHERE (ast_mst.ast_mst_asset_no LIKE '%jhr004035%')
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.rowid = ast_det.mst_rowid)
	AND (ast_mst.site_cd = ast_sts.site_cd)
	AND (ast_mst.ast_mst_asset_status = ast_sts.ast_sts_status)
	AND (ast_mst.site_cd = 'QMS')
	AND ast_mst_asset_locn IN (
		'BATU PAHAT'
		,'KLUANG'
		,'MERSING'
		)

SELECT ast_mst_asset_no
	,ast_mst_asset_type
	,ast_mst_asset_grpcode
	,ast_mst_asset_status
	,ast_mst_asset_shortdesc
	,ast_mst_asset_locn
	,ast_ls2_meter_id
	,ast_ls2_meter_desc
	,ast_ls2_meter_point
	,ast_ls2_usage_uom
	,ast_ls2_meter_install_date
	,ast_ls2_usage_date
	,ast_ls2_usage_reading
	,ast_ls2_old_ltd_usage
	,ast_ls2_ltd_usage
	,ast_ls2_avg_usage
	,ast_ls2_max_avg_usage
	,ast_ls2_incr_usage_flag
	,ast_ls2.RowID
FROM ast_mst
	,ast_det
	,ast_ls2
WHERE (ast_mst.ast_mst_asset_no LIKE '%jhr004035%')
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.rowid = ast_det.mst_rowid)
	AND (ast_mst.site_cd = ast_ls2.site_cd)
	AND (ast_mst.rowid = ast_ls2.mst_rowid)
	AND (ast_mst.site_cd = 'QMS')
	AND ast_mst_asset_locn IN (
		'BATU PAHAT'
		,'KLUANG'
		,'MERSING'
		)

SELECT wkr_mst.site_cd
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_org_time
	,wkr_mst.wkr_mst_taken_by
	,wkr_mst.wkr_mst_originator
	,wkr_mst.wkr_mst_phone
	,wkr_mst.wkr_mst_orig_priority
	,wkr_mst.wkr_mst_due_date
	,wkr_mst.wkr_mst_fault_code
	,wkr_mst.wkr_mst_wr_descs
	,wkr_mst.wkr_mst_assetno
	,wkr_mst.wkr_mst_wr_status
	,wkr_mst.wkr_mst_wo_status
	,wkr_mst.wkr_mst_work_type
	,wkr_mst.wkr_mst_work_class
	,wkr_mst.wkr_mst_chg_costcenter
	,wkr_mst.wkr_mst_work_group
	,wkr_mst.wkr_mst_approved
	,wkr_mst.wkr_mst_location
	,wkr_mst.wkr_mst_assetdesc
	,wkr_mst.wkr_mst_projectid
	,wkr_mst.wkr_mst_work_area
	,wkr_mst.wkr_mst_planner
	,wkr_mst.wkr_mst_assetlocn
	,wkr_mst.wkr_mst_requestor
	,wkr_mst.wkr_mst_requestor_phone
	,wkr_mst.wkr_mst_org_locn
	,wkr_mst.wkr_mst_dept
	,wkr_mst.wkr_mst_capital_project
	,wkr_mst.wkr_mst_temp_asset
	,wkr_mst.wkr_mst_email_notification
	,wkr_det.wkr_det_wo
	,wkr_det.wkr_det_approver
	,wkr_det.wkr_det_appr_date
	,wkr_det.wkr_det_reject_desc
	,wkr_det.wkr_det_reject_by
	,wkr_det.wkr_det_reject_date
	,wkr_det.wkr_det_cus_code
	,wkr_det.wkr_det_reject_flag
	,wkr_mst.audit_user
	,wkr_mst.audit_date
	,wkr_mst.wkr_mst_create_by
	,wkr_mst.wkr_mst_create_date
	,wkr_mst.column1
	,wkr_mst.column2
	,wkr_mst.column3
	,wkr_mst.column4
	,wkr_mst.column5
	,wkr_det.wkr_det_varchar1
	,wkr_det.wkr_det_varchar2
	,wkr_det.wkr_det_varchar3
	,wkr_det.wkr_det_varchar4
	,wkr_det.wkr_det_varchar5
	,wkr_det.wkr_det_varchar6
	,wkr_det.wkr_det_varchar7
	,wkr_det.wkr_det_varchar8
	,wkr_det.wkr_det_varchar9
	,wkr_det.wkr_det_varchar10
	,wkr_det.wkr_det_note1
	,wkr_mst.RowID
FROM wkr_mst
	,wkr_det
WHERE (
		wkr_mst.wkr_mst_wr_status LIKE '%w%'
		AND wkr_det.wkr_det_reject_flag <> '1'
		)
	AND (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.rowid = wkr_det.mst_rowid)
	AND (wkr_mst.site_cd = 'QMS')
	AND wkr_mst_assetlocn IN (
		'BATU PAHAT'
		,'KLUANG'
		,'MERSING'
		)

SELECT ico_name = (
		CASE 
			WHEN 'DEFAULT' = 'DEFAULT'
				THEN cf_menu.ico_name
			ELSE COALESCE(b.ico_name, cf_menu.ico_name)
			END
		)
	,cf_menu.object_name
	,object_descs = (
		CASE 
			WHEN 'DEFAULT' = 'DEFAULT'
				THEN cf_menu.object_descs
			ELSE COALESCE(b.object_descs, 'Error')
			END
		)
	,cf_menu_seq = (
		CASE 
			WHEN 'DEFAULT' = 'DEFAULT'
				THEN cf_menu.cf_menu_seq
			ELSE COALESCE(b.cf_menu_seq, cf_menu.cf_menu_seq)
			END
		)
	,cf_menu.program_category
	,cf_menu.object_type
	,cf_menu.custom_flag
	,cf_menu.external_program
FROM cf_menu
INNER JOIN cf_user_access ON cf_user_access.menuid = cf_menu.rowid
LEFT OUTER JOIN cf_menu b ON cf_menu.rowid = b.menuid
	AND 'DEFAULT' = b.language_cd
WHERE cf_user_access.exe_flag = 1
	AND cf_user_access.site_cd = 'QMS'
	AND cf_user_access.empl_id = 'jhrsc2'
