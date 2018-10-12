select 
ast_det_cus_code 'Clinic/Item Code',
ast_det_note1 'Clinic Name',
ast_det_varchar23  'District/Customer code',
ast_mst_asset_no 'BE Number',
ast_mst_asset_shortdesc 'Asset Desc',
ast_mst_cost_center 'CAMMS COST CENTER',
ast_det_asset_cost 'Purchase Cost',
ast_det_numeric9 'Monthly Rental',
ast_det_numeric8 'Maintenance Revenue',
ast_det_varchar22 'Ownership',
case 
	when ast_mst_asset_status in ('ACT','PBR')
		then 'Active' 
	when ast_mst_asset_status in ('DEA')
		then 'Inactive'
	else ast_mst_asset_status
end as 'Status'
from
ast_mst (nolock),
ast_det (nolock)
where ast_mst.rowid   = ast_det.mst_rowid
and ast_det_varchar22 in ('NEW-BE','PUR-EX','EXISTING')
and ast_det_varchar15 in ('Existing','New Biomedical','Purchase Biomedical')
and ast_mst_asset_status in ('ACT','PBR')
and ast_mst_safety_rqmts in ('V1 : Existing Equipment CA1 17-04-2014','V2 : Additional Equipment SA1 22-12-2015','V4 : New Biomedical','V5 : Purchase Biomedical') 


and ast_det_varchar21 in ('batch 1','batch 2','batch 3','na')

--select distinct ast_det_varchar21 from ast_det where ast_det_varchar21 in ('batch 1','batch 2','batch 3')