
Declare @PO varchar(100) = 'PO107229'
Declare @recNO varchar(100) = 'RCV109412'
Declare @exchange numeric(30,8) = 4.206
--Declare @PR varchar(100) = 'PO107993'

UPDATE puo_mst 
SET puo_mst_exchange_rate = 1.0/@exchange
where puo_mst_po_no = @PO

UPDATE puo_ls1
SET puo_ls1_item_cost = puo_ls1_retail_price *@exchange,
puo_ls1_cur_exchange_rate = 1.0/@exchange
WHERE mst_RowID in (select rowid from puo_mst (nolock) where puo_mst_po_no = @PO )

--update pur_ls1
--set pur_ls1_cur_exchange_rate = 1.0/@exchange
--where mst_rowid in (select mst_RowID from pur_mst
--where pur_mst_porqnnum = @PR )
 
update itm_trx
SET itm_trx_item_cost = itm_trx_item_cost*@exchange,
itm_trx_ext_cost = (itm_trx_ext_cost*@exchange)*itm_trx_cnv_qty,
--itm_trx_avg_cost = itm_trx_avg_cost*@exchange,
itm_trx_last_cost = itm_trx_last_cost*@exchange,
itm_trx_fifo_avg_cost = itm_trx_fifo_avg_cost*@exchange
WHERE itm_trx_doc_no = @recNO

update itm_mtc
set itm_mtc_rcv_cost = itm_mtc_rcv_cost*@exchange,
itm_mtc_inv_cost = itm_mtc_inv_cost*@exchange
where itm_mtc_grn_no = @recNO

update itm_mtr
set itm_mtr_item_cost = itm_mtr_item_cost*@exchange
where itm_mtr_doc_no = @recNO


select sum(itm_mtr_item_cost*itm_mtr_rcv_qty) from itm_mtr where itm_mtr_doc_no = @recNO
select * from puo_mst  where puo_mst_po_no = @PO


