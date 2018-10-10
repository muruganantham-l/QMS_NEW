ALTER proc select_ast_master_ssis
as
begin
set nocount ON




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
,FORMAT( ast_det_datetime10	,'dd/MM/yyyy hh:mm:ss')		 										 'DLP Expiry Date'
,FORMAT(ast_det_datetime5			,'dd/MM/yyyy hh:mm:ss') 										 'PO Date'
,FORMAT(ast_det_datetime6			,'dd/MM/yyyy hh:mm:ss') 										 'T&C Date'
,FORMAT(ast_det_datetime7			,'dd/MM/yyyy hh:mm:ss') 										 'Acceptance Date'
,FORMAT(ast_det_datetime2			,'dd/MM/yyyy hh:mm:ss') 										 'Warranty End'
,FORMAT(ast_det_datetime3			,'dd/MM/yyyy hh:mm:ss') 										 'Rental Start'
,FORMAT(ast_det_warranty_date		,'dd/MM/yyyy hh:mm:ss') 									 'Warranty Expiry'
,FORMAT(ast_det_datetime1			,'dd/MM/yyyy hh:mm:ss') 									 'Warranty Start'
,ast_mst_wrk_grp			 									 'Work Group'
,ast_mst_create_by			 									 'Created By'
,FORMAT(ast_mst_create_date		,'dd/MM/yyyy hh:mm:ss')	 										 'Created Date'
,FORMAT(ast_det_purchase_date		,'dd/MM/yyyy hh:mm:ss')	 										  'Purchase Date'
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
,format(ast_det_datetime4	,'dd/MM/yyyy hh:mm:ss')		 														'Rental End'
from ast_mst (nolock),
ast_det (Nolock)
where ast_mst.rowid = mst_rowid 
--and ast_mst_ast_lvl = 'Pulau Pinang'
--and ast_det_varchar15 in ('New Biomedical')
--and ast_mst_perm_id  ='EAST MALAYSIA'
--and ast_det_varchar15 in ('Accessories')
and ast_mst_asset_status in ('ACT','PBR','BER')
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


order by ast_mst_asset_no




set nocount off

end
 

