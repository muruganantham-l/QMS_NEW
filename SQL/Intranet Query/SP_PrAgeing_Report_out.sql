ALTER Procedure SP_PrAgeing_Report_out
 @state				varchar(200)
,@fromdate			varchar(200)
,@todate			varchar(200)
,@category			varchar(200)
,@manufacturer			varchar(200)
,@Stockno		varchar(200)
,@BENO		varchar(200)  
as 
Begin

Declare @guid nvarchar(200)

--select @state

if @state in ('ALL','0')
begin
set @state = NULL
end
else
begin 
set @state = @state
end

if @fromdate in  ('ALL','0','')
begin
set @fromdate = '1900-01-01'
end

if @todate in  ('ALL','0','')
begin
set @todate = Convert(date,getdate())
end


if @category in  ('ALL','0','')
begin
set @category = NULL
end

if @manufacturer in  ('ALL','0','')
begin
set @manufacturer = NULL
end

if @Stockno in  ('ALL','0','')
begin
set @Stockno = NULL
end

if @BENO in  ('ALL','0','')
begin
set @BENO = NULL
end


select @guid = newid()


insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[WO STATUS]
,[MRE NO],[MRE DATE],[PR NO],[PR DATE],[PR CATEGORY],[FINANCE CODE],[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],[UNIT PRICE],
[SUPPLIER],[PO NO],[PO NO DATE],[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])
 
select Distinct
@guid 'Guid',
ast_mst_ast_lvl 'STATE NAME' ,
ast_mst_asset_no 'BE NO',
ast_mst_asset_shortdesc 'BE General Name',
ast_mst_cost_center 'COST CENTER',
ast_det_mfg_cd 'MANUFACTURER',
ast_det_modelno 'MODEL',
wko_mst_wo_no 'CWO NO',
Convert(date,wko_mst_org_date ) 'CWO DATE',
wko_mst_status 'CWO Status',
mtr_mst_mtr_no 'MRE NO',
Convert(date,Isnull(mtr_mst_org_date ,mtr_mst_req_date))  'MRE DATE' ,
mtr_ls1_pr_no 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
pur_mst_chg_account 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
mtr_ls1_stockno 'STOCK NO',
mtr_ls1_desc 'SPARE PART DESCRIPTION',
mtr_ls1_req_qty 'QTY',
mtr_ls1_item_cost 'UNIT PRICE',
puo_mst_supplier 'RECOMMENDED SUPPLIER',
pur_ls1_po_no 'PO NO',
Convert(date,puo_mst_po_date ) 'PO NO DATE',
isnull(DATEDIFF(dd,wko_mst_org_date,mtr_mst_org_date),0) 'NO OF DAYS AGING (WO TO MRE)',
isnull(DATEDIFF(dd,mtr_mst_org_date,pur_mst_rqn_date),0) 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from 
ast_mst (Nolock) 
join
ast_det (nolock)
on ast_mst.Rowid = ast_det.Mst_rowid
and ast_mst.site_cd = ast_det.site_cd
and ast_mst.ast_mst_asset_grpcode = isnull(@category,ast_mst_asset_grpcode)
and ast_mst.ast_mst_ast_lvl = isnull(@state,ast_mst_ast_lvl)
and ast_mst.ast_mst_asset_no = isnull(@BENO,ast_mst_asset_no)
and ast_mst.site_cd = 'QMS'
join 
wko_mst (nolock)
on  ast_mst.site_cd = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and left(wko_mst_wo_no,3) = 'CWO'
join
wko_ls2 (nolock)
on			wko_mst.site_cd = wko_ls2.site_cd
and			wko_mst.RowID = wko_ls2.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
left outer join
mtr_mst (Nolock)
on  wko_mst.site_cd = mtr_mst.site_cd
and ast_mst.site_cd = 'QMS'
and wko_ls2_mr_no = mtr_mst_mtr_no
and wko_mst_wo_no = mtr_mst_wo_no
LEFT outer JOIN 
mtr_ls1 (nolock)
on mtr_ls1.site_cd = mtr_mst.site_cd
and mtr_ls1.mst_rowid = mtr_mst.rowid
LEFT outer JOIN 
pur_mst (nolock)
on mtr_ls1.site_cd = pur_mst.site_cd
and pur_mst_porqnnum = mtr_ls1_pr_no
and ((convert(date,pur_mst_rqn_date) between  @fromdate and @todate) or (convert(date,wko_mst_org_date) between @fromdate and @todate))
LEFT outer JOIN 
pur_ls1 (nolock)
on pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.Mst_rowid = pur_mst.rowid
left outer join
puo_mst (nolock)
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no



insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[WO STATUS],[MRE NO],[MRE DATE],[PR NO],[PR DATE],
[PR CATEGORY],[FINANCE CODE],[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],
[UNIT PRICE],[SUPPLIER],[PO NO],[PO NO DATE],[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])
 
Select Distinct
@guid 'Guid',
ast_mst_ast_lvl 'STATE NAME' ,
ast_mst_asset_no 'BE NO',
ast_mst_asset_shortdesc 'BE General Name',
ast_mst_cost_center 'COST CENTER',
ast_det_mfg_cd 'MANUFACTURER',
ast_det_modelno 'MODEL',
wko_mst_wo_no 'CWO NO',
Convert(date,wko_mst_org_date ) 'CWO DATE',
wko_mst_status 'CWO Status',
wko_ls3_mr_no 'MRE NO',
NULL  'MRE DATE' ,
wko_ls3_pr_no 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
pur_mst_chg_account 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
wko_ls3_stockno 'STOCK NO',
wko_ls3_descr 'SPARE PART DESCRIPTION',
wko_ls3_qty_needed 'QTY',
wko_ls3_item_cost 'UNIT PRICE',
wko_ls3_rec_supplier 'RECOMMENDED SUPPLIER',
puo_mst_po_no 'PO NO',
convert(date,puo_mst_po_date ) 'PO NO DATE',
0 'NO OF DAYS AGING (WO TO MRE)',
0 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from 
ast_mst (Nolock) 
join
ast_det (nolock)
on ast_mst.Rowid = ast_det.Mst_rowid
and ast_mst.site_cd = ast_det.site_cd
and ast_mst.ast_mst_asset_grpcode = isnull(@category,ast_mst_asset_grpcode)
and ast_mst.ast_mst_ast_lvl = isnull(@state,ast_mst_ast_lvl)
and ast_mst.ast_mst_asset_no = isnull(@BENO,ast_mst_asset_no)
and ast_mst.site_cd = 'QMS'
join 
wko_mst (nolock)
on  ast_mst.site_cd = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and left(wko_mst_wo_no,3) = 'CWO'
join
wko_ls3 (nolock)
on			wko_mst.site_cd = wko_ls3.site_cd
and			wko_mst.RowID = wko_ls3.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
LEFT JOIN 
pur_mst (nolock)
on wko_ls3.site_cd = pur_mst.site_cd
and pur_mst_porqnnum = wko_ls3_pr_no
and ((convert(date,pur_mst_rqn_date) between  @fromdate and @todate) or (convert(date,wko_mst_org_date) between @fromdate and @todate))
LEFT JOIN 
pur_ls1 (nolock)
on pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.Mst_rowid = pur_mst.rowid
left outer join
puo_mst (nolock)
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no



insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[WO STATUS],[MRE NO],[MRE DATE],[PR NO],
[PR DATE],[PR CATEGORY],[FINANCE CODE],[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],[UNIT PRICE],
[SUPPLIER],[PO NO],[PO NO DATE],[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])

Select Distinct
@guid 'Guid',
ast_mst_ast_lvl 'STATE NAME' ,
ast_mst_asset_no 'BE NO',
ast_mst_asset_shortdesc 'BE General Name',
ast_mst_cost_center 'COST CENTER',
ast_det_mfg_cd 'MANUFACTURER',
ast_det_modelno 'MODEL',
wko_mst_wo_no 'CWO NO',
Convert(date,wko_mst_org_date ) 'CWO DATE',
wko_mst_status 'CWO Status',
NULL 'MRE NO',
NULL  'MRE DATE' ,
wko_ls4_pr_no 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
pur_mst_chg_account 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
pur_ls1_stockno 'STOCK NO',
pur_ls1_desc 'SPARE PART DESCRIPTION',
pur_ls1_ord_qty 'QTY',
pur_ls1_item_cost 'UNIT PRICE',
pur_ls1_supplier 'RECOMMENDED SUPPLIER',
puo_mst_po_no 'PO NO',
convert(date,puo_mst_po_date ) 'PO NO DATE',
0 'NO OF DAYS AGING (WO TO MRE)',
0 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from 
ast_mst (Nolock) 
join
ast_det (nolock)
on ast_mst.Rowid = ast_det.Mst_rowid
and ast_mst.site_cd = ast_det.site_cd
and ast_mst.ast_mst_asset_grpcode = isnull(@category,ast_mst_asset_grpcode)
and ast_mst.ast_mst_ast_lvl = isnull(@state,ast_mst_ast_lvl)
and ast_mst.ast_mst_asset_no = isnull(@BENO,ast_mst_asset_no)
and ast_mst.site_cd = 'QMS'
join 
wko_mst (nolock)
on  ast_mst.site_cd = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and left(wko_mst_wo_no,3) = 'CWO'
join
wko_ls4 (nolock)
on			wko_mst.site_cd = wko_ls4.site_cd
and			wko_mst.RowID = wko_ls4.mst_RowID
and left(wko_mst_wo_no,3) = 'CWO'
LEFT JOIN 
pur_mst (nolock)
on wko_ls4.site_cd = pur_mst.site_cd
and pur_mst_porqnnum = wko_ls4_pr_no
and ((convert(date,pur_mst_rqn_date) between  @fromdate and @todate) or (Convert(date,wko_mst_org_date) between @fromdate and @todate))
LEFT JOIN 
pur_ls1 (nolock)
on pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.Mst_rowid = pur_mst.rowid
left outer join
puo_mst (nolock)
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no

insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[MRE NO],[MRE DATE],[PR NO],[PR DATE],[PR CATEGORY],[FINANCE CODE],
[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],[UNIT PRICE],[SUPPLIER],[PO NO],[PO NO DATE],
[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])
 
Select Distinct
@guid 'Guid',
ast_mst_ast_lvl 'STATE NAME' ,
ast_mst_asset_no 'BE NO',
ast_mst_asset_shortdesc 'BE General Name',
ast_mst_cost_center 'COST CENTER',
ast_det_mfg_cd 'MANUFACTURER',
ast_det_modelno 'MODEL',
NULL 'CWO NO',
NULL 'CWO DATE',
mtr_mst_mtr_no 'MRE NO',
Convert(date,Isnull(mtr_mst_org_date ,mtr_mst_req_date))  'MRE DATE' ,
mtr_ls1_pr_no 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
pur_mst_chg_account 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
mtr_ls1_stockno 'STOCK NO',
mtr_ls1_desc 'SPARE PART DESCRIPTION',
mtr_ls1_req_qty 'QTY',
mtr_ls1_item_cost 'UNIT PRICE',
isnull(pur_ls1.pur_ls1_rec_supplier,pur_ls1_supplier) 'RECOMMENDED SUPPLIER',
puo_mst_po_no 'PO NO',
Convert(date,puo_mst_po_date) 'PO NO DATE',
0 'NO OF DAYS AGING (WO TO MRE)',
isnull(DATEDIFF(dd,mtr_mst_org_date,pur_mst_rqn_date),0) 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from 
ast_mst (Nolock) 
join
ast_det (nolock)
on ast_mst.Rowid = ast_det.Mst_rowid
and ast_mst.site_cd = ast_det.site_cd
and ast_mst.ast_mst_asset_grpcode = isnull(@category,ast_mst_asset_grpcode)
and ast_mst.ast_mst_ast_lvl = isnull(@state,ast_mst_ast_lvl)
and ast_mst.ast_mst_asset_no = isnull(@BENO,ast_mst_asset_no)
and ast_mst.site_cd = 'QMS'
join
mtr_mst (Nolock)
on  ast_mst.site_cd = mtr_mst.site_cd
and ast_mst.site_cd = 'QMS'
and ast_mst_asset_no = mtr_mst_assetno
and mtr_mst_wo_no is null
--and isnull(mtr_mst_org_date,@fromdate) between @fromdate and @todate
left outer join 
mtr_ls1 (nolock)
on mtr_ls1.site_cd = mtr_mst.site_cd
and mtr_ls1.mst_rowid = mtr_mst.rowid
left outer join 
pur_mst (nolock)
on mtr_ls1.site_cd = pur_mst.site_cd
and pur_mst_porqnnum = mtr_ls1_pr_no
and ((convert(date,pur_mst_rqn_date) between  @fromdate and @todate) or (Convert(date,mtr_mst_org_date) between @fromdate and @todate))
left outer join 
pur_ls1 (nolock)
on pur_ls1.site_cd = pur_mst.site_cd
and pur_ls1.Mst_rowid = pur_mst.rowid
left outer join
puo_mst (nolock)
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no



insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[WO STATUS],[MRE NO],[MRE DATE],[PR NO],[PR DATE],[PR CATEGORY],[FINANCE CODE],
[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],[UNIT PRICE],[SUPPLIER],[PO NO],[PO NO DATE],
[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])

select 
@guid 'Guid',
ast_mst_ast_lvl 'STATE NAME' ,
ast_mst_asset_no 'BE NO',
ast_mst_asset_shortdesc 'BE General Name',
ast_mst_cost_center 'COST CENTER',
ast_det_mfg_cd 'MANUFACTURER',
ast_det_modelno 'MODEL',
pur_ls1_wo_no 'CWO NO',
Convert(date,wko_mst_org_date ) 'CWO DATE',
wko_mst_status 'CWO Status',
NULL 'MRE NO',
NULL  'MRE DATE' ,
pur_mst_porqnnum 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
isnull(pur_mst_chg_account,pur_ls1_chg_account ) 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
pur_ls1_stockno 'STOCK NO',
pur_ls1_desc 'SPARE PART DESCRIPTION',
pur_ls1_ord_qty 'QTY',
pur_ls1_item_cost 'UNIT PRICE',
pur_ls1_supplier 'RECOMMENDED SUPPLIER',
puo_mst_po_no 'PO NO',
convert(date,puo_mst_po_date ) 'PO NO DATE',
0 'NO OF DAYS AGING (WO TO MRE)',
0 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from
ast_mst (Nolock) 
join
ast_det (nolock)
on ast_mst.Rowid = ast_det.Mst_rowid
and ast_mst.site_cd = ast_det.site_cd
and ast_mst.ast_mst_asset_grpcode = isnull(@category,ast_mst_asset_grpcode)
and ast_mst.ast_mst_ast_lvl = isnull(@state,ast_mst_ast_lvl)
and ast_mst.ast_mst_asset_no = isnull(@BENO,ast_mst_asset_no)
and ast_mst.site_cd = 'QMS'
join 
wko_mst (nolock)
on  ast_mst.site_cd = wko_mst.site_cd
and ast_mst_asset_no = wko_mst_assetno
and left(wko_mst_wo_no,3) = 'CWO'
right outer join 
pur_ls1 (nolock)
on pur_ls1.site_cd = ast_mst.site_cd
and wko_mst_wo_no = pur_ls1_wo_no
join
pur_mst (nolock) 
on pur_ls1.Mst_rowid = pur_mst.rowid
and ((convert(date,pur_mst_rqn_date) between  @fromdate and @todate) or (convert(date,wko_mst_org_date) between @fromdate and @todate))
and pur_mst_porqnnum not in (select wko_ls4_pr_no from  wko_ls4 (nolock) where wko_ls4_pr_no is not null)
and pur_mst_porqnnum not in (select wko_ls3_pr_no from  wko_ls3 (nolock) where wko_ls3_pr_no is not null)
and pur_mst_porqnnum not in (Select distinct mtr_ls1_pr_no from wko_ls2 (nolock)  join mtr_mst (Nolock)
								on  wko_ls2.site_cd = mtr_mst.site_cd
								and mtr_mst.site_cd = 'QMS'
								and wko_ls2_mr_no = mtr_mst_mtr_no
								JOIN 
								mtr_ls1 (nolock)
								on mtr_ls1.site_cd = mtr_mst.site_cd
								and mtr_ls1.mst_rowid = mtr_mst.rowid
								and mtr_ls1_pr_no is not null) 
and pur_mst_porqnnum not in (Select distinct mtr_ls1_pr_no from mtr_mst (Nolock) JOIN 
								mtr_ls1 (nolock)
								on mtr_ls1.site_cd = mtr_mst.site_cd
								and mtr_ls1.mst_rowid = mtr_mst.rowid
								and mtr_ls1_pr_no is not null)

left outer join
puo_mst (nolock)
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no
where ast_mst_asset_no is not null

if @category is null
begin
insert into qms_mmd_praging_tab
([Guid],[STATE NAME],[BE NO],[BE CATEGORY],[COST CENTER],[MANUFACTURER],[MODEL],[WO NO],[WO DATE],[MRE NO],[MRE DATE],[PR NO],[PR DATE],[PR CATEGORY],[FINANCE CODE],
[STATUS],[APPROVAL PROCESS],[STOCK NO],[DESCRIPTION],[QTY],[UNIT PRICE],[SUPPLIER],[PO NO],[PO NO DATE],
[NO OF DAYS AGING (WO TO MRE)],[NO OF DAYS AGING (MRE TO PR)],[NO OF DAYS AGING (PR TO PO)])

select distinct
@guid 'Guid',
SatateDesc 'STATE NAME' ,
NULL 'BE NO',
NULL 'BE General Name',
pur_mst_chg_costcenter 'COST CENTER',
NULL 'MANUFACTURER',
NULL 'MODEL',
NULL 'CWO NO',
NUlL 'CWO DATE',
NULL 'MRE NO',
NULL  'MRE DATE' ,
pur_mst_porqnnum 'PR NO',
convert(date,pur_mst_rqn_date) 'PR DATE',
pur_mst_notes 'PR CATEGORY',
pur_mst_chg_account 'FINANCE CODE',
pur_mst_status 'PR STATUS',
(Convert(varchar,pur_mst_cur_app_level) +'|'+convert(varchar,pur_mst_app_level )) 'APPROVAL PROCESS',
pur_ls1_stockno 'STOCK NO',
pur_ls1_desc 'SPARE PART DESCRIPTION',
pur_ls1_ord_qty 'QTY',
pur_ls1_item_cost 'UNIT PRICE',
pur_ls1_supplier 'RECOMMENDED SUPPLIER',
puo_mst_po_no 'PO NO',
convert(date,puo_mst_po_date ) 'PO NO DATE',
0 'NO OF DAYS AGING (WO TO MRE)',
0 'NO OF DAYS AGING (MRE TO PR)',
isnull(DATEDIFF(dd,pur_mst_rqn_date,puo_mst_po_date),0) 'NO OF DAYS AGING (PR TO PO)'
from
pur_mst (nolock) 
join 
pur_ls1 (nolock) 
on pur_ls1.Mst_rowid = pur_mst.rowid
and pur_ls1.site_cd = pur_mst.site_cd
and isnull(pur_ls1_wo_no,'NA') = 'NA'
and convert(date,isnull(pur_mst_rqn_date,@fromdate)) between  @fromdate and @todate
and ( pur_mst_dept = 'TSD' or left(pur_mst_chg_costcenter,3) = 'TSD')
and pur_mst_porqnnum not in (select wko_ls4_pr_no from  wko_ls4 (nolock) where wko_ls4_pr_no is not null)
and pur_mst_porqnnum not in (select wko_ls3_pr_no from  wko_ls3 (nolock) where wko_ls3_pr_no is not null)
and pur_mst_porqnnum not in (Select distinct mtr_ls1_pr_no from wko_ls2 (nolock)  join mtr_mst (Nolock)
								on  wko_ls2.site_cd = mtr_mst.site_cd
								and mtr_mst.site_cd = 'QMS'
								and wko_ls2_mr_no = mtr_mst_mtr_no
								JOIN 
								mtr_ls1 (nolock)
								on mtr_ls1.site_cd = mtr_mst.site_cd
								and mtr_ls1.mst_rowid = mtr_mst.rowid
								and mtr_ls1_pr_no is not null) 
and pur_mst_porqnnum not in (Select distinct mtr_ls1_pr_no from mtr_mst (Nolock) JOIN 
								mtr_ls1 (nolock)
								on mtr_ls1.site_cd = mtr_mst.site_cd
								and mtr_ls1.mst_rowid = mtr_mst.rowid
								and mtr_ls1_pr_no is not null)

join
PR_location_mst (nolock)
on left(pur_mst_chg_costcenter,3) =  Statecode
and SatateDesc = isnull(@state,SatateDesc)
left outer join
puo_mst (nolock) 
on pur_ls1.site_cd = puo_mst.site_cd
and puo_mst_po_no = pur_ls1_po_no

end

Update tab
set [STATUS] = pur_sts_description
from
qms_mmd_praging_tab tab(nolock),
pur_sts sts (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and sts.pur_sts_st_cat  = 'PR'
and pur_sts_status = [STATUS]

Update tab
set [SUPPLIER] = sup_mst_desc
from
qms_mmd_praging_tab tab(nolock),
sup_mst sts (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and sup_mst_supplier_cd = [SUPPLIER]


Update tab
set [PRE DATE] = Convert(varchar,isnull(pur_ls2_datetime1,[PR DATE]),120)
from
qms_mmd_praging_tab tab(nolock),
pur_ls2  sts (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and [PR NO] = pur_ls2_varchar1
and pur_ls2_varchar2 = 'PRE'
and [PR NO] is not null
and pur_ls2_datetime1 in (select max(sts1.pur_ls2_datetime1) from pur_ls2  sts1 (nolock)
							where [Guid] = @guid
							and sts1.site_cd = 'QMS'
							and sts1.site_cd = sts.site_cd 
							and [PR NO] = sts.pur_ls2_varchar1
							and sts1.pur_ls2_varchar1 = sts.pur_ls2_varchar1
							and sts1.pur_ls2_varchar2 = 'PRE'
							and sts1.pur_ls2_varchar2 = sts.pur_ls2_varchar2 
							)

Update tab
set [PRE DATE] = Convert(varchar,isnull(pur_ls2_datetime1,[PR DATE]),120)
from
qms_mmd_praging_tab tab(nolock),
pur_ls2  sts (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and [PR NO] = pur_ls2_varchar1
and pur_ls2_varchar2 = 'RFQ'
and [PR NO] is not null
and [PRE DATE] is NULL
and pur_ls2_datetime1 in (select max(sts1.pur_ls2_datetime1) from pur_ls2  sts1 (nolock)
							where [Guid] = @guid
							and sts1.site_cd = 'QMS'
							and sts1.site_cd = sts.site_cd 
							and [PR NO] = sts.pur_ls2_varchar1
							and sts1.pur_ls2_varchar1 = sts.pur_ls2_varchar1
							and sts1.pur_ls2_varchar2 = 'RFQ'
							and sts1.pur_ls2_varchar2 = sts.pur_ls2_varchar2 
							)

Update tab
set [PRE DATE] = Convert(varchar,[PR DATE],120)
from
qms_mmd_praging_tab tab(nolock)
where [Guid] = @guid
and [PR NO] is not null
and [PRE DATE] is NULL

Update tab
set [PRE APPROVED DATE] = Convert(varchar,pur_app_date,120)
from
qms_mmd_praging_tab tab(nolock),
pur_mst  sts (nolock) ,
pur_app app (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and sts.site_cd = app.site_cd
and mst_RowID   = sts.RowID
and pur_app_level = 1
and pur_app_status = 'Y'
and [PR NO] =  pur_mst_porqnnum
and [PR NO] is not null

Update tab
set [PR APPROVED DATE] =  Convert(varchar,pur_app_date,120)
from
qms_mmd_praging_tab tab(nolock),
pur_mst  sts (nolock) ,
pur_app app (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and sts.site_cd = app.site_cd
and mst_RowID   = sts.RowID
and pur_app_status = 'Y'
and [PR NO] =  pur_mst_porqnnum
and [PR NO] is not null
and pur_app_level  = (select max(pur_app_level) 
							from pur_mst  sts1 (nolock) ,
								pur_app app1 (nolock) 
								where sts1.site_cd = 'QMS'
								and sts1.site_cd = app1.site_cd
								and app1.mst_RowID   = sts1.RowID
								--and app1.pur_app_status = 'Y' 
								and app.mst_RowID   = sts.RowID
								and sts.pur_mst_porqnnum = sts1.pur_mst_porqnnum
								)

Update tab
set [PO STATUS] = puo_sts_description
from
qms_mmd_praging_tab tab(nolock),
puo_mst mst (nolock) ,
puo_sts sts (nolock)
where [Guid] = @guid
and sts.site_cd = 'QMS'
and sts.site_cd = mst.site_cd 
and puo_sts_status = puo_mst_status
and puo_mst_po_no = [PO NO]
and sts.puo_sts_st_cat_cd  = 'PO'


update qms_mmd_praging_tab
set [NO OF DAYS AGING (MRE TO PRE)] = isnull(dbo.[TotalDays]('QMS', [MRE DATE] ,[PRE DATE]),0) 
where [Guid] = @guid

update qms_mmd_praging_tab
set [NO OF DAYS AGING (PRE TO PO)] = isnull(dbo.[TotalDays]('QMS', [PRE DATE],[PO NO DATE]),0)
where [Guid] = @guid

update qms_mmd_praging_tab
set [NO OF DAYS AGING (PRE TO PRE APPROVED)] = isnull(dbo.[TotalDays]('QMS', [PRE DATE],[PRE APPROVED DATE]),0)
where [Guid] = @guid

update qms_mmd_praging_tab
set [NO OF DAYS AGING (PRE TO PR APPROVED)] = isnull(dbo.[TotalDays]('QMS', [PRE DATE],[PR APPROVED DATE]),0)
where [Guid] = @guid

update qms_mmd_praging_tab
set [NO OF DAYS AGING (PR APPROVED TO PO DATE)] = isnull(dbo.[TotalDays]('QMS', [PR APPROVED DATE],[PO NO DATE]),0)
where [Guid] = @guid


select 
Distinct 
[STATE NAME],
[BE NO],
[BE CATEGORY],
[MRE NO],
[MRE DATE],
[PR NO],
[PRE DATE],
[PRE APPROVED DATE],
[PR APPROVED DATE],
[PR CATEGORY],
[FINANCE CODE],
[STATUS],
[APPROVAL PROCESS],
[WO NO],
[WO DATE],
[WO STATUS],
[COST CENTER],
[MANUFACTURER],
[MODEL],
[STOCK NO],
Replace(Replace([DESCRIPTION],char(10),''),char(13),'') as [DESCRIPTION],
[QTY],
[UNIT PRICE],
Replace(Replace([SUPPLIER],char(10),''),char(13),'') as [SUPPLIER],
[PO NO],
[PO NO DATE],
[PO STATUS],
[NO OF DAYS AGING (WO TO MRE)],
[NO OF DAYS AGING (MRE TO PRE)],
[NO OF DAYS AGING (PRE TO PO)] ,
[NO OF DAYS AGING (PRE TO PRE APPROVED)],
[NO OF DAYS AGING (PRE TO PR APPROVED)],
[NO OF DAYS AGING (PR APPROVED TO PO DATE)]
from qms_mmd_praging_tab (nolock)
where [Guid] = @guid
and ((convert(date,[PR DATE]) between  @fromdate and @todate) or (convert(date,[WO DATE] ) between @fromdate and @todate) or (convert(date,[MRE DATE]) between @fromdate and @todate) )


delete from qms_mmd_praging_tab 
where [Guid] = @guid

end

--truncate table qms_mmd_praging_tab

--CREATE INDEX primary_index1
--ON qms_mmd_praging_tab (Guid,[STATE NAME],[BE NO])

--Alter table qms_mmd_praging_tab
--add [PRE DATE] nvarchar(400)

--Alter table qms_mmd_praging_tab
--add [PRE APPROVED DATE] nvarchar(400)

--Alter table qms_mmd_praging_tab
--add [PR APPROVED DATE] nvarchar(400)

--Alter table qms_mmd_praging_tab
--add [PO STATUS] nvarchar(400)

--Alter table qms_mmd_praging_tab
--add [FINANCE CODE] nvarchar(400)

--Alter table qms_mmd_praging_tab
--add [NO OF DAYS AGING (MRE TO PRE)] int

--Alter table qms_mmd_praging_tab
--add [NO OF DAYS AGING (PRE TO PO)] int

--Alter table qms_mmd_praging_tab
--add [NO OF DAYS AGING (PRE TO PRE APPROVED)] int

--Alter table qms_mmd_praging_tab
--add [NO OF DAYS AGING (PRE TO PR APPROVED)] int

--Alter table qms_mmd_praging_tab
--add [NO OF DAYS AGING (PR APPROVED TO PO DATE)] int

--Alter table qms_mmd_praging_tab
--add [WO STATUS] nvarchar(400)

