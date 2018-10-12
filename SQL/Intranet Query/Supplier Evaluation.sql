Select 
DENSE_RANK() over( order by wko_mst_wo_no) 'No', 
  Convert(varchar(10),wko_mst_org_date,25) 'WR DateTime',
wko_mst_wo_no 'WO Number',
wko_mst_assetno 'BE Number',
Upper(ast_mst_asset_longdesc) 'BE Category',
Replace(Replace(replace(ltrim(rtrim(wko_det_varchar5)),'	',''),char(13),''),char(10),'') 'Manufacturer',
Replace(Replace(replace(ltrim(rtrim(wko_det_varchar6)),'	',''),char(13),''),char(10),'') 'Model',
Replace(Replace(replace(ltrim(rtrim(wko_mst_descs)),'	',''),char(13),''),char(10),'')  'Problem Reported',
Replace(Replace(replace(ltrim(rtrim(wko_det_corr_action)),'	',''),char(13),''),char(10),'') 'Action Taken',
--wko_ls2.wko_ls2_mr_lineno	'MR Line Number',
mtr_mst_mtr_no 'MR Number' ,
mtr_mst_org_date 'MR Date' ,
mtr_ls1_pr_no 'PR Number',
pur_mst_rqn_date 'PR Date',
pur_ls1_item_category 'Category' ,
pur_ls1_stockno 'Stock Number',
pur_ls1_supplier 'Supplier',
Replace(Replace(replace(ltrim(rtrim(sup_mst_desc )),'	',''),char(13),''),char(10),'') 'Supplier name' ,
pur_mst.pur_mst_status 'PR Status', 
Replace(Replace(isnull(pur_ls1_desc,mtr_ls1_desc),char(13),''),char(10),'') 'Item Required',
pur_ls1.pur_ls1_po_no 'PO Number',
puo_mst_po_date 'PO Date',
wko_mst_asset_level 'State',
wko_mst_asset_location 'District',
Replace(Replace(replace(ltrim(rtrim(wko_det_note1)),'	',''),char(13),''),char(10),'')  'Clinic Name',
wko_mst_work_area 'Circle',
isnull(emp_mst_name,wko_det_assign_to) 'Assign To',
wko_mst_ast_cod 'Clinic Category'

from
	wko_mst (nolock)

join 
	ast_mst (nolock)
on			wko_mst.site_cd = ast_mst.site_cd
and			wko_mst.wko_mst_assetno = ast_mst.ast_mst_asset_no
and			ast_mst_asset_grpcode = wko_mst_asset_group_code
and			ast_mst_asset_status in ('ACT')
--and			wko_mst_asset_location like  @District
--and			wko_mst_work_area like @circle
--and			wko_mst_asset_level like @state
--and         wko_mst_ast_cod like @clinicCateg
--and			ast_mst_asset_grpcode like @becategory
and wko_mst_org_date between '2016-01-01 00:00:00' and '2016-12-31 23:59:00'
join 

	wko_det (nolock)
on			wko_mst.site_cd = wko_det.site_cd
and			wko_mst.RowID = wko_det.mst_RowID
--and			wko_mst_status in ( 'OPE','RFS')
and			wko_mst.wko_mst_wo_no like  'CWO%'

left join wko_ls2 (nolock)
on			wko_mst.site_cd = wko_ls2.site_cd
and			wko_mst.RowID = wko_ls2.mst_RowID
and			wko_mst.wko_mst_wo_no like  'CWO%'

LEFT JOIN mtr_mst (nolock)
ON			mtr_mst.site_cd = wko_ls2.site_cd
AND			mtr_mst.mtr_mst_mtr_no =  wko_ls2.wko_ls2_mr_no
and			mtr_mst_wo_no = wko_mst_wo_no

LEFT JOIN mtr_ls1 (nolock)
ON			mtr_mst.site_cd = mtr_ls1.site_cd
AND			mtr_mst.RowID =  mtr_ls1.mst_RowID
AND			mtr_ls1.mtr_ls1_mtr_lineno =  wko_ls2.wko_ls2_mr_lineno	

--Left JOIN wko_ls3 (nolock)
--on			wko_mst.site_cd = wko_ls3.site_cd
--and			wko_mst.RowID = wko_ls3.mst_RowID
--and			wko_mst.wko_mst_wo_no like  'CWO%'

LEFT JOIN pur_mst (nolock)
ON			pur_mst.site_cd = wko_mst.site_cd
AND			pur_mst.pur_mst_porqnnum =  mtr_ls1_pr_no

LEFT JOIN pur_ls1 (nolock)
ON			pur_mst.site_cd = pur_ls1.site_cd
AND			pur_mst.RowID =  pur_ls1.mst_RowID
AND			pur_ls1.pur_ls1_pr_lineno =  mtr_ls1.mtr_ls1_pr_lineno

left join puo_mst (nolock)
on          puo_mst.site_cd = pur_ls1.site_cd
AND         puo_mst.puo_mst_po_no = pur_ls1_po_no   

Join 
	emp_mst (nolock)
on			wko_mst.site_cd = emp_mst.site_cd
and			emp_mst_status = 'ACT'
and			emp_mst_empl_id = wko_det_assign_to
left join
sup_mst (nolock)
on sup_mst_supplier_cd = pur_ls1_supplier
--where (MR Number is not null and PR Number   is not null)
order by wko_mst_wo_no 



