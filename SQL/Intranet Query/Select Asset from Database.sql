select
ast_det_cus_code       'Clinic Code'
,replace(replace(replace(ast_det_note1,char(10),''),char(13),''),char(9),'')       'Clinic Name'
,ast_mst_asset_no    'BE Number'
,ast_mst_cost_center 'Cost Center'
,ast_det_asset_cost 'Purchase Cost'
,ast_det_numeric9   'Rental Per Month'
,ast_det_numeric1   'Maintenance Rev Year'
,ast_det_varchar22  'Ramco Flag'
,ast_mst_asset_status      'BE Conditional Status'
,ast_mst_asset_longdesc    'BE Category'
,ast_det_varchar15    'Ownership'
,ast_det_varchar21	'Batch Number'
from ast_mst (nolock),
ast_det (Nolock)
where ast_mst.rowid = mst_rowid 
--and ast_mst_ast_lvl = 'JOHOR'
and ast_det_varchar15 in ('Purchase Biomedical')
--and ast_mst_perm_id  ='EAST MALAYSIA'
--and ast_det_varchar15 in ('Accessories')
and ast_mst_asset_status in ('ACT')
--and ast_mst_work_area = 'SC1'
--and ast_det_varchar13 is NULL
--and ast_mst_asset_grpcode  in  ('16-509N') 
--and ast_det_varchar21 in ('Batch 7')
and ast_det_varchar21 in ('Batch 1','Batch 2','Batch 3','Batch 4','Batch 5','Batch 6','Batch 7')
--and ast_mst_asset_grpcode not in ('11-285N')
--and ast_mst_asset_grpcode in ('DE-032','10-792')
--and ast_mst_asset_longdesc in ('CHAIRS, EXAMINATION/TREATMENT, DENTISTRY','Chairs, Examination/Treatment, Dentistry, Specialist')
--and ast_mst_create_by <> 'Patch'
order by ast_mst_asset_no


