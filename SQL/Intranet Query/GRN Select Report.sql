Select 
itm_trx_rcv_empl_id AS [STATE RECEIVE PHYSICAL PART (EMPLOYEE ID)],
ISNULL(itm_trx_stk_locn,itm_trx_chg_costcenter) AS [STOCK LOCATION],
itm_trx_chg_costcenter AS [COST CENTER],
itm_trx_trx_date AS [RECEIVE DATE (CHOP RECEIVE - REMARKS)],
itm_trx_curr_date AS [GRN DATE (SYSTEM DATE)],
itm_trx_pono AS [PO NO / MISCELLENIOUS (SOURCE)],
ISNULL(itm_mst_stockno,'') AS [STOCK NUM],
Replace(Replace(replace(ltrim(rtrim(itm_trx_desc)),'	',''),char(13),''),char(10),'') AS [STOCK DESCR]	,
ISNULL(itm_mst_partno ,itm_trx_partno) AS [PART NUM]	,
itm_trx_uom AS [UOM],
ISNULL(puo_ls1_ord_qty,0) AS [PO QTY],
itm_trx_rcv_qty AS [RECEIVE QTY]	,
(ISNULL(puo_ls1_ord_qty,0) - itm_trx_rcv_qty ) AS [BALANCE QTY]	,
itm_trx_item_cost AS [ITEM COST (RM)],
itm_trx_item_cost AS [TOTAL COST (RM)]	,
itm_trx_grn_no AS [GRN NUM],
ISNULL(itm_trx_pkg_slip_no,'') AS [SUPPLIER DO NUM],
'' [SUPPLIER],
'' [INVOICE NUM],
CASE WHEN itm_trx_wo = '' THEN ISNULL(puo_ls1_wo_no,'')
ELSE ISNULL(itm_trx_wo,'') END  AS [WO NUM],
itm_trx_mtlrqnnum AS [MR NUM],
ISNULL(puo_ls1_pr_no,'') AS [PR NUM]
FROM  
ITM_TRX (NOLOCK)
left join 
puo_mst(NOLOCK)
ON  ITM_TRX.site_cd = 'QMS'
AND ITM_TRX.site_cd = PUO_MST.site_cd
AND itm_trx_trx_type ='MT41'
AND puo_mst_po_no = itm_trx_pono
LEFT JOIN 
puo_ls1 (NOLOCK)
ON puo_mst.rowid = puo_ls1.mst_rowid 
AND puo_ls1_po_lineno = itm_trx_po_lineno
left JOIN 
itm_mst
ON ITM_TRX.site_cd = 'QMS'
AND ITM_TRX.site_cd = itm_mst.site_cd
AND itm_mst_stockno = itm_trx_stockno
and itm_trx_stockno is not null
WHERE ITM_TRX.site_cd = 'QMS'
AND itm_trx_trx_type = 'MT41'
--AND itm_trx_grn_no LIKE 'RCV%'
ORDER BY  itm_trx_grn_no

itm_mtr

sp_ageing_report_out
itm_mst
where itm_mst_stockno = 'BPA000001'


ITM_TRX
WHERE itm_trx_grn_no = 'RCV100001'

--ITM_TRX
--WHERE itm_trx_mtlrqnnum <> '0'
--AND itm_trx_trx_type = 'MT41'

puo_ls1_pr_no
PR103365
puo_ls1_wo_no
CWO110080

ITM_TRX
WHERE itm_trx_grn_no = 'RCV109587'

itm_mst
WHERE ITM_MST_STOCKNO = 'STK108100'
AND puo_ls1_stockno = 

SELECT * FROM CF_LABEL (NOLOCK)
WHERE TABLE_NAME = 'ITM_TRX'
AND language_cd='DEFAULT'

puo_mst
where puo_mst_po_no ='PO101560'

puo_ls1
where mst_rowid = 21780