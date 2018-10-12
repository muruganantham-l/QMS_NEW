select ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	--and ast_det_varchar21 = 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl in ( 'PERAK','WILAYAH PERSEKUTUAN LABUAN' ,'SABAH','SARAWAK','PULAU PINANG KOLEJ','PULAU PINANG')
group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15
union 
select ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership',count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	--and ast_det_varchar21 = 'Batch 3'
	AND ast_det_varchar15	=	'Purchase Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl in ( 'PERAK','WILAYAH PERSEKUTUAN LABUAN' ,'SABAH','SARAWAK','PULAU PINANG KOLEJ','PULAU PINANG')
group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15

--select distinct ast_mst_ast_lvl from ast_mst

select ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21 = 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl not in ( 'PERAK','WILAYAH PERSEKUTUAN LABUAN' ,'SABAH','SARAWAK','PULAU PINANG KOLEJ','PULAU PINANG')
group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15
union 
select ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership',count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	and ast_det_varchar21 = 'Batch 3'
	AND ast_det_varchar15	=	'Purchase Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl not in ( 'PERAK','WILAYAH PERSEKUTUAN LABUAN' ,'SABAH','SARAWAK','PULAU PINANG KOLEJ','PULAU PINANG')
group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15

--select distinct ast_mst_ast_lvl from ast_mst
	
	select  ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'Purchase Amount' ,SUm(ast_det_numeric9) 'RENTAL'
	from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 2'
	AND ast_det_varchar15	=	'New Biomedical'
	--and ast_mst_asset_grpcode = 'DE-036N'
	and ast_det_varchar16 like '%AR Denta%'
	group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15

	union all

	select ast_det_varchar21 'Batch Number',ast_mst_asset_code 'KK/KP' ,ast_mst_ast_lvl 'State name',ast_mst_asset_locn 'District',ast_det_varchar15 'Ownership',count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'Purchase Amount' , SUm(ast_det_asset_cost) 'RENTAL'
	from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 2'
	AND ast_det_varchar15	=	'Purchase Biomedical'
	--and ast_mst_asset_grpcode = 'DE-036N'
	and ast_det_varchar16 like '%AR Denta%'
	group by ast_det_varchar21 , ast_mst_asset_code , ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15
