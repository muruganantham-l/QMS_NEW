select  
 ast_mst_asset_no			 									'BE Number'
,ast_mst_asset_type			 									'BE Group'
,ast_mst_asset_grpcode		 									'BE Code'
,ast_mst_asset_code			 										'Clinic Category'
,ast_mst_assigned_to		 										 'Assigned To'
,ast_mst_asset_shortdesc	 										 'BE General Name'
,ast_mst_asset_longdesc		 											   'BE Category'
,ast_mst_perm_id			 										'Zone'
,ast_mst_cost_center		 									 'Cost Center'
,ast_det_cus_code			 									 'Clinic Code'
,ast_mst_asset_locn			 									'District'
,ast_mst_safety_rqmts		 										 'Variation Order'
,ast_mst_work_area			 									'Circle'
,ast_mst_cri_factor			 										 'BE Critical Factor'
,ast_det_datetime8			 										 'Installation Date'
,ast_det_datetime9			 										 'CPC Date'
,convert(varchar(30),ast_det_datetime10	,103)		 										 'DLP Expiry Date'
,convert(varchar(30),ast_det_datetime5			,103) 										 'PO Date'
,convert(varchar(30),ast_det_datetime6			,103) 										 'T&C Date'
,convert(varchar(30),ast_det_datetime7			,103) 										 'Acceptance Date'
,convert(varchar(30),ast_det_warranty_date		,103) 										 'Warranty End'
,convert(varchar(30),ast_det_datetime3			,103) 										 'Rental Start'
,convert(varchar(30),ast_det_warranty_date		,103) 									 'Warranty Expiry'
,convert(varchar(30),ast_det_datetime1			,103) 									 'Warranty Start'
,ast_mst_wrk_grp			 									 'Work Group'
,ast_mst_create_by			 									 'Created By'
,convert(varchar(30),ast_mst_create_date		,103)	 										 'Created Date'
,convert(varchar(30),ast_det_purchase_date		,103)	 										  'Purchase Date'
,ast_det_numeric2			 										 'Main.Rate(%)'
,ast_det_varchar1			 										 'Clinic Type'
,ast_mst_asset_status		 								'BE Conditional Status'
,ast_mst_ast_lvl			 								  'State'
,ast_mst_parent_flag		 										'Parent Flag'
,ast_det_numeric8			 							'Monthly Rev.'
,ast_det_numeric9			 							'Rental Per Month'
,ast_det_numeric1			 							'Maintenance Rev Year'
,ast_det_note3				 						'UDF Note3'
,ast_det_varchar30			 							'UDF Text30'
,ast_det_note1				 			'Clinic Name'
,ast_det_note2				 			   'Clinic Address'
,ast_det_varchar21			 										 'Batch Number'
,ast_det_varchar22			 										 'Ramco Flag'
,ast_det_varchar18			 										 'Software Rev No'
,ast_det_varchar19			 										'BE Location'-- 'Meter Reading'
,ast_det_varchar20			 										 'Purchase Order No'
,ast_det_varchar15			 										 'Ownership'
,ast_det_asset_cost			 										 'Purchase Cost'
,ast_det_mfg_cd				 												'Manufacturer'
,ast_det_modelno			 												 'Model Number'
,ast_det_varchar2			 													 'Serial Number'
,ast_det_varchar16			 							 'Supplier Name'
,ast_det_varchar17			 														'Supplier Contact No 1'
,ast_det_varchar12			 														'BE Classification'
,ast_det_varchar13			 														'KEW PA Reg No'
,ast_det_varchar14			 														'SPA Reg No'
,ast_det_varchar9			 														'Region'
,ast_det_varchar10			 														'SM Type'
,ast_det_varchar11			 														'PPM Freq'
,ast_det_varchar6			 														'Clinic Contact No 1'
,ast_det_varchar7			 														'Clinic Contact No 2'
,ast_det_varchar8			 														'Clinic Fax No'
,ast_det_varchar5			 														'DRN Number'
,ast_det_taxable			 														'Taxable'
,ast_det_l_account			 														'Labor Account'
,ast_det_m_account			 														'Material Account'
,ast_mst_print_count		 														 'Barcode Print Count'
,ast_det_datetime4			 														'Rental End'
,ast_det_varchar29 'RAMCO Inv PBE'
from ast_mst (nolock),
ast_det (Nolock)
where ast_mst.rowid = mst_rowid 
--and ast_mst_ast_lvl = 'Pulau Pinang'
--and ast_det_varchar15 in ('New Biomedical')
--and ast_mst_perm_id  ='EAST MALAYSIA'
--and ast_det_varchar15 in ('Accessories')
--and ast_mst_asset_status in ('ACT','PBR')
--and ast_mst_work_area = 'SC1'
--and ast_det_varchar13 is NULL
--and ast_mst_asset_grpcode  in  ('16-509N') 
--and ast_det_varchar21 in ('Batch 7')
--and ast_det_varchar21 in ('Batch 1','Batch 2','Batch 3','Batch 4','Batch 5','Batch 6','Batch 7')
--and ast_mst_asset_grpcode not in ('11-285N')
--and ast_mst_asset_grpcode in ('DE-032','10-792')
--and ast_mst_asset_longdesc in ('CHAIRS, EXAMINATION/TREATMENT, DENTISTRY','Chairs, Examination/Treatment, Dentistry, Specialist')
--and ast_mst_create_by <> 'Patch'
--and ast_det_varchar15 = 'existing'
and  ast_mst.ast_mst_asset_no in (
 
  select m.ast_mst_asset_no from
 ast_det d join ast_mst m on m.RowID = d.mst_RowID 
--join batch6 b on b.be_number = m.ast_mst_asset_no
 where ast_det_varchar21 = 'Batch 8' and ast_det_varchar15 in ('purchase Biomedical') --0
 --and ast_det_varchar29 is null
 EXCEPT
 SELECT be_number from batch8
 )

order by ast_mst_asset_no


--update ast_det set ast_det_varchar29 = null where ast_det_varchar29 = '3a9aac07-4a78-4eb7-8a16-200e6a38ae47'

--116377
 /*

 update ast_mst
set 
site_cd=					replace(replace(replace(		site_cd										,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_no=			replace(replace(replace(	ast_mst_asset_no								,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_type=		replace(replace(replace(		ast_mst_asset_type							,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_grpcode=		replace(replace(replace(		ast_mst_asset_grpcode						,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_status=		replace(replace(replace(		ast_mst_asset_status						,char(13),''),char(10),''),char(9),'')
,ast_mst_work_area=			replace(replace(replace(		ast_mst_work_area							,char(13),''),char(10),''),char(9),'')
,ast_mst_cri_factor=		replace(replace(replace(			ast_mst_cri_factor						,char(13),''),char(10),''),char(9),'')
,ast_mst_cost_center=		replace(replace(replace(		ast_mst_cost_center							,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_locn=		replace(replace(replace(			ast_mst_asset_locn						,char(13),''),char(10),''),char(9),'')
,ast_mst_safety_rqmts=		replace(replace(replace(		ast_mst_safety_rqmts						,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_shortdesc=	replace(replace(replace(			ast_mst_asset_shortdesc					,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_longdesc=	replace(replace(replace(			ast_mst_asset_longdesc					,char(13),''),char(10),''),char(9),'')
,ast_mst_perm_id=			replace(replace(replace(		ast_mst_perm_id								,char(13),''),char(10),''),char(9),'')
,ast_mst_parent_id=			replace(replace(replace(		ast_mst_parent_id							,char(13),''),char(10),''),char(9),'')
,ast_mst_asset_code=		replace(replace(replace(			ast_mst_asset_code						,char(13),''),char(10),''),char(9),'')
,ast_mst_assigned_to=		replace(replace(replace(				ast_mst_assigned_to					,char(13),''),char(10),''),char(9),'')
,ast_mst_fda_code=			replace(replace(replace(				ast_mst_fda_code					,char(13),''),char(10),''),char(9),'')
,audit_user=				replace(replace(replace(			audit_user								,char(13),''),char(10),''),char(9),'')
,audit_date=				replace(replace(replace(			audit_date								,char(13),''),char(10),''),char(9),'')
,column1=					replace(replace(replace(				column1								,char(13),''),char(10),''),char(9),'')
,column2=					replace(replace(replace(				column2								,char(13),''),char(10),''),char(9),'')
,column3=					replace(replace(replace(				column3								,char(13),''),char(10),''),char(9),'')
,column4=					replace(replace(replace(				column4								,char(13),''),char(10),''),char(9),'')
,column5=					replace(replace(replace(				column5								,char(13),''),char(10),''),char(9),'')
--,RowID=						replace(replace(replace(					RowID							,char(13),''),char(10),''),char(9),'')
,ast_mst_parent_flag=		replace(replace(replace(					ast_mst_parent_flag				,char(13),''),char(10),''),char(9),'')
,ast_mst_auto_no=			replace(replace(replace(						ast_mst_auto_no				,char(13),''),char(10),''),char(9),'')
,ast_mst_create_by=			replace(replace(replace(							ast_mst_create_by		,char(13),''),char(10),''),char(9),'')
,ast_mst_create_date=		replace(replace(replace(					ast_mst_create_date				,char(13),''),char(10),''),char(9),'')
,ast_mst_wrk_grp=			replace(replace(replace(				ast_mst_wrk_grp						,char(13),''),char(10),''),char(9),'')
,ast_mst_print_count=		replace(replace(replace(							ast_mst_print_count		,char(13),''),char(10),''),char(9),'')
,ast_mst_ast_lvl=			replace(replace(replace(					ast_mst_ast_lvl					,char(13),''),char(10),''),char(9),'')



--select * into ast_mst_bak_2018_08_29 from ast_mst


--select* into  ast_det_bak_2018_08_29 from ast_det

update ast_det
set
site_cd	=     replace(replace(replace(site_cd      ,char(13),''),char(10),''),char(9),'')
,mst_RowID	=     replace(replace(replace(mst_RowID      ,char(13),''),char(10),''),char(9),'')
,ast_det_asset_cost	=     replace(replace(replace(ast_det_asset_cost      ,char(13),''),char(10),''),char(9),'')
,ast_det_mtdlabcost	=     replace(replace(replace(ast_det_mtdlabcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_mtdmtlcost	=     replace(replace(replace(ast_det_mtdmtlcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_mtdconcost	=     replace(replace(replace(ast_det_mtdconcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ytdlabcost	=     replace(replace(replace(ast_det_ytdlabcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ytdmtlcost	=     replace(replace(replace(ast_det_ytdmtlcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ytdconcost	=     replace(replace(replace(ast_det_ytdconcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ltdlabcost	=     replace(replace(replace(ast_det_ltdlabcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ltdmtlcost	=     replace(replace(replace(ast_det_ltdmtlcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ltdconcost	=     replace(replace(replace(ast_det_ltdconcost      ,char(13),''),char(10),''),char(9),'')
,ast_det_warranty_date	=     replace(replace(replace(ast_det_warranty_date      ,char(13),''),char(10),''),char(9),'')
,ast_det_depr_term	=     replace(replace(replace(ast_det_depr_term      ,char(13),''),char(10),''),char(9),'')
,ast_det_eqhr_level	=     replace(replace(replace(ast_det_eqhr_level      ,char(13),''),char(10),''),char(9),'')
,ast_det_repl_cost	=     replace(replace(replace(ast_det_repl_cost      ,char(13),''),char(10),''),char(9),'')
,ast_det_l_account	=     replace(replace(replace(ast_det_l_account      ,char(13),''),char(10),''),char(9),'')
,ast_det_m_account	=     replace(replace(replace(ast_det_m_account      ,char(13),''),char(10),''),char(9),'')
,ast_det_c_account	=     replace(replace(replace(ast_det_c_account      ,char(13),''),char(10),''),char(9),'')
,ast_det_taxable	=     replace(replace(replace(ast_det_taxable      ,char(13),''),char(10),''),char(9),'')
,ast_det_ent_date	=     replace(replace(replace(ast_det_ent_date      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar1	=     replace(replace(replace(ast_det_varchar1      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar2	=     replace(replace(replace(ast_det_varchar2      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar3	=     replace(replace(replace(ast_det_varchar3      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar4	=     replace(replace(replace(ast_det_varchar4      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar5	=     replace(replace(replace(ast_det_varchar5      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar6	=     replace(replace(replace(ast_det_varchar6      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar7	=     replace(replace(replace(ast_det_varchar7      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar8	=     replace(replace(replace(ast_det_varchar8      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar9	=     replace(replace(replace(ast_det_varchar9      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar10	=     replace(replace(replace(ast_det_varchar10      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar11	=     replace(replace(replace(ast_det_varchar11      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar12	=     replace(replace(replace(ast_det_varchar12      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar13	=     replace(replace(replace(ast_det_varchar13      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar14	=     replace(replace(replace(ast_det_varchar14      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar15	=     replace(replace(replace(ast_det_varchar15      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar16	=     replace(replace(replace(ast_det_varchar16      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar17	=     replace(replace(replace(ast_det_varchar17      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar18	=     replace(replace(replace(ast_det_varchar18      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar19	=     replace(replace(replace(ast_det_varchar19      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar20	=     replace(replace(replace(ast_det_varchar20      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar21	=     replace(replace(replace(ast_det_varchar21      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar22	=     replace(replace(replace(ast_det_varchar22      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar23	=     replace(replace(replace(ast_det_varchar23      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar24	=     replace(replace(replace(ast_det_varchar24      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar25	=     replace(replace(replace(ast_det_varchar25      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar26	=     replace(replace(replace(ast_det_varchar26      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar27	=     replace(replace(replace(ast_det_varchar27      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar28	=     replace(replace(replace(ast_det_varchar28      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar29	=     replace(replace(replace(ast_det_varchar29      ,char(13),''),char(10),''),char(9),'')
,ast_det_varchar30	=     replace(replace(replace(ast_det_varchar30      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric1	=     replace(replace(replace(ast_det_numeric1      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric2	=     replace(replace(replace(ast_det_numeric2      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric3	=     replace(replace(replace(ast_det_numeric3      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric4	=     replace(replace(replace(ast_det_numeric4      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric5	=     replace(replace(replace(ast_det_numeric5      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric6	=     replace(replace(replace(ast_det_numeric6      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric7	=     replace(replace(replace(ast_det_numeric7      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric8	=     replace(replace(replace(ast_det_numeric8      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric9	=     replace(replace(replace(ast_det_numeric9      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric10	=     replace(replace(replace(ast_det_numeric10      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric11	=     replace(replace(replace(ast_det_numeric11      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric12	=     replace(replace(replace(ast_det_numeric12      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric13	=     replace(replace(replace(ast_det_numeric13      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric14	=     replace(replace(replace(ast_det_numeric14      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric15	=     replace(replace(replace(ast_det_numeric15      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric16	=     replace(replace(replace(ast_det_numeric16      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric17	=     replace(replace(replace(ast_det_numeric17      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric18	=     replace(replace(replace(ast_det_numeric18      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric19	=     replace(replace(replace(ast_det_numeric19      ,char(13),''),char(10),''),char(9),'')
,ast_det_numeric20	=     replace(replace(replace(ast_det_numeric20      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime1	=     replace(replace(replace(ast_det_datetime1      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime2	=     replace(replace(replace(ast_det_datetime2      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime3	=     replace(replace(replace(ast_det_datetime3      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime4	=     replace(replace(replace(ast_det_datetime4      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime5	=     replace(replace(replace(ast_det_datetime5      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime6	=     replace(replace(replace(ast_det_datetime6      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime7	=     replace(replace(replace(ast_det_datetime7      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime8	=     replace(replace(replace(ast_det_datetime8      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime9	=     replace(replace(replace(ast_det_datetime9      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime10	=     replace(replace(replace(ast_det_datetime10      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime11	=     replace(replace(replace(ast_det_datetime11      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime12	=     replace(replace(replace(ast_det_datetime12      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime13	=     replace(replace(replace(ast_det_datetime13      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime14	=     replace(replace(replace(ast_det_datetime14      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime15	=     replace(replace(replace(ast_det_datetime15      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime16	=     replace(replace(replace(ast_det_datetime16      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime17	=     replace(replace(replace(ast_det_datetime17      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime18	=     replace(replace(replace(ast_det_datetime18      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime19	=     replace(replace(replace(ast_det_datetime19      ,char(13),''),char(10),''),char(9),'')
,ast_det_datetime20	=     replace(replace(replace(ast_det_datetime20      ,char(13),''),char(10),''),char(9),'')
,ast_det_note1	=     replace(replace(replace(ast_det_note1      ,char(13),''),char(10),''),char(9),'')
,ast_det_note2	=     replace(replace(replace(ast_det_note2      ,char(13),''),char(10),''),char(9),'')
,ast_det_note3	=     replace(replace(replace(ast_det_note3      ,char(13),''),char(10),''),char(9),'')
,audit_user	=     replace(replace(replace(audit_user      ,char(13),''),char(10),''),char(9),'')
,audit_date	=     replace(replace(replace(audit_date      ,char(13),''),char(10),''),char(9),'')
,column1	=     replace(replace(replace(column1      ,char(13),''),char(10),''),char(9),'')
,column2	=     replace(replace(replace(column2      ,char(13),''),char(10),''),char(9),'')
,column3	=     replace(replace(replace(column3      ,char(13),''),char(10),''),char(9),'')
,column4	=     replace(replace(replace(column4      ,char(13),''),char(10),''),char(9),'')
,column5	=     replace(replace(replace(column5      ,char(13),''),char(10),''),char(9),'')
--,RowID	=     replace(replace(replace(RowID      ,char(13),''),char(10),''),char(9),'')
,ast_det_purchase_date	=     replace(replace(replace(ast_det_purchase_date      ,char(13),''),char(10),''),char(9),'')
,ast_det_depr_date	=     replace(replace(replace(ast_det_depr_date      ,char(13),''),char(10),''),char(9),'')
,ast_det_acc_depr_cost	=     replace(replace(replace(ast_det_acc_depr_cost      ,char(13),''),char(10),''),char(9),'')
,ast_det_net_book_value	=     replace(replace(replace(ast_det_net_book_value      ,char(13),''),char(10),''),char(9),'')
,ast_det_depr_by	=     replace(replace(replace(ast_det_depr_by      ,char(13),''),char(10),''),char(9),'')
,ast_det_depr_method	=     replace(replace(replace(ast_det_depr_method      ,char(13),''),char(10),''),char(9),'')
,ast_det_dispose_date	=     replace(replace(replace(ast_det_dispose_date      ,char(13),''),char(10),''),char(9),'')
,ast_det_dispose_value	=     replace(replace(replace(ast_det_dispose_value      ,char(13),''),char(10),''),char(9),'')
,ast_det_dispose_type	=     replace(replace(replace(ast_det_dispose_type      ,char(13),''),char(10),''),char(9),'')
,ast_det_dispose_by	=     replace(replace(replace(ast_det_dispose_by      ,char(13),''),char(10),''),char(9),'')
,ast_det_cus_code	=     replace(replace(replace(ast_det_cus_code      ,char(13),''),char(10),''),char(9),'')
,ast_det_mtdmisccost	=     replace(replace(replace(ast_det_mtdmisccost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ytdmisccost	=     replace(replace(replace(ast_det_ytdmisccost      ,char(13),''),char(10),''),char(9),'')
,ast_det_ltdmisccost	=     replace(replace(replace(ast_det_ltdmisccost      ,char(13),''),char(10),''),char(9),'')
,ast_det_s_account	=     replace(replace(replace(ast_det_s_account      ,char(13),''),char(10),''),char(9),'')
,ast_det_mfg_cd	=     replace(replace(replace(ast_det_mfg_cd      ,char(13),''),char(10),''),char(9),'')
,ast_det_modelno	=     replace(replace(replace(ast_det_modelno      ,char(13),''),char(10),''),char(9),'')

 */
