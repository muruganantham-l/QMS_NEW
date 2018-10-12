				Declare @mst_rowid int
				
				Select @mst_rowid  = Rowid
				from wko_mst(nolock)
				where  wko_mst_wo_no = 'CWO164778'
				AND site_cd ='QMS' 

				UPDATE wko_mst 
				SET wko_mst_status = 'OPE', audit_user = 'Tomms', audit_date = getdate() 
				WHERE RowID = @mst_rowid 
				and wko_mst_status = 'CMP'

				UPDATE wko_det with (updlock)
				SET  wko_det_cmpl_date = NULL,wko_det_corr_action = NULL, audit_user = 'Tomms', audit_date = getdate() 
				WHERE site_cd ='QMS' 
				and mst_RowID = @mst_rowid  

				update wko_sts with (updlock)
				SET wko_sts_end_date = NULL , wko_sts_duration = NULL , audit_user ='Tomms' , audit_date =getdate() 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO164778' 
				AND wko_sts_status = 'OPE' 
				--and wko_sts_end_date IS NULL 
				
				Delete from wko_sts
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO164778' 
				AND wko_sts_status = 'CMP' 

				--2017-12-15 08:55:34.040

				Select @mst_rowid  = Rowid
				from wko_mst(nolock)
				where  wko_mst_wo_no = 'CWO165625'
				AND site_cd ='QMS' 

				UPDATE wko_mst 
				SET wko_mst_status = 'OPE', audit_user = 'Tomms', audit_date = getdate() 
				WHERE RowID = @mst_rowid 
				and wko_mst_status = 'CMP'

				UPDATE wko_det with (updlock)
				SET  wko_det_cmpl_date = NULL,wko_det_corr_action = NULL, audit_user = 'Tomms', audit_date = getdate()
				WHERE site_cd ='QMS' 
				and mst_RowID = @mst_rowid  

				update wko_sts with (updlock)
				SET wko_sts_end_date = NULL , wko_sts_duration =NULL , audit_user ='Tomms' , audit_date =getdate() 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO165625' 
				AND wko_sts_status = 'OPE' 
				--and wko_sts_end_date IS NULL 
				
				Delete from  wko_sts
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO165625' 
				AND wko_sts_status = 'CMP' 

				--2017-12-12 13:48:40.470

				Select @mst_rowid  = Rowid
				from wko_mst(nolock)
				where  wko_mst_wo_no = 'CWO166146'
				AND site_cd ='QMS' 

				UPDATE wko_mst 
				SET wko_mst_status = 'OPE', audit_user = 'Tomms', audit_date = getdate() 
				WHERE RowID = @mst_rowid 
				and wko_mst_status = 'CMP'

				UPDATE wko_det with (updlock)
				SET  wko_det_cmpl_date = NULL,wko_det_corr_action = NULL, audit_user = 'Tomms', audit_date = getdate()
				WHERE site_cd ='QMS' 
				and mst_RowID = @mst_rowid  

				update wko_sts with (updlock)
				SET wko_sts_end_date = NULL , wko_sts_duration =NULL , audit_user ='Tomms' , audit_date =getdate() 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO166146' 
				AND wko_sts_status = 'OPE' 
				--and wko_sts_end_date IS NULL 
				
				Delete from  wko_sts 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no ='CWO166146' 
				AND wko_sts_status = 'CMP' 

				--2017-12-15 17:51:08.337

