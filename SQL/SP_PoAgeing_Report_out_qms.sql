CREATE Procedure SP_PoAgeing_Report_out_qms
 @state			varchar(200) = 'negeri sembilan'
,@fromdate		varchar(200) = '2018-01-01'
,@todate		varchar(200) = '2018-11-30'
,@status		varchar(200) = 'all'
,@Supplier		varchar(200) = 0
,@deliverdate	varchar(200) = null
,@deliverdateto	varchar(200) = null
as 
begin
--note bafor modfied murugan the old sp name is SP_PoAgeing_Report_out
Declare @guid nvarchar(200)

--select @state

--select 
-- @state		       '@state'	
--,@fromdate		   '@fromdate'
--,@todate		  '@todate'
--,@status		   '@status'
--,@Supplier		  '@Supplier'
--,@deliverdate	   '@deliverdate'
--,@deliverdateto   '@deliverdateto'
--into test

--drop table test

if @state in ('ALL','0')
begin
set @state = '%'
end
else
begin 
set @state = '%'+@state
end
if @fromdate in  ('ALL','0','')
begin
set @fromdate = '1900-01-01'
end
if @todate in  ('ALL','0','')
begin
set @todate = Convert(date,getdate())
end
if @deliverdate in  ('ALL','0','')
begin
set @deliverdate = NULL
end

if @deliverdateto in  ('ALL','0','')
begin
set @deliverdateto = NULL
end

if @status in  ('ALL','0')
begin
set @status = '%'
end
if @Supplier in  ('ALL','0')
begin
set @Supplier = '%'
end

select @guid = newid()
--alter table qms_mmd_poaging_tab_tmp add [rowid] numeric(9)
if @state = '%PULAU PINANG KOLEJ'
begin
Insert into qms_mmd_poaging_tab_tmp (slno , [GUID] ,[PO NO.],[PO Date],[State Name],[Type Of Service],[Supplier Name],[PO Status],[Delivery Date],[Payment Terms],
[Currency Code],[Exchange Value],[Total Cost],[Total Cost in (RM)],[PR No],[Close Date],[Created By],[No of Days Aging(PO Date to Close Date)],
[No of Days Aging(PO Date to Delivery Date)] ,[Costcenter] ,rowid


,[PO Line]
,[Item Category]
,[Stock No]
,[Description]
,[Order UOM]
,[Item Cost]
,[Suggest Quantity]
,[Order Qty]
,[Received Qty]
,[RTS Qty]
,[Matched Qty]
,[Retail Price]
,[Discount %]
,[Discount Amount]
,[Net Price]
,[Extended Price]
,[Line Currency Code]--need to add in grid
,[Currency Rate]
,[Stock Location]
,[Tax Code]
,[Tax Rate]
,[Tax Value]
,[Charge Cost Center]
,[Charge Account]
,[SLA Date]
,[Require Date]
,[Department]
,[Extended Description]
,[WO No]
,[PR Line]
,[MR No]
,[Contract ID]
,[Contract Line]
,[Contract Reference]
,[Last Received Date]

)
select
ROW_NUMBER() over (Partition by puo_mst_po_no order by puo_mst_po_no ),
@guid , 
puo_mst_po_no as 'PO NO.', 
Convert(date ,puo_mst_po_date) as 'PO Date',
SatateDesc as 'State Name',
puo_ls1_chg_account  'Type Of Service',
sup_mst_desc 'Supplier Name',
puo_sts_description 'PO Status',
Convert(date ,puo_mst_promised_date ) 'Delivery Date',
isnull(puo_det_terms,puo_det_po_trailer)  'Payment Terms',
puo_mst_curr_code 'Currency Code', 
Convert(numeric(28,4) ,puo_ls1_cur_exchange_rate  ) 'Exchange Value',
(puo_ls1_ord_qty * puo_ls1_retail_price ) 'Total Cost' ,
(puo_ls1_ord_qty * (1/puo_ls1_cur_exchange_rate)*puo_ls1_retail_price) 'Total Cost in (RM)',
puo_ls1_pr_no 'PR No',
Convert(date ,puo_mst_clo_date)  'Close Date',
puo_mst_create_by 'Created By',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_clo_date),0) 'No of Days Aging(PO Date to Close Date)',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_promised_date),0) 'No of Days Aging(PO Date to Delivery Date)',
puo_ls1_chg_costcenter,
puo_mst.RowID,
 puo_ls1_po_lineno 'PO Line'
,puo_ls1_item_category 'Item Category'
,puo_ls1_stockno 'Stock No'
,puo_ls1_description 'Description'
,puo_ls1_ord_uom 'Order UOM'
,puo_ls1_item_cost 'Item Cost'
,puo_ls1_suggest_qty 'Suggest Quantity'
,puo_ls1_ord_qty 'Order Qty'
,puo_ls1_rcv_qty 'Received Qty'
,puo_ls1_invoice_qty 'RTS Qty'
,puo_ls1_match_qty 'Matched Qty'
,puo_ls1_retail_price 'Retail Price'
,puo_ls1_discount_pct 'Discount %'
,puo_ls1_discount_amt 'Discount Amount'
,puo_ls1_net_price 'Net Price'
,puo_ls1_net_price 'Extended Price'
,puo_ls1_cur_code 'Line Currency Code'
,puo_ls1_cur_exchange_rate 'Currency Rate'
,puo_ls1_stk_locn 'Stock Location'
,puo_ls1_tax_code 'Tax Code'
,puo_ls1_tax_rate 'Tax Rate'
,puo_ls1_tax_value 'Tax Value'
,puo_ls1_chg_costcenter 'Charge Cost Center'
,puo_ls1_chg_account 'Charge Account'
,puo_ls1_promised_date 'SLA Date'
,puo_ls1_req_date 'Require Date'
,puo_ls1_dept 'Department'
,cast(puo_ls1_ext_description as NVARCHAR(MAX))'Extended Description'
,puo_ls1_wo_no 'WO No'
--,l1.puo_ls1_pr_no 'PR No'
,puo_ls1_pr_lineno 'PR Line'
,puo_ls1_mr_no 'MR No'
,puo_ls1_contract_id 'Contract ID'
,puo_ls1_contract_lineno 'Contract Line'
,puo_ls1_contract_ref 'Contract Reference'
,puo_ls1_clo_date 'Last Received Date'

from 
puo_mst (nolock) , 
puo_det (nolock) ,
puo_ls1 (nolock) ,
sup_mst (nolock) ,
puo_sts (nolock) ,
Report_location_mst (nolock)
where puo_mst.site_cd  =  puo_det.site_cd
and puo_det.site_cd  =  puo_ls1.site_cd
and puo_det.site_cd  =  sup_mst.site_cd
and puo_det.site_cd  =  puo_sts.site_cd
and puo_mst.RowID = puo_det.mst_RowID
and puo_ls1.mst_RowID = puo_mst.RowID 
and sup_mst_supplier_cd = puo_mst_supplier
and puo_sts_status = puo_mst_status
and 'PNG500-P-TLT' = puo_ls1_chg_costcenter
and SatateDesc like isnull(@state ,SatateDesc)
and puo_mst_create_by in ('MMD4','MMD2','MMDEXEC1','MMDEXEC2','MMDEXEC3','MMDEXEC4','MMDEXEC5','MMDEXEC6','MMDEXEC7','MMDEXEC8','MMDEXEC10','MMDEXEC13')
and puo_sts_status like @status
and puo_mst_supplier like @Supplier
and isnull(puo_mst_po_date,@fromdate) between @fromdate and @todate
--and Convert(date,puo_mst_promised_date ) between convert(date,isnull(@deliverdate,puo_mst_promised_date)) and convert(date,isnull(@deliverdateto,puo_mst_promised_date))
order by puo_mst_po_no 
end
else if @state = '%'
begin
Insert into qms_mmd_poaging_tab_tmp (slno , [GUID] ,[PO NO.],[PO Date],[State Name],[Type Of Service],[Supplier Name],[PO Status],[Delivery Date],[Payment Terms],
[Currency Code],[Exchange Value],[Total Cost],[Total Cost in (RM)],[PR No],[Close Date],[Created By],[No of Days Aging(PO Date to Close Date)],
[No of Days Aging(PO Date to Delivery Date)],[Costcenter],rowid

,[PO Line]
,[Item Category]
,[Stock No]
,[Description]
,[Order UOM]
,[Item Cost]
,[Suggest Quantity]
,[Order Qty]
,[Received Qty]
,[RTS Qty]
,[Matched Qty]
,[Retail Price]
,[Discount %]
,[Discount Amount]
,[Net Price]
,[Extended Price]
,[Line Currency Code]--need to add in grid
,[Currency Rate]
,[Stock Location]
,[Tax Code]
,[Tax Rate]
,[Tax Value]
,[Charge Cost Center]
,[Charge Account]
,[SLA Date]
,[Require Date]
,[Department]
,[Extended Description]
,[WO No]
,[PR Line]
,[MR No]
,[Contract ID]
,[Contract Line]
,[Contract Reference]
,[Last Received Date]


)
select
ROW_NUMBER() over (Partition by puo_mst_po_no order by puo_mst_po_no ),
@guid , 
puo_mst_po_no as 'PO NO.', 
Convert(date ,puo_mst_po_date) as 'PO Date',
SatateDesc as 'State Name',
puo_ls1_chg_account  'Type Of Service',
sup_mst_desc 'Supplier Name',
puo_sts_description 'PO Status',
Convert(date ,puo_mst_promised_date ) 'Delivery Date',
isnull(puo_det_terms,puo_det_po_trailer)  'Payment Terms',
puo_mst_curr_code 'Currency Code', 
Convert(numeric(28,4) ,puo_ls1_cur_exchange_rate  ) 'Exchange Value',
(puo_ls1_ord_qty * puo_ls1_retail_price ) 'Total Cost' ,
(puo_ls1_ord_qty * (1/puo_ls1_cur_exchange_rate)*puo_ls1_retail_price) 'Total Cost in (RM)',
puo_ls1_pr_no 'PR No',
Convert(date ,puo_mst_clo_date)  'Close Date',
puo_mst_create_by 'Created By',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_clo_date),0) 'No of Days Aging(PO Date to Close Date)',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_promised_date),0) 'No of Days Aging(PO Date to Delivery Date)',
puo_ls1_chg_costcenter,puo_mst.RowID,
 puo_ls1_po_lineno 'PO Line'
,puo_ls1_item_category 'Item Category'
,puo_ls1_stockno 'Stock No'
,puo_ls1_description 'Description'
,puo_ls1_ord_uom 'Order UOM'
,puo_ls1_item_cost 'Item Cost'
,puo_ls1_suggest_qty 'Suggest Quantity'
,puo_ls1_ord_qty 'Order Qty'
,puo_ls1_rcv_qty 'Received Qty'
,puo_ls1_invoice_qty 'RTS Qty'
,puo_ls1_match_qty 'Matched Qty'
,puo_ls1_retail_price 'Retail Price'
,puo_ls1_discount_pct 'Discount %'
,puo_ls1_discount_amt 'Discount Amount'
,puo_ls1_net_price 'Net Price'
,puo_ls1_net_price 'Extended Price'
,puo_ls1_cur_code 'Line Currency Code'
,puo_ls1_cur_exchange_rate 'Currency Rate'
,puo_ls1_stk_locn 'Stock Location'
,puo_ls1_tax_code 'Tax Code'
,puo_ls1_tax_rate 'Tax Rate'
,puo_ls1_tax_value 'Tax Value'
,puo_ls1_chg_costcenter 'Charge Cost Center'
,puo_ls1_chg_account 'Charge Account'
,puo_ls1_promised_date 'SLA Date'
,puo_ls1_req_date 'Require Date'
,puo_ls1_dept 'Department'
,cast(puo_ls1_ext_description as NVARCHAR(MAX))'Extended Description'
,puo_ls1_wo_no 'WO No'
--,l1.puo_ls1_pr_no 'PR No'
,puo_ls1_pr_lineno 'PR Line'
,puo_ls1_mr_no 'MR No'
,puo_ls1_contract_id 'Contract ID'
,puo_ls1_contract_lineno 'Contract Line'
,puo_ls1_contract_ref 'Contract Reference'
,puo_ls1_clo_date 'Last Received Date'

from 
puo_mst (nolock) , 
puo_det (nolock) ,
puo_ls1 (nolock) ,
sup_mst (nolock) ,
puo_sts (nolock) ,
Report_location_mst (nolock)
where puo_mst.site_cd  =  puo_det.site_cd
and puo_det.site_cd  =  puo_ls1.site_cd
and puo_det.site_cd  =  sup_mst.site_cd
and puo_det.site_cd  =  puo_sts.site_cd
and puo_mst.RowID = puo_det.mst_RowID
and puo_ls1.mst_RowID = puo_mst.RowID 
and sup_mst_supplier_cd = puo_mst_supplier
and puo_sts_status = puo_mst_status
and (Statecode = left(puo_ls1_chg_costcenter,3) or (Statecode = substring(puo_ls1_chg_costcenter,charindex('-',puo_ls1_chg_costcenter)+1,3)))
--and SatateDesc like isnull(@state ,SatateDesc)
and puo_mst_create_by in ('MMD4','MMD2','MMDEXEC1','MMDEXEC2','MMDEXEC3','MMDEXEC4','MMDEXEC5','MMDEXEC6','MMDEXEC7','MMDEXEC8','MMDEXEC10','MMDEXEC13')
and puo_sts_status like @status
and puo_mst_supplier like @Supplier
and Convert(date,isnull(puo_mst_po_date,@fromdate)) between @fromdate and @todate
--and Convert(date,puo_mst_promised_date ) between convert(date,isnull(@deliverdate,puo_mst_promised_date)) and convert(date,isnull(@deliverdateto,puo_mst_promised_date))
--order by puo_mst_po_no 

union all

select
ROW_NUMBER() over (Partition by puo_mst_po_no order by puo_mst_po_no ),
@guid , 
puo_mst_po_no as 'PO NO.', 
Convert(date ,puo_mst_po_date) as 'PO Date',
'TTFT HQ OFFICE' as 'State Name',
puo_ls1_chg_account  'Type Of Service',
sup_mst_desc 'Supplier Name',
puo_sts_description 'PO Status',
Convert(date ,puo_mst_promised_date ) 'Delivery Date',
isnull(puo_det_terms,puo_det_po_trailer)  'Payment Terms',
puo_mst_curr_code 'Currency Code', 
Convert(numeric(28,4) ,puo_ls1_cur_exchange_rate  ) 'Exchange Value',
(puo_ls1_ord_qty * puo_ls1_retail_price ) 'Total Cost' ,
(puo_ls1_ord_qty * (1/puo_ls1_cur_exchange_rate)*puo_ls1_retail_price) 'Total Cost in (RM)',
puo_ls1_pr_no 'PR No',
Convert(date ,puo_mst_clo_date)  'Close Date',
puo_mst_create_by 'Created By',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_clo_date),0) 'No of Days Aging(PO Date to Close Date)',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_promised_date),0) 'No of Days Aging(PO Date to Delivery Date)',
puo_ls1_chg_costcenter,puo_mst.RowID
, puo_ls1_po_lineno 'PO Line'
,puo_ls1_item_category 'Item Category'
,puo_ls1_stockno 'Stock No'
,puo_ls1_description 'Description'
,puo_ls1_ord_uom 'Order UOM'
,puo_ls1_item_cost 'Item Cost'
,puo_ls1_suggest_qty 'Suggest Quantity'
,puo_ls1_ord_qty 'Order Qty'
,puo_ls1_rcv_qty 'Received Qty'
,puo_ls1_invoice_qty 'RTS Qty'
,puo_ls1_match_qty 'Matched Qty'
,puo_ls1_retail_price 'Retail Price'
,puo_ls1_discount_pct 'Discount %'
,puo_ls1_discount_amt 'Discount Amount'
,puo_ls1_net_price 'Net Price'
,puo_ls1_net_price 'Extended Price'
,puo_ls1_cur_code 'Line Currency Code'
,puo_ls1_cur_exchange_rate 'Currency Rate'
,puo_ls1_stk_locn 'Stock Location'
,puo_ls1_tax_code 'Tax Code'
,puo_ls1_tax_rate 'Tax Rate'
,puo_ls1_tax_value 'Tax Value'
,puo_ls1_chg_costcenter 'Charge Cost Center'
,puo_ls1_chg_account 'Charge Account'
,puo_ls1_promised_date 'SLA Date'
,puo_ls1_req_date 'Require Date'
,puo_ls1_dept 'Department'
,cast(puo_ls1_ext_description as NVARCHAR(MAX))'Extended Description'
,puo_ls1_wo_no 'WO No'
--,l1.puo_ls1_pr_no 'PR No'
,puo_ls1_pr_lineno 'PR Line'
,puo_ls1_mr_no 'MR No'
,puo_ls1_contract_id 'Contract ID'
,puo_ls1_contract_lineno 'Contract Line'
,puo_ls1_contract_ref 'Contract Reference'
,puo_ls1_clo_date 'Last Received Date'

from 
puo_mst (nolock) , 
puo_det (nolock) ,
puo_ls1 (nolock) ,
sup_mst (nolock) ,
puo_sts (nolock) 
where puo_mst.site_cd  =  puo_det.site_cd
and puo_det.site_cd  =  puo_ls1.site_cd
and puo_det.site_cd  =  sup_mst.site_cd
and puo_det.site_cd  =  puo_sts.site_cd
and puo_mst.RowID = puo_det.mst_RowID
and puo_ls1.mst_RowID = puo_mst.RowID 
and sup_mst_supplier_cd = puo_mst_supplier
and puo_sts_status = puo_mst_status
and puo_ls1_chg_costcenter like 'TTFT-HQ%'
and puo_mst_create_by in ('MMD4','MMD2','MMDEXEC1','MMDEXEC2','MMDEXEC3','MMDEXEC4','MMDEXEC5','MMDEXEC6','MMDEXEC7','MMDEXEC8','MMDEXEC10','MMDEXEC13')
and puo_sts_status like @status
and puo_mst_supplier like @Supplier
and Convert(date,isnull(puo_mst_po_date,@fromdate)) between @fromdate and @todate
--and Convert(date,puo_mst_promised_date ) between convert(date,isnull(@deliverdate,puo_mst_promised_date)) and convert(date,isnull(@deliverdateto,puo_mst_promised_date))
--order by puo_mst_po_no 

update qms_mmd_poaging_tab_tmp
set [State Name] = 'PULAU PINANG KOLEJ'
where [Costcenter] = 'PNG500-P-TLT' 
and GUID = @guid
end
else
begin
 
Insert into qms_mmd_poaging_tab_tmp (slno , [GUID] ,[PO NO.],[PO Date],[State Name],[Type Of Service],[Supplier Name],[PO Status],[Delivery Date],[Payment Terms],
[Currency Code],[Exchange Value],[Total Cost],[Total Cost in (RM)],[PR No],[Close Date],[Created By],[No of Days Aging(PO Date to Close Date)],
[No of Days Aging(PO Date to Delivery Date)],[Costcenter],rowid

,[PO Line]
,[Item Category]
,[Stock No]
,[Description]
,[Order UOM]
,[Item Cost]
,[Suggest Quantity]
,[Order Qty]
,[Received Qty]
,[RTS Qty]
,[Matched Qty]
,[Retail Price]
,[Discount %]
,[Discount Amount]
,[Net Price]
,[Extended Price]
,[Line Currency Code]--need to add in grid
,[Currency Rate]
,[Stock Location]
,[Tax Code]
,[Tax Rate]
,[Tax Value]
,[Charge Cost Center]
,[Charge Account]
,[SLA Date]
,[Require Date]
,[Department]
,[Extended Description]
,[WO No]
,[PR Line]
,[MR No]
,[Contract ID]
,[Contract Line]
,[Contract Reference]
,[Last Received Date]


)
select
ROW_NUMBER() over (Partition by puo_mst_po_no order by puo_mst_po_no ),
@guid , 
puo_mst_po_no as 'PO NO.', 
Convert(date ,puo_mst_po_date) as 'PO Date',
SatateDesc as 'State Name',
puo_ls1_chg_account  'Type Of Service',
sup_mst_desc 'Supplier Name',
puo_sts_description 'PO Status',
Convert(date ,puo_mst_promised_date ) 'Delivery Date',
isnull(puo_det_terms,puo_det_po_trailer)  'Payment Terms',
puo_mst_curr_code 'Currency Code', 
Convert(numeric(28,4) ,puo_ls1_cur_exchange_rate  ) 'Exchange Value',
(puo_ls1_ord_qty * puo_ls1_retail_price ) 'Total Cost' ,
(puo_ls1_ord_qty * (1/puo_ls1_cur_exchange_rate)*puo_ls1_retail_price) 'Total Cost in (RM)',
puo_ls1_pr_no 'PR No',
Convert(date ,puo_mst_clo_date)  'Close Date',
puo_mst_create_by 'Created By',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_clo_date),0) 'No of Days Aging(PO Date to Close Date)',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_promised_date),0) 'No of Days Aging(PO Date to Delivery Date)',
puo_ls1_chg_costcenter,puo_mst.RowID,
 puo_ls1_po_lineno 'PO Line'
,puo_ls1_item_category 'Item Category'
,puo_ls1_stockno 'Stock No'
,puo_ls1_description 'Description'
,puo_ls1_ord_uom 'Order UOM'
,puo_ls1_item_cost 'Item Cost'
,puo_ls1_suggest_qty 'Suggest Quantity'
,puo_ls1_ord_qty 'Order Qty'
,puo_ls1_rcv_qty 'Received Qty'
,puo_ls1_invoice_qty 'RTS Qty'
,puo_ls1_match_qty 'Matched Qty'
,puo_ls1_retail_price 'Retail Price'
,puo_ls1_discount_pct 'Discount %'
,puo_ls1_discount_amt 'Discount Amount'
,puo_ls1_net_price 'Net Price'
,puo_ls1_net_price 'Extended Price'
,puo_ls1_cur_code 'Line Currency Code'
,puo_ls1_cur_exchange_rate 'Currency Rate'
,puo_ls1_stk_locn 'Stock Location'
,puo_ls1_tax_code 'Tax Code'
,puo_ls1_tax_rate 'Tax Rate'
,puo_ls1_tax_value 'Tax Value'
,puo_ls1_chg_costcenter 'Charge Cost Center'
,puo_ls1_chg_account 'Charge Account'
,puo_ls1_promised_date 'SLA Date'
,puo_ls1_req_date 'Require Date'
,puo_ls1_dept 'Department'
,cast(puo_ls1_ext_description as NVARCHAR(MAX))'Extended Description'
,puo_ls1_wo_no 'WO No'
--,l1.puo_ls1_pr_no 'PR No'
,puo_ls1_pr_lineno 'PR Line'
,puo_ls1_mr_no 'MR No'
,puo_ls1_contract_id 'Contract ID'
,puo_ls1_contract_lineno 'Contract Line'
,puo_ls1_contract_ref 'Contract Reference'
,puo_ls1_clo_date 'Last Received Date'

from 
puo_mst (nolock) , 
puo_det (nolock) ,
puo_ls1 (nolock) ,
sup_mst (nolock) ,
puo_sts (nolock) ,
Report_location_mst (nolock)
where puo_mst.site_cd  =  puo_det.site_cd
and puo_det.site_cd  =  puo_ls1.site_cd
and puo_det.site_cd  =  sup_mst.site_cd
and puo_det.site_cd  =  puo_sts.site_cd
and puo_mst.RowID = puo_det.mst_RowID
and puo_ls1.mst_RowID = puo_mst.RowID 
and sup_mst_supplier_cd = puo_mst_supplier
and puo_sts_status = puo_mst_status
and (Statecode = left(puo_ls1_chg_costcenter,3) or (Statecode = substring(puo_ls1_chg_costcenter,charindex('-',puo_ls1_chg_costcenter)+1,3)))
and SatateDesc like isnull(@state ,SatateDesc)
and puo_mst_create_by in ('MMD4','MMD2','MMDEXEC1','MMDEXEC2','MMDEXEC3','MMDEXEC4','MMDEXEC5','MMDEXEC6','MMDEXEC7','MMDEXEC8','MMDEXEC10','MMDEXEC13')
and puo_sts_status like @status
and puo_mst_supplier like @Supplier
and Convert(date,isnull(puo_mst_po_date,@fromdate)) between @fromdate and @todate
--and Convert(date,puo_mst_promised_date ) between convert(date,isnull(@deliverdate,puo_mst_promised_date)) and convert(date,isnull(@deliverdateto,puo_mst_promised_date))
--order by puo_mst_po_no 

union all

select
ROW_NUMBER() over (Partition by puo_mst_po_no order by puo_mst_po_no ),
@guid , 
puo_mst_po_no as 'PO NO.', 
Convert(date ,puo_mst_po_date) as 'PO Date',
'TTFT HQ OFFICE' as 'State Name',
puo_ls1_chg_account  'Type Of Service',
sup_mst_desc 'Supplier Name',
puo_sts_description 'PO Status',
Convert(date ,puo_mst_promised_date ) 'Delivery Date',
isnull(puo_det_terms,puo_det_po_trailer)  'Payment Terms',
puo_mst_curr_code 'Currency Code', 
Convert(numeric(28,4) ,puo_ls1_cur_exchange_rate  ) 'Exchange Value',
(puo_ls1_ord_qty * puo_ls1_retail_price ) 'Total Cost' ,
(puo_ls1_ord_qty * (1/puo_ls1_cur_exchange_rate)*puo_ls1_retail_price) 'Total Cost in (RM)',
puo_ls1_pr_no 'PR No',
Convert(date ,puo_mst_clo_date)  'Close Date',
puo_mst_create_by 'Created By',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_clo_date),0) 'No of Days Aging(PO Date to Close Date)',
isnull(Datediff(dd,puo_mst_po_date,puo_mst_promised_date),0) 'No of Days Aging(PO Date to Delivery Date)',
puo_ls1_chg_costcenter,puo_mst.RowID,
 puo_ls1_po_lineno 'PO Line'
,puo_ls1_item_category 'Item Category'
,puo_ls1_stockno 'Stock No'
,puo_ls1_description 'Description'
,puo_ls1_ord_uom 'Order UOM'
,puo_ls1_item_cost 'Item Cost'
,puo_ls1_suggest_qty 'Suggest Quantity'
,puo_ls1_ord_qty 'Order Qty'
,puo_ls1_rcv_qty 'Received Qty'
,puo_ls1_invoice_qty 'RTS Qty'
,puo_ls1_match_qty 'Matched Qty'
,puo_ls1_retail_price 'Retail Price'
,puo_ls1_discount_pct 'Discount %'
,puo_ls1_discount_amt 'Discount Amount'
,puo_ls1_net_price 'Net Price'
,puo_ls1_net_price 'Extended Price'
,puo_ls1_cur_code 'Line Currency Code'
,puo_ls1_cur_exchange_rate 'Currency Rate'
,puo_ls1_stk_locn 'Stock Location'
,puo_ls1_tax_code 'Tax Code'
,puo_ls1_tax_rate 'Tax Rate'
,puo_ls1_tax_value 'Tax Value'
,puo_ls1_chg_costcenter 'Charge Cost Center'
,puo_ls1_chg_account 'Charge Account'
,puo_ls1_promised_date 'SLA Date'
,puo_ls1_req_date 'Require Date'
,puo_ls1_dept 'Department'
,cast(puo_ls1_ext_description as NVARCHAR(MAX))'Extended Description'
,puo_ls1_wo_no 'WO No'
--,l1.puo_ls1_pr_no 'PR No'
,puo_ls1_pr_lineno 'PR Line'
,puo_ls1_mr_no 'MR No'
,puo_ls1_contract_id 'Contract ID'
,puo_ls1_contract_lineno 'Contract Line'
,puo_ls1_contract_ref 'Contract Reference'
,puo_ls1_clo_date 'Last Received Date'

from 
puo_mst (nolock) , 
puo_det (nolock) ,
puo_ls1 (nolock) ,
sup_mst (nolock) ,
puo_sts (nolock) 
where puo_mst.site_cd  =  puo_det.site_cd
and puo_det.site_cd  =  puo_ls1.site_cd
and puo_det.site_cd  =  sup_mst.site_cd
and puo_det.site_cd  =  puo_sts.site_cd
and puo_mst.RowID = puo_det.mst_RowID
and puo_ls1.mst_RowID = puo_mst.RowID 
and sup_mst_supplier_cd = puo_mst_supplier
and puo_sts_status = puo_mst_status
and puo_ls1_chg_costcenter like 'TTFT-HQ%'
and puo_mst_create_by in ('MMD4','MMD2','MMDEXEC1','MMDEXEC2','MMDEXEC3','MMDEXEC4','MMDEXEC5','MMDEXEC6','MMDEXEC7','MMDEXEC8','MMDEXEC10','MMDEXEC13')
and puo_sts_status like @status
and puo_mst_supplier like @Supplier
and Convert(date,isnull(puo_mst_po_date,@fromdate)) between @fromdate and @todate
--and Convert(date,puo_mst_promised_date ) between convert(date,isnull(@deliverdate,puo_mst_promised_date)) and convert(date,isnull(@deliverdateto,puo_mst_promised_date))
--order by puo_mst_po_no 

update qms_mmd_poaging_tab_tmp
set [State Name] = 'PULAU PINANG KOLEJ'
where [Costcenter] = 'PNG500-P-TLT' 
and GUID = @guid

end

update qms_mmd_poaging_tab_tmp
set [Type Of Service] = descs
from 
	qms_mmd_poaging_tab_tmp (nolock),
	cf_account (nolock)
where account = [Type Of Service]
and GUID = @guid

--drop table test123
--select * into  #temp from (
--Select distinct 
--[PO NO.],[PO Date],[State Name],[Type Of Service],[Supplier Name],[PO Status],[Delivery Date],[Payment Terms],
--[Currency Code],[Exchange Value],[Total Cost],[Total Cost in (RM)],[PR No],[Close Date],[Created By],[No of Days Aging(PO Date to Close Date)]
--,[No of Days Aging(PO Date to Delivery Date)],rowid
----into test123
--from qms_mmd_poaging_tab_tmp (nolock) t
----on t.rowid = l1.mst_rowid
--where GUID = @guid
--and Convert(date,[Delivery Date]) between convert(date,isnull(@deliverdate,[Delivery Date])) and convert(date,isnull(@deliverdateto,[Delivery Date]))
----order by [PO NO.]--,l1.puo_ls1_po_lineno

--) a

--SELECT * from test123

SELECT distinct
[PO NO.],[PO Date],[State Name],[Type Of Service],[Supplier Name],[PO Status],[Delivery Date],[Payment Terms],
[Currency Code],[Exchange Value],[Total Cost],[Total Cost in (RM)],[PR No],[Close Date],[Created By],[No of Days Aging(PO Date to Close Date)]
,[No of Days Aging(PO Date to Delivery Date)]
,rowid
,[PO Line]
,[Item Category]
,[Stock No]
,[Description]
,[Order UOM]
,[Item Cost]
,[Suggest Quantity]
,[Order Qty]
,[Received Qty]
,[RTS Qty]
,[Matched Qty]
,[Retail Price]
,[Discount %]
,[Discount Amount]
,[Net Price]
,[Extended Price]
,[Line Currency Code]--need to add in grid
,[Currency Rate]
,[Stock Location]
,[Tax Code]
,[Tax Rate]
,[Tax Value]
,[Charge Cost Center]
,[Charge Account]
,[SLA Date]
,[Require Date]
,[Department]
,[Extended Description]
,[WO No]
,[PR Line]
,[MR No]
,[Contract ID]
,[Contract Line]
,[Contract Reference]
,[Last Received Date]


from qms_mmd_poaging_tab_tmp (NOLOCK)
where GUID = @guid
and Convert(date,[Delivery Date]) between convert(date,isnull(@deliverdate,[Delivery Date])) and convert(date,isnull(@deliverdateto,[Delivery Date]))


Delete from qms_mmd_poaging_tab_tmp
where GUID = @guid
end
--select * into qms_mmd_poaging_tab_tmp from 
--drop table qms_mmd_poaging_tab_tmp1

--Alter table qms_mmd_poaging_tab_tmp
--add [Costcenter]  varchar(100)

--SELECT * into qms_mmd_poaging_tab_tmp_tmp from qms_mmd_poaging_tab_tmp where 1=2
--SELECT * from qms_mmd_poaging_tab_tmp where [PO NO.] = 'PO115214'



