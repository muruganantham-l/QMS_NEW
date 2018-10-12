

puo_mst_exchange_rate

puo_ls1_item_cost
puo_ls1_cur_exchange_rate

puo_mst where puo_mst_po_no = 'PO107168'


puo_mst where puo_mst_po_no = 'PO107168'
 puo_ls1
--SET puo_ls1_item_cost = puo_ls1_retail_price *(1/0.17873),
--puo_ls1_cur_exchange_rate = 0.17873
WHERE mst_RowID = 27388

 sp_tables 'puo_%'
--PO100003
begin tran
UPDATE puo_mst 
SET puo_mst_exchange_rate = 0.17873
where puo_mst_po_no = 'PO107993'

puo_ls1
puo_ls2
WHERE mst_RowID = 27388
puo_mst
puo_pri
puo_det
puo_grp

UPDATE puo_ls1
--SET puo_ls1_item_cost = puo_ls1_retail_price *(1/0.17873),
--puo_ls1_cur_exchange_rate = 0.17873
WHERE mst_RowID = 28213

1 MYR = .22
500 USD = (1/.22)

select * from cf_label
where default_label like '%slip%%'
and language_cd= 'DEFAULT'

mtr_ls1_item_cost
mtr_ls1


con_ls1
itm_mtc


pur_mst
where pur_mst_porqnnum = 'PR113063'


Declare @PO varchar(100) = 'PO107993'
Declare @recNO varchar(100) = 'RCV109223'
Declare @exchange numeric(30,8) = (1/4.103)
Declare @PR varchar(100) = 'PO107993'

UPDATE puo_mst 
SET puo_mst_exchange_rate = @exchange
where puo_mst_po_no = @PO

UPDATE puo_ls1
SET puo_ls1_item_cost = puo_ls1_retail_price *( 1 / @exchange),
puo_ls1_cur_exchange_rate = @exchange
WHERE mst_RowID in (select rowid from puo_mst (nolock) where puo_mst_po_no = @PO )

update pur_ls1
set pur_ls1_cur_exchange_rate = @exchange
where mst_rowid in (select mst_RowID from pur_mst
where pur_mst_porqnnum = @PR )
 
update itm_trx
SET itm_trx_item_cost = itm_trx_item_cost*(1/@exchange),
itm_trx_ext_cost = (itm_trx_ext_cost*(1/@exchange))*itm_trx_cnv_qty,
--itm_trx_avg_cost = itm_trx_avg_cost*(1/@exchange),
itm_trx_last_cost = itm_trx_last_cost*(1/@exchange),
itm_trx_fifo_avg_cost = itm_trx_fifo_avg_cost*(1/@exchange)
WHERE itm_trx_doc_no = @recNO

update itm_mtc
set itm_mtc_rcv_cost = itm_mtc_rcv_cost*(1/@exchange),
itm_mtc_inv_cost = itm_mtc_inv_cost*(1/@exchange)
where itm_mtc_grn_no = @recNO

update itm_mtr
set itm_mtr_item_cost = itm_mtr_item_cost*(1/@exchange)
where itm_mtr_doc_no = @recNO



