exec sp_executesql N'SELECT  		Difference = COALESCE ( DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date),
				DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)),
				DateDiff(Month, wko_mst.wko_mst_org_date, CASE WHEN wko_det.wko_det_cmpl_date IS NOT NULL THEN wko_det.wko_det_cmpl_date  ELSE getdate() END) as MonthDiff,
				COALESCE(CEILING(ast_det_asset_cost/5000) * 10,0) as pencost,
				ast_mst.ast_mst_asset_no,
				ast_mst.ast_mst_asset_longdesc AS BE_Category,
				ast_det.ast_det_mfg_cd,
				ast_det.ast_det_modelno,
				be_group = CASE WHEN ast_mst_asset_type = ''BA'' THEN ''Basic''
					WHEN ast_mst_asset_type = ''CR'' THEN ''Critical''
					WHEN ast_mst_asset_type = ''PS'' THEN ''Patient Support'' END,
				ast_mst.ast_mst_asset_status,
				wko_mst.wko_mst_descs,
				wko_det.wko_det_customer_cd As Clinic_Code,
				wko_det.wko_det_note1 AS Clinic_Name,
				wko_det.wko_det_varchar1 AS Clinic_Type,
				wko_mst.wko_mst_asset_level AS State,
				wko_mst.wko_mst_asset_location AS District,
				wko_mst.wko_mst_work_area AS Circle,
				wko_det.wko_det_varchar2 AS Clinic_Category,
				wko_det.wko_det_varchar4 AS Zone,
				CASE WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_shipvia = ''KESIHATAN'' THEN ''#EKK''
					WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_shipvia = ''PERGIGIAN'' THEN ''#EKP''
					WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_fob = ''KD'' THEN ''#EKD'' 
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_fob = ''KD'' THEN ''KD'' 
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_shipvia = ''KESIHATAN'' THEN ''KK''
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_shipvia = ''PERGIGIAN'' THEN ''KP'' END AS Cli_Typ,
				wko_mst.wko_mst_wo_no,
				wko_mst.wko_mst_org_date,
				wko_det.wko_det_cmpl_date AS Response_Date,
				wko_det.wko_det_sched_date AS Acknowledge_date,
				wko_det.wko_det_corr_action,
				wko_det.wko_det_cmpl_date,
				wko_mst.wko_mst_status,
				wko_det_assign_to,
				ast_det_purchase_date,
				ast_det_asset_cost,
				wko_mst_due_date,
				wko_det_work_class,
				''Current'' as ''Period_Status''
FROM 		wko_mst,
				wko_det,
				ast_mst,
				ast_det,
				wrk_sts,
				cus_mst
WHERE 		( wko_mst.site_cd = wko_det.site_cd )
AND	 		( wko_mst.RowID = wko_det.mst_RowID )
AND			( wko_mst.site_cd = wrk_sts.site_cd )
AND			( ast_mst.site_cd = ast_det.site_cd )
AND			( ast_mst.RowID = ast_det.mst_RowID )
AND			( ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd )
AND			( ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
AND 			( wko_mst.wko_mst_status = wrk_sts.wrk_sts_status )
AND			(wko_mst.wko_mst_wo_no like ''PWO%'')

AND 			( wko_mst.wko_mst_status NOT IN (''BER'', ''ABE'') )
AND 			( wko_det.wko_det_cmpl_date IS NULL  )
AND			( Month (wko_mst.wko_mst_org_date) = @P1)
AND			( Year (wko_mst.wko_mst_org_date) = @P2)
AND 			( ast_mst.ast_mst_ast_lvl LIKE @P3 )
AND 			( ast_mst.ast_mst_asset_locn LIKE @P4 )
AND 			( ast_mst.ast_mst_asset_code LIKE @P5 )
AND			( ast_mst.site_cd = @P6)
AND			( wko_det.wko_det_customer_cd LIKE @P7 )




UNION ALL

SELECT  		Difference = COALESCE ( DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_cmpl_date),
				DateDiff(minute, wko_mst.wko_mst_org_date, wko_det.wko_det_clo_date)),
				DateDiff(Month, wko_mst.wko_mst_org_date, CASE WHEN wko_det.wko_det_cmpl_date IS NOT NULL THEN wko_det.wko_det_cmpl_date  ELSE getdate() END) as MonthDiff,
				CEILING(ast_det_asset_cost/5000) * 10 as pencost,
				ast_mst.ast_mst_asset_no,
				ast_mst.ast_mst_asset_longdesc AS BE_Category,
				ast_det.ast_det_mfg_cd,
				ast_det.ast_det_modelno,
				be_group = CASE WHEN ast_mst_asset_type = ''BA'' THEN ''Basic''
					WHEN ast_mst_asset_type = ''CR'' THEN ''Critical''
					WHEN ast_mst_asset_type = ''PS'' THEN ''Patient Support'' END,
				ast_mst.ast_mst_asset_status,
				wko_mst.wko_mst_descs,
				wko_det.wko_det_customer_cd As Clinic_Code,
				wko_det.wko_det_note1 AS Clinic_Name,
				wko_det.wko_det_varchar1 AS Clinic_Type,
				wko_mst.wko_mst_asset_level AS State,
				wko_mst.wko_mst_asset_location AS District,
				wko_mst.wko_mst_work_area AS Circle,
				wko_det.wko_det_varchar2 AS Clinic_Category,
				wko_det.wko_det_varchar4 AS Zone,
				CASE WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_shipvia = ''KESIHATAN'' THEN ''#EKK''
					WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_shipvia = ''PERGIGIAN'' THEN ''#EKP''
					WHEN cus_mst.cus_mst_smallbu = ''1'' AND cus_mst.cus_mst_fob = ''KD'' THEN ''#EKD'' 
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_fob = ''KD'' THEN ''KD'' 
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_shipvia = ''KESIHATAN'' THEN ''KK''
					WHEN cus_mst.cus_mst_smallbu = ''0'' AND cus_mst.cus_mst_shipvia = ''PERGIGIAN'' THEN ''KP'' END AS Cli_Typ,
				wko_mst.wko_mst_wo_no,
				wko_mst.wko_mst_org_date,
				wko_det.wko_det_cmpl_date AS Response_Date,
				wko_det.wko_det_sched_date AS Acknowledge_date,
				wko_det.wko_det_corr_action,
				wko_det.wko_det_cmpl_date,
				wko_mst.wko_mst_status,
				wko_det_assign_to,
				ast_det_purchase_date,
				ast_det_asset_cost,
				wko_mst_due_date,
				wko_det_work_class,
				''Previous'' as ''Period_Status''
FROM 		wko_mst,
				wko_det,
				ast_mst,
				ast_det,
				wrk_sts,
				cus_mst
WHERE 		( wko_mst.site_cd = wko_det.site_cd )
AND	 		( wko_mst.RowID = wko_det.mst_RowID )
AND			( wko_mst.site_cd = wrk_sts.site_cd )
AND			( ast_mst.site_cd = ast_det.site_cd )
AND			( ast_mst.RowID = ast_det.mst_RowID )
AND			( ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd )
AND			( ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
AND 			( wko_mst.wko_mst_status = wrk_sts.wrk_sts_status )
AND			(wko_mst.wko_mst_wo_no like ''PWO%'')

AND 			( wko_mst.wko_mst_status NOT IN (''BER'', ''ABE'', ''CLO'',''CMP''))
AND 			( wko_det.wko_det_cmpl_date IS NULL  )
AND			( Month (wko_mst.wko_mst_org_date) < @P8)
AND			( Year (wko_mst.wko_mst_org_date) <= @P9)
AND 			( ast_mst.ast_mst_ast_lvl LIKE @P10 )
AND 			( ast_mst.ast_mst_asset_locn LIKE @P11 )
AND 			( ast_mst.ast_mst_asset_code LIKE @P12 )
AND			( ast_mst.site_cd = @P13)
AND			( wko_det.wko_det_customer_cd LIKE @P14 )

',N'@P1 float,@P2 float,@P3 nvarchar(50),@P4 nvarchar(50),@P5 nvarchar(30),@P6 nvarchar(4),@P7 nvarchar(11),@P8 float,@P9 float,@P10 nvarchar(50),@P11 nvarchar(50),@P12 nvarchar(30),@P13 nvarchar(4),@P14 nvarchar(11)',2,2017,N'SARAWAK%',N'%',N'%',N'QMS',N'%',2,2017,N'SARAWAK%',N'%',N'%',N'QMS',N'%'