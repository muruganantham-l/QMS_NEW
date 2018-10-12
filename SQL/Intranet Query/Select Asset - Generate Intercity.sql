Select 
ROW_NUMBER() Over (order by ast_det_varchar15,ast_mst_asset_longdesc,ast_mst_ast_lvl,ast_mst_asset_locn,ast_mst_asset_code) 'SI No',	
ast_mst_asset_no 'BE Number'	,
Replace(replace(ast_mst_asset_longdesc,char(10),''),char(13),'') 'Be Category'	,
ast_det_cus_code 'Clinic Code',
Replace(replace(ast_det_note1,char(10),''),char(13),'') 'Clinic Name',
Replace(replace(ast_det_note2,char(10),''),char(13),'') 'Clinic Address',
ast_mst_asset_code 'Clinic Category',	
ast_mst_ast_lvl 'State',
ast_mst_asset_locn 'District',
ast_det_asset_cost 'Purchase Cost',
ast_det_numeric8 'Maintenance Revenue / Month',
ast_det_varchar15 'Ownership'
from ast_mst (nolock) , 
ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID
and ast_mst_asset_status in ('ACT','PBR')
and ast_det_varchar15 in ('Existing','New Biomedical','Purchase Biomedical')
and ast_det_varchar22 in ('Existing','NEW-BE','PUR-EX')
order by ast_det_varchar15,ast_mst_asset_longdesc,ast_mst_ast_lvl,ast_mst_asset_locn,ast_mst_asset_code

