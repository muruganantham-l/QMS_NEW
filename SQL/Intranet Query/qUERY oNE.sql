
----SELECT  
---- --SPID       = er.session_id
---- --   ,BlkBy          = er.blocking_session_id
---- --   ,DBName         = DB_Name(er.database_id)
---- --   ,CommandType    = er.command
---- --   ,ObjectName     = OBJECT_NAME(st.objectid)
---- --   ,CPUTime        = er.cpu_time
---- --   ,StartTime      = er.start_time
---- --   ,TimeElapsed    = CAST(GETDATE() - er.start_time AS TIME)
---- --   ,
----	SQLStatement   = st.text
----FROM sys.dm_exec_requests er
----CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = CEILING(CAST(DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_exc_date IS NOT NULL
						THEN wko_det.wko_det_exc_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(12, 5)) / 60 / 24) - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'4' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'PS')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'4' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'1' AS 'Response KPI'
	,'3' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'CR')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'5' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type = 'PS')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'5' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type = 'BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'1' AS 'Response KPI'
	,'5' AS 'Repair KPI'
	,'Current ' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob = 'KD')
	AND (ast_mst.ast_mst_asset_type = 'CR')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND Month(wkr_mst.wkr_mst_org_date) = '1'
	AND Year(wkr_mst.wkr_mst_org_date) = '2016'
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = CASE 
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_exc_date IS NOT NULL
						THEN wko_det.wko_det_exc_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) / 1440 - (
				2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
						WHEN wko_det.wko_det_exc_date IS NOT NULL
							THEN wko_det.wko_det_exc_date
						ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						END)
				) < 3
			THEN 0
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))) / 1440 - (2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0)))) > 2
			THEN 0
		END
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, CONVERT(DATETIME, convert(CHAR(8), '20160101')), CASE 
					WHEN wko_det.wko_det_cmpl_date IS NOT NULL
						AND wko_det.wko_det_cmpl_date < CONVERT(DATETIME, convert(CHAR(8), '20160130'))
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, CONVERT(DATETIME, convert(CHAR(8), '20160101'))) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'4' AS 'Repair KPI'
	,'Previous' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'BA')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (wkr_mst.wkr_mst_org_date < '20160101')
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')
	AND (
		(
			wko_mst.wko_mst_status NOT IN (
				'CLO'
				,'CMP'
				)
			)
		OR (
			wko_det.wko_det_cmpl_date > '20160101'
			AND wko_det.wko_det_cmpl_date < '20160130'
			)
		OR (wko_det.wko_det_cmpl_date > '20160130')
		)

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = CASE 
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_exc_date IS NOT NULL
						THEN wko_det.wko_det_exc_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) / 1440 - (
				2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
						WHEN wko_det.wko_det_exc_date IS NOT NULL
							THEN wko_det.wko_det_exc_date
						ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						END)
				) < 3
			THEN 0
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))) / 1440 - (2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0)))) > 2
			THEN 0
		END
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, CONVERT(DATETIME, convert(CHAR(8), '20160101')), CASE 
					WHEN wko_det.wko_det_cmpl_date IS NOT NULL
						AND wko_det.wko_det_cmpl_date < CONVERT(DATETIME, convert(CHAR(8), '20160130'))
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, CONVERT(DATETIME, convert(CHAR(8), '20160101'))) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.wko_mst_work_area AS Circle
	,wko_det.wko_det_varchar2 AS Clinic_Category
	,wko_det.wko_det_varchar4 AS Zone
	,CASE 
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN '#EKK'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN '#EKP'
		WHEN cus_mst.cus_mst_smallbu = '1'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN '#EK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_fob = 'KD'
			THEN 'KD'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'KESIHATAN'
			THEN 'KK'
		WHEN cus_mst.cus_mst_smallbu = '0'
			AND cus_mst.cus_mst_shipvia = 'PERGIGIAN'
			THEN 'KP'
		END AS Cli_Typ
	,wko_mst.wko_mst_wo_no
	,wko_mst.wko_mst_org_date
	,wko_det.wko_det_exc_date AS Response_Date
	,wko_det.wko_det_sched_date AS Acknowledge_date
	,wko_det.wko_det_corr_action
	,wko_det.wko_det_cmpl_date
	,wko_mst.wko_mst_status
	,wko_det_assign_to
	,'2' AS 'Response KPI'
	,'4' AS 'Repair KPI'
	,'Previous' AS 'Period_Status'
FROM wkr_mst
	,wkr_det
	,wko_mst
	,wko_det
	,ast_mst
	,ast_det
	,cus_mst
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
	AND (wkr_mst.RowID = wkr_det.mst_RowID)
	AND (wko_mst.site_cd = wko_det.site_cd)
	AND (wko_mst.RowID = wko_det.mst_RowID)
	AND (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
	AND (cus_mst.cus_mst_smallbu = '0')
	AND (cus_mst.cus_mst_fob <> 'KD')
	AND (ast_mst.ast_mst_asset_type = 'PS')
	AND (wkr_mst.wkr_mst_wr_status <> 'D')
	AND (wkr_mst.wkr_mst_org_date < '20160101')
	AND (ast_mst.ast_mst_ast_lvl LIKE 'SARAWAK%')
	AND (ast_mst.ast_mst_asset_locn LIKE 'BETONG%')
	AND (ast_mst.ast_mst_asset_code LIKE 'PERGIGIAN%')
	AND (ast_mst.site_cd = 'QMS')
	AND (ast_det.ast_det_varchar15 = 'EXISTING')
	AND (
		(
			wko_mst.wko_mst_status NOT IN (
				'CLO'
				,'CMP'
				)
			)
		OR (
			wko_det.wko_det_cmpl_date > '20160101'
			AND wko_det.wko_det_cmpl_date < '20160130'
			)
		OR (wko_det.wko_det_cmpl_date > '20160130')
		)

UNION ALL

SELECT Difference = COALESCE(DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date), 0)
	,CONVERT(DATETIME, convert(CHAR(8), '20160101')) AS reportmonth
	,CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, ast_det.ast_det_purchase_date, getdate()) AS DECIMAL(12, 5)) / 365, 16)) AS DiffDatebyBE
	,DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)
	,DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE getdate()
			END)
	,Response_Actual_KPI = CASE 
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_exc_date IS NOT NULL
						THEN wko_det.wko_det_exc_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) / 1440 - (
				2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
						WHEN wko_det.wko_det_exc_date IS NOT NULL
							THEN wko_det.wko_det_exc_date
						ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						END)
				) < 3
			THEN 0
		WHEN DATEDIFF(MI, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))) / 1440 - (2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0)))) > 2
			THEN 0
		END
	,Repair_Actual_KPI = CEILING(CAST(DateDiff(minute, CONVERT(DATETIME, convert(CHAR(8), '20160101')), CASE 
					WHEN wko_det.wko_det_cmpl_date IS NOT NULL
						AND wko_det.wko_det_cmpl_date < CONVERT(DATETIME, convert(CHAR(8), '20160130'))
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, CONVERT(DATETIME, convert(CHAR(8), '20160101'))) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Repair_Actual_KPI_curr = CEILING(CAST(DateDiff(minute, wkr_mst.wkr_mst_org_date, CASE 
					WHEN wko_det.wko_det_cmpl_date < DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
						AND wko_det_cmpl_date IS NOT NULL
						THEN wko_det.wko_det_cmpl_date
					ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
					END) AS DECIMAL(10, 5)) / 60 / 24)
	,Response_Day = DATEDIFF(MI, wkr_mst.wkr_mst_org_date, CASE 
			WHEN wko_det.wko_det_exc_date IS NOT NULL
				THEN wko_det.wko_det_exc_date
			ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
			END) / 1440 - (
		2 * DATEDIFF(wk, wkr_mst.wkr_mst_org_date, CASE 
				WHEN wko_det.wko_det_exc_date IS NOT NULL
					THEN wko_det.wko_det_exc_date
				ELSE DATEADD(s, - 1, DATEADD(mm, DATEDIFF(m, 0, wkr_mst.wkr_mst_org_date) + 1, 0))
				END)
		)
	,wkr_mst.wkr_mst_wr_no
	,wkr_mst.wkr_mst_org_date
	,wkr_mst.wkr_mst_originator
	,ast_mst.ast_mst_asset_no
	,ast_mst.ast_mst_asset_longdesc AS BE_Category
	,ast_det.ast_det_mfg_cd
	,ast_det.ast_det_modelno
	,ast_det.ast_det_asset_cost
	,be_group = CASE 
		WHEN ast_mst_asset_type = 'BA'
			THEN 'Basic'
		WHEN ast_mst_asset_type = 'CR'
			THEN 'Critical'
		WHEN ast_mst_asset_type = 'PS'
			THEN 'Patient Support'
		END
	,ast_mst.ast_mst_asset_status
	,wko_mst.wko_mst_descs
	,wko_det.wko_det_customer_cd AS Clinic_Code
	,wko_det.wko_det_note1 AS Clinic_Name
	,wko_det.wko_det_varchar1 AS Clinic_Type
	,wko_mst.wko_mst_asset_level AS STATE
	,wko_mst.wko_mst_asset_location AS District
	,wko_mst.
