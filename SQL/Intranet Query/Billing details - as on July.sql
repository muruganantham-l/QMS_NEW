update AST_DET
set 
ast_det_datetime1	= '2017-06-01 00:00:00.000',
ast_det_datetime2	= '2018-05-31 00:00:00.000',
ast_det_datetime3	= '2017-06-01 00:00:00.000',
ast_det_datetime4	= '2025-05-31 00:00:00.000',
ast_det_datetime5	= '2017-05-31 00:00:00.000',
ast_det_datetime7	= '2017-06-01 00:00:00.000',
ast_det_datetime19	= '2017-06-01 00:00:00.000',
ast_det_datetime20	= '2025-05-31 00:00:00.000',
ast_det_warranty_date = '2018-05-31 00:00:00.000',
ast_det_purchase_date = '2017-06-01 00:00:00.000',
ast_det_varchar21 = Upper(ast_det_varchar21)
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	and ast_mst_asset_status = 'ACT'
	--AND ast_det_varchar15 = 'Purchase Biomedical'
	and ast_det_purchase_date is NULL
	and ast_det_varchar29 =	'084678c6-57d7-4a42-a12c-9977dec5120b'

update AST_DET
set 
ast_det_datetime1	= '2017-12-01 00:00:00.000',
ast_det_datetime2	= '2018-11-30 00:00:00.000',
ast_det_datetime3	= '2017-12-01 00:00:00.000',
ast_det_datetime4	= '2025-11-30 00:00:00.000',
ast_det_datetime5	= '2017-11-30 00:00:00.000',
ast_det_datetime6   = '2017-11-30 00:00:00.000',
ast_det_datetime7	= '2017-12-01 00:00:00.000',
ast_det_datetime19	= '2017-12-01 00:00:00.000',
ast_det_datetime20	= '2025-11-30 00:00:00.000',
ast_det_warranty_date = '2018-11-30 00:00:00.000',
ast_det_purchase_date =  '2017-12-01 00:00:00.000',
ast_det_varchar21 = Upper(ast_det_varchar21)
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 5'
	and ast_mst_asset_status = 'ACT'
	--AND ast_det_varchar15 = 'Purchase Biomedical'
	and ast_det_purchase_date is NULL


update AST_DET
set 
ast_det_datetime1	= '2018-03-01 00:00:00.000',
ast_det_datetime2	= '2019-02-28 00:00:00.000',
ast_det_datetime3	= '2018-03-01 00:00:00.000',
ast_det_datetime4	= '2026-02-28 00:00:00.000',
ast_det_datetime5	= '2018-02-28 00:00:00.000',
ast_det_datetime6   = '2018-02-28 00:00:00.000',
ast_det_datetime7	= '2018-03-01 00:00:00.000',
ast_det_datetime19	= '2018-03-01 00:00:00.000',
ast_det_datetime20	= '2026-02-28 00:00:00.000',
ast_det_warranty_date = '2019-02-28 00:00:00.000',
ast_det_purchase_date =  '2018-03-01 00:00:00.000',
ast_det_varchar21 = Upper(ast_det_varchar21),
ast_det_varchar26 = ast_det_varchar5
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 6'
	and ast_mst_asset_status = 'ACT'
	--AND ast_det_varchar15 = 'Purchase Biomedical'
	and ast_det_purchase_date is NULL


update AST_DET
set 
ast_det_datetime1	= '2017-09-01 00:00:00.000',
ast_det_datetime2	= '2018-08-31 00:00:00.000',
ast_det_datetime3	= '2017-09-01 00:00:00.000',
ast_det_datetime4	= '2025-08-31 00:00:00.000',
ast_det_datetime5	= '2017-08-31 00:00:00.000',
ast_det_datetime7	= '2017-09-01 00:00:00.000',
ast_det_datetime19	= '2017-09-01 00:00:00.000',
ast_det_datetime20	= '2025-08-31 00:00:00.000',
ast_det_warranty_date = '2018-08-31 00:00:00.000',
ast_det_purchase_date = '2017-09-01 00:00:00.000',
ast_det_varchar21 = Upper(ast_det_varchar21)
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	and ast_mst_asset_status = 'ACT'
	--AND ast_det_varchar15 = 'Purchase Biomedical'
	and ast_det_purchase_date is NULL

update AST_DET
set 
ast_det_datetime1	= '2017-09-01 00:00:00.000',
ast_det_datetime2	= '2018-08-31 00:00:00.000',
ast_det_datetime3	= '2017-09-01 00:00:00.000',
ast_det_datetime4	= '2025-08-31 00:00:00.000',
ast_det_datetime5	= '2017-08-31 00:00:00.000',
ast_det_datetime7	= '2017-09-01 00:00:00.000',
ast_det_datetime19	= '2017-09-01 00:00:00.000',
ast_det_datetime20	= '2025-08-31 00:00:00.000',
ast_det_warranty_date = '2018-08-31 00:00:00.000',
ast_det_purchase_date = '2017-09-01 00:00:00.000',
ast_det_varchar21 = Upper(ast_det_varchar21)
, audit_date = getdate()
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 4'
	and ast_mst_asset_status = 'ACT'
	and ast_det_purchase_date is NULL

update ast_det
set ast_det_warranty_date = '2018-05-31 00:00:00.000', audit_date = getdate()
from ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	and ast_mst_asset_status = 'ACT'
	--and ast_det_warranty_date is nUll

update ast_det
set ast_det_datetime19  ='2017-10-01 00:00:00.000',
ast_det_datetime20 = '2025-09-30 00:00:00.000' ,
audit_date = getdate()
from ast_mst (NOLOCK) ,
AST_DET (NOLOCK) 
where ast_mst.ROWID = AST_DET.mst_RowID
and ast_mst_asset_status = 'ACT'
and ast_mst_asset_no = 'JHNREM056'
and ast_det_datetime19 ='2017-06-01 00:00:00.000'
and  ast_det_datetime20 = '2025-05-31 00:00:00.000'

cf_label
where 	table_name = 'ast_det'
and language_cd = 'DEFAULT'

select distinct ast_det_datetime7,
ast_det_varchar21 
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21  like 'Batch %'
	and ast_mst_asset_status = 'ACT'
	and ast_det_purchase_date is NULL


	update AST_DET
	set ast_det_datetime7 = '2017-03-01 00:00:00' , audit_date = getdate()
	from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 2'
	and ast_mst_asset_status = 'ACT'
	and ast_det_datetime7 is null


	update ast_det
	set ast_det_varchar15 = replace(ast_det_varchar15,'Test','')
	from
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 4'
	and ast_mst_asset_status = 'ACT'
	AND ast_det_varchar15 in( 'Purchase Biomedical','New Biomedical')
	and ast_mst_asset_no = 'WPNCAF001'
	
	select distinct ast_mst_asset_grpcode , ast_mst_asset_shortdesc , ast_det_asset_cost ,ast_det_numeric9,ast_mst_asset_code
	from ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch %'
	and ast_mst_asset_status = 'ACT'


	select ast_mst_asset_no , count(ast_mst_asset_no)
	from ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	--and ast_mst_asset_no = 'SWPREY054'
	and ast_det_varchar21   = 'Batch 3'
	group by ast_mst_asset_no


	select * from  ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	and ast_mst_asset_locn = 'MUKAH'
	and ast_mst_ast_lvl = 'SARAWAK'
	and ast_mst_safety_rqmts= 'V4 : New Biomedical'
	and ast_mst_asset_code = 'KESIHATAN'
	--SWPREY054

	
select ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15,ast_mst_asset_code ,count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL',SUm(ast_det_asset_cost) 'Cost' from ast_mst (nolock) 
,ast_det (nolock)
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar21 = 'Batch 4'
and ast_mst_asset_status in ('ACT')
--and ast_mst_ast_lvl  = 'PERAK'
group by ast_mst_ast_lvl,ast_mst_asset_locn,ast_det_varchar15,ast_mst_asset_code

	--update ast_mst
	--set ast_mst_asset_status = 'DEA' , 
	--	audit_date = getdate()
	--from 
	--ast_mst (NOLOCK) ,
	--AST_DET (NOLOCK) 
	--WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	--and ast_mst_asset_no = 'SWPREY054'
	--and ast_mst_asset_status = 'ACT'

	select ast_det_varchar21, count(*) from
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	group by ast_det_varchar21


update AST_DET
set ast_det_purchase_date = '2017-06-01 00:00:00.000'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	--AND ast_det_varchar15 = 'Purchase Biomedical'
	and ast_det_purchase_date is NULL

	update AST_DET
	set  ast_det_varchar2 = 'NA'
	from ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   = 'Batch 3'
	and ast_det_varchar2 is NULL


select ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
group by ast_det_varchar15 

select ast_det_varchar15 'Ownership',  ast_mst_asset_longdesc 'Category', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
group by ast_det_varchar15 ,ast_mst_asset_longdesc

select ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
group by ast_det_varchar15 
union all
select ast_det_varchar15 'Ownership' ,count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15	=		'Purchase Biomedical'
	and ast_mst_asset_status = 'ACT'
group by ast_det_varchar15

select ast_det_varchar15 'Ownership', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl in ('JOHOR','SARAWAK')
	and ast_mst_asset_locn in ('BATU PAHAT','MUKAH')
	and ast_mst_asset_code = 'KESIHATAN' 
group by ast_det_varchar15 
union all
select ast_det_varchar15 'Ownership' ,count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15	=		'Purchase Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl  in ('SARAWAK')
	and ast_mst_asset_code = 'KESIHATAN' 
	and ast_mst_asset_locn in ('BINTULU','LIMBANG','MIRI','MUKAH','SRI AMAN')
group by ast_det_varchar15
 
 ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_status = 'ACT'
	and ast_mst_ast_lvl in ('SARAWAK')
	and ast_mst_asset_locn in ('LIMBANG')
	and ast_mst_asset_code = 'KESIHATAN' 

	and ast_mst_asset_code = 'KESIHATAN'
	AND ast_mst_asset_locn in ('JOHOR BAHRU'
,'KLUANG'
,'KOTA TINGGI'
,'KULAI JAYA'
,'LEDANG'
,'MERSING'
,'MUAR'
,'SEGAMAT'
,'JELEBU'
,'JEMPOL'
,'KUALA PILAH'
,'PORT DICKSON'
,'REMBAU'
,'SEREMBAN'
,'TAMPIN'
,'KERIAN'
,'KUALA KANGSAR'
,'PERAK TENGAH'
,'BEAUFORT'
,'BELURAN'
,'KINABATANGAN'
,'KOTA KINABALU'
,'KOTA MARUDU'
,'KUALA PENYU'
,'KUDAT'
,'KUNAK'
,'PAPAR'
,'PENAMPANG'
,'PITAS'
,'RANAU'
,'SANDAKAN'
,'SEMPORNA'
,'SIPITANG'
,'TAMBUNAN'
,'TONGOD'
,'TUARAN'
,'BAU'
,'LUNDU'
,'SARATOK'
,'GOMBAK'
,'HULU LANGAT'
,'HULU SELANGOR'
,'KUALA LANGAT'
,'KUALA SELANGOR'
,'PETALING'
,'SABAK BERNAM'
,'SEPANG'
,'CHERAS'
,'LEMBAH PANTAI'
,'PUTRAJAYA'
,'LABUAN'
)
group by ast_det_varchar15 ,ast_mst_asset_longdesc

UNION ALL

select ast_det_varchar15 'Ownership',ast_mst_asset_longdesc 'Category', count(ast_mst.ROWID) 'No of BE', SUm(ast_det_numeric9) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID			= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15 = 'New Biomedical'
	and ast_mst_asset_code = 'PERGIGIAN'
	AND ast_mst_asset_locn in ('BATU PAHAT'
,'KLUANG'
,'KOTA TINGGI'
,'KULAI JAYA'
,'MERSING'
,'PONTIAN'
,'SEGAMAT'
,'ALOR GAJAH'
,'JASIN'
,'MELAKA TENGAH'
,'JELEBU'
,'JEMPOL'
,'KUALA PILAH'
,'PORT DICKSON'
,'REMBAU'
,'SEREMBAN'
,'BATANG PADANG'
,'HILIR PERAK'
,'HULU PERAK'
,'KAMPAR'
,'KERIAN'
,'KINTA'
,'KUALA KANGSAR'
,'LARUT MATANG SELAMA'
,'MANJUNG'
,'PERAK TENGAH'
,'BARAT DAYA'
,'SEBERANG PERAI SELATAN'
,'SEBERANG PERAI TENGAH'
,'SEBERANG PERAI UTARA'
,'TIMUR LAUT'
,'BEAUFORT'
,'KOTA KINABALU'
,'KUDAT'
,'LAHAD DATU'
,'PENAMPANG'
,'SANDAKAN'
,'TAWAU'
,'BINTULU'
,'KAPIT'
,'KUCHING'
,'MIRI'
,'SAMARAHAN'
,'SIBU'
,'SRI AMAN'
,'KLANG'
,'KUALA SELANGOR'
,'PETALING'
,'CHERAS'
,'LEMBAH PANTAI'
,'PUTRAJAYA'
,'LABUAN'
)
group by ast_det_varchar15,ast_mst_asset_longdesc

UNION ALL

select ast_det_varchar15 'Ownership',ast_mst_asset_longdesc 'Category' ,count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15	=		'Purchase Biomedical'
	and ast_mst_asset_code	=	'KESIHATAN'
	AND ast_mst_asset_locn in ('BATU PAHAT'
,'JOHOR BAHRU'
,'KLUANG'
,'KULAI JAYA'
,'LEDANG'
,'MERSING'
,'MUAR'
,'PONTIAN'
,'SEGAMAT'
,'ALOR GAJAH'
,'JASIN'
,'MELAKA TENGAH'
,'JELEBU'
,'JEMPOL'
,'KUALA PILAH'
,'PORT DICKSON'
,'REMBAU'
,'SEREMBAN'
,'TAMPIN'
,'BATANG PADANG'
,'HILIR PERAK'
,'HULU PERAK'
,'KAMPAR'
,'KERIAN'
,'KINTA'
,'KUALA KANGSAR'
,'LARUT MATANG SELAMA'
,'MANJUNG'
,'PERAK TENGAH'
,'BARAT DAYA'
,'SEBERANG PERAI SELATAN'
,'SEBERANG PERAI TENGAH'
,'SEBERANG PERAI UTARA'
,'TIMUR LAUT'
,'BEAUFORT'
,'KENINGAU'
,'KINABATANGAN'
,'KOTA BELUD'
,'KOTA KINABALU'
,'KOTA MARUDU'
,'KUALA PENYU'
,'KUDAT'
,'KUNAK'
,'LAHAD DATU'
,'PAPAR'
,'PENAMPANG'
,'PITAS'
,'RANAU'
,'SANDAKAN'
,'SEMPORNA'
,'TAMBUNAN'
,'TAWAU'
,'TENOM'
,'TONGOD'
,'TUARAN'
,'BAU'
,'BETONG'
,'KAPIT'
,'KUCHING'
,'LUNDU'
,'SAMARAHAN'
,'SARATOK'
,'SARIKEI'
,'SERIAN'
,'SIBU'
,'GOMBAK'
,'HULU LANGAT'
,'HULU SELANGOR'
,'KLANG'
,'KUALA LANGAT'
,'KUALA SELANGOR'
,'PETALING'
,'SABAK BERNAM'
,'SEPANG'
,'CHERAS'
,'KEPONG'
,'LEMBAH PANTAI'
,'PUTRAJAYA'
,'TITIWANGSA'
,'LABUAN'
)
	group by ast_det_varchar15,ast_mst_asset_longdesc

UNION ALL

select ast_det_varchar15 'Ownership',ast_mst_asset_longdesc 'Category',count(ast_mst.ROWID) 'No of BE', SUm(ast_det_asset_cost) 'RENTAL'
from 
	ast_mst (NOLOCK) ,
	AST_DET (NOLOCK) 
	WHERE ast_mst.ROWID		= AST_DET.mst_RowID
	and ast_det_varchar21   like 'Batch 3'
	AND ast_det_varchar15	='Purchase Biomedical'
	and ast_mst_asset_code	= 'PERGIGIAN'
	AND ast_mst_asset_locn in ('BATU PAHAT'
,'JOHOR BAHRU'
,'KLUANG'
,'KOTA TINGGI'
,'KULAI JAYA'
,'LEDANG'
,'MERSING'
,'MUAR'
,'PONTIAN'
,'SEGAMAT'
,'JASIN'
,'MELAKA TENGAH'
,'JELEBU'
,'JEMPOL'
,'KUALA PILAH'
,'PORT DICKSON'
,'REMBAU'
,'SEREMBAN'
,'TAMPIN'
,'BATANG PADANG'
,'HULU PERAK'
,'KAMPAR'
,'KERIAN'
,'KINTA'
,'KUALA KANGSAR'
,'LARUT MATANG SELAMA'
,'MANJUNG'
,'BARAT DAYA'
,'SEBERANG PERAI SELATAN'
,'SEBERANG PERAI TENGAH'
,'SEBERANG PERAI UTARA'
,'TIMUR LAUT'
,'BEAUFORT'
,'KENINGAU'
,'KOTA BELUD'
,'KOTA KINABALU'
,'PENAMPANG'
,'BETONG'
,'BINTULU'
,'KUCHING'
,'MIRI'
,'SIBU'
,'SRI AMAN'
,'GOMBAK'
,'HULU LANGAT'
,'HULU SELANGOR'
,'KLANG'
,'KUALA LANGAT'
,'KUALA SELANGOR'
,'PETALING'
,'SEPANG'
,'CHERAS'
,'KEPONG'
,'LEMBAH PANTAI'
,'PUTRAJAYA'
,'TITIWANGSA'
,'LABUAN'
)
group by ast_det_varchar15 ,ast_mst_asset_longdesc
