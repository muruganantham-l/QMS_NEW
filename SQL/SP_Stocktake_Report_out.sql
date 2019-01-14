--Exec SP_Stocktake_Report_out 'HQ','2018-03-01','2018-03-31'


ALTER Procedure SP_Stocktake_Report_out
@state varchar(200) = 'hq',
@startdate_temp varchar(20) = null ,
@currdate_temp varchar(20) = null-- WITH ENCRYPTION
as 
begin

Declare @startdate varchar(10)
Declare @currdate  varchar(10) 
DECLARE @GUID varchar(100)
--select @state 'state',@startdate_temp 'startdate_temp',@currdate_temp 'currdate_temp' into temp
--drop table temp

SELECT @GUID = NEWID()

if isnull(@startdate_temp,'') in ('') 
	begin 
		select  @startdate = convert(varchar(10),getdate(),112)
	end
else
	begin
		select  @startdate = convert(varchar(10),@startdate_temp,112)
	end

if isnull(@currdate_temp,'') in ('') 
	begin 
		select  @currdate = convert(varchar(10),getdate(),112)
	end
else
	begin
		select  @currdate = convert(varchar(10),@currdate_temp,112)
	end
--select @currdate = Getdate()

--Alter table Stocktake_Report_tab
--alter column [Remarks] varchar(MAX)
--select  @startdate1 = convert(varchar(10),@startdate,112)
--select  @currdate1 = convert(varchar(10),@currdate,112)

INSERT INTO Stocktake_Report_tab (
[GUID]
,[Num]
,[START MONTH]
,[END MONTH]
,[STATE NAME]
,[STORE LOC]
,[ITEM CODE]
,[ITEM DESC]
,[UOM]
,[Unit Price (RM)]
,[Open Bal Qty]
,[Open Bal Value (RM)]
,[GRN Qty]
,[GRN Value (RM)]
,[ISU Qty]
,[ISU Value (RM)]
,[TRF Qty]
,[TRF Value (RM)]
,[RET Qty]
,[RET Value (RM)]
,[RTS Qty]
,[RTS Value (RM)]
,[ADJ Qty]
,[ADJ Value]
,[Closing Bal Qty]
,[Closing Bal Value (RM)]
,[Remarks]
,[ITEM Extended Description]
,[CAMMS Qty]
,[CAMMS ITL Qty]
,[PO Out (Due In Qty)]
)

SELECT 	
@GUID
,ROW_NUMBER () over( order by itm_mst_stockno ) 'NUM'
,@startdate
,@currdate
,SatateDesc 'STATE NAME'
,trx.itm_trx_stk_locn 'STORE LOC'
,itm_mst_stockno 'ITEM CODE'
,itm_mst_desc 'ITEM DESC'
,itm_mst_issue_uom 'UOM'
,itm_mst_issue_price as 'Unit Price'
,0 'Open Bal Qty'
,0 'Open Bal Value'
,((SELECT COALESCE(SUM(itm_trx.itm_trx_cnv_qty), 0) 	
							FROM itm_trx (nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT41' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							+
(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_to_stk_locn= trx.itm_trx_stk_locn
							AND	convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ))							'GRN Qty'
,0 'GRN Value'
,(SELECT COALESCE(SUM(itm_trx.itm_trx_isu_qty), 0) 	
							FROM itm_trx 	(nolock)	
							WHERE itm_trx.itm_trx_trx_type IN ( 'MT21', 'MT22' ) 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )'ISU Qty'
,0 'ISU Value'
,(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	 convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And  convert(date,itm_trx.itm_trx_trx_date) <= @currdate )  'TRF Qty'
,0 'TRF Value'
,(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx 	(nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT51' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	 convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And  convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 'RET Qty'
,0 'RET Value'
,(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx 	(nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT52' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	 convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And  convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 'RTS Qty'
,0 'RTS Value'
,(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx (nolock)	
							WHERE itm_trx.itm_trx_trx_type = 'MT71' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND	 convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
							And  convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 'ADJ Qty'
,0 'ADJ Value'
,0 'Closing Bal Qty'
,0 'Closing Bal Value'
,itm_mst_ext_desc 'Remarks'
,itm_mst_ext_desc 'ITEM Extended Description'
/*
,((SELECT COALESCE(SUM(itm_trx.itm_trx_cnv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT41' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'STOCK'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							+ 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'STOCK'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_to_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )
							- 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_isu_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type IN ( 'MT21', 'MT22' ) 	
							AND itm_trx.site_cd = itm_mst.site_cd 	 
							and loc_mst_storage_type = 'STOCK'	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
						 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )
							-
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'STOCK'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							+ 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx (nolock),
							loc_mst (Nolock) 	
							WHERE itm_trx.itm_trx_trx_type = 'MT51' 	
							AND itm_trx.site_cd = itm_mst.site_cd 
							and loc_mst_storage_type = 'STOCK'	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							- 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT52' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							and loc_mst_storage_type = 'STOCK'
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= trx.itm_trx_stk_locn
							AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							 
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )) 'CAMMS Qty'

,((SELECT COALESCE(SUM(itm_trx.itm_trx_cnv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT41' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'IN-TRANSIT'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							+ 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'IN-TRANSIT'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_to_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )
							- 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_isu_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type IN ( 'MT21', 'MT22' ) 	
							AND itm_trx.site_cd = itm_mst.site_cd 	 
							and loc_mst_storage_type = 'IN-TRANSIT'	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn= loc_mst_stk_loc
							--trx.itm_trx_stk_locn
							--AND trx.itm_trx_stk_locn = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )
							-
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT61' 	
							AND itm_trx.site_cd = itm_mst.site_cd  
							and loc_mst_storage_type = 'IN-TRANSIT'		
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn=  loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							+ 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx (nolock),
							loc_mst (Nolock) 	
							WHERE itm_trx.itm_trx_trx_type = 'MT51' 	
							AND itm_trx.site_cd = itm_mst.site_cd 
							and loc_mst_storage_type = 'IN-TRANSIT'	
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn =  loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate ) 
							- 
							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
							FROM itm_trx 	(nolock),
							loc_mst (Nolock) 
							WHERE itm_trx.itm_trx_trx_type = 'MT52' 	
							AND itm_trx.site_cd = itm_mst.site_cd 	
							and loc_mst_storage_type = 'IN-TRANSIT'
							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
							AND itm_trx.itm_trx_stk_locn=  loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd
							And convert(date,itm_trx.itm_trx_trx_date) <= @currdate )) 'CAMMS ITL Qty'

							*/
,(SELECT COALESCE(SUM(itm_loc.itm_loc_oh_qty), 0) 	
							from itm_loc (nolock),
							loc_mst (Nolock) 
							--,itm_mst (NOLOCK) i	
							where itm_loc.mst_rowid = itm_mst.rowid
							and  itm_loc.site_cd = loc_mst.site_cd 
							and itm_loc.site_cd = itm_mst.site_cd 
							and loc_mst_storage_type = 'STOCK'
							and itm_loc_stk_loc = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd	 
							--added by murugan
							--and i.rowid =itm_loc.mst_rowid
							--and i.itm_mst_stockno=trx.itm_trx_stockno
							) 'CAMMS Qty'
,(SELECT COALESCE(SUM(itm_loc.itm_loc_oh_qty), 0) 	
							from itm_loc (nolock),
							loc_mst (Nolock) 	
							where itm_loc.mst_rowid = itm_mst.rowid
							and  itm_loc.site_cd = loc_mst.site_cd 
							and itm_loc.site_cd = itm_mst.site_cd 
							and loc_mst_storage_type = 'IN-TRANSIT'
							and itm_loc_stk_loc = loc_mst_stk_loc
							and loc_mst.loc_mst_mst_loc_cd = trx.loc_mst_mst_loc_cd	
							 ) 'CAMMS ITL Qty'
,(SELECT COALESCE(SUM(puo_ls1.puo_ls1_ord_qty), 0) 	
	from puo_mst (nolock),
			puo_ls1 (nolock)
WHERE 	puo_mst.site_cd = puo_ls1.site_cd
AND 		puo_mst.RowID = puo_ls1.mst_RowID
AND		puo_mst.puo_mst_clo_date IS NULL
AND		( puo_ls1.puo_ls1_ord_qty + puo_ls1.puo_ls1_invoice_qty ) > puo_ls1.puo_ls1_rcv_qty
AND 		puo_mst.site_cd = itm_mst.site_cd
AND 		puo_ls1.puo_ls1_stockno = itm_trx_stockno
and			puo_ls1.puo_ls1_stk_locn = trx.itm_trx_stk_locn ) 'PO Out (Due In Qty)'
--, 
--itm_mst_stockno 'Item Code' , 	
--itm_mst_com_code, 	
--itm_mst_costcenter, 	
--itm_mst_account, 	
--itm_mst_desc 'Item Desc', 
--itm_mst_issue_uom 'UOM'	, 	
--itm_mst_mstr_locn, 	
--Opening_Balance = 	( (SELECT COALESCE(SUM(itm_trx.itm_trx_cnv_qty), 0) 	
--							FROM itm_trx (nolock)	
--							WHERE itm_trx.itm_trx_trx_type = 'MT41' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno =  itm_mst.itm_mst_stockno 	
--							--AND itm_trx.itm_trx_trx_type = trx.itm_trx_trx_type
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn
--							AND	itm_trx.itm_trx_curr_date < @startdate
--							)- 	
--							(SELECT COALESCE(SUM(itm_trx.itm_trx_isu_qty), 0) 	
--							FROM itm_trx (nolock)		
--							WHERE itm_trx.itm_trx_trx_type IN ( 'MT21', 'MT22' ) 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno  	
--							--AND itm_trx.itm_trx_trx_type = trx.itm_trx_trx_type
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn
--							AND	itm_trx.itm_trx_curr_date < @startdate
--							)  	
--							+ 	
--							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
--							FROM itm_trx 	(nolock)	
--							WHERE itm_trx.itm_trx_trx_type = 'MT51' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno
--							--AND itm_trx.itm_trx_trx_type = trx.itm_trx_trx_type
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno 
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn	
--							AND	itm_trx.itm_trx_curr_date < @startdate
--							) 	
--							- 	
--							(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
--							FROM itm_trx (nolock)		
--							WHERE itm_trx.itm_trx_trx_type = 'MT52' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
--							--AND itm_trx.itm_trx_trx_type = trx.itm_trx_trx_type
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn	
--							AND	itm_trx.itm_trx_curr_date < @startdate
--						 ) 	
--							+ 	
--							(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
--							FROM itm_trx 	(nolock)	
--							WHERE itm_trx.itm_trx_trx_type = 'MT71' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--							--AND itm_trx.itm_trx_trx_type = trx.itm_trx_trx_type
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn
--							AND	itm_trx.itm_trx_curr_date < @startdate
--							) ) , 		

--Opening_Cost = 	CASE itm_det_cr_code 
--					WHEN 'FIFO' 
--						THEN 	COALESCE((SELECT TOP 1 itm_trx.itm_trx_fifo_avg_cost 	
--								FROM itm_trx 	
--								WHERE itm_trx.site_cd = itm_mst.site_cd 	
--								AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--								AND	itm_trx.itm_trx_curr_date < @startdate	
--								ORDER BY itm_trx.itm_trx_curr_date DESC, itm_trx.audit_date DESC ), 0) 	
--						ELSE COALESCE((SELECT TOP 1 itm_trx.itm_trx_avg_cost 
--								FROM itm_trx 	
--								WHERE itm_trx.itm_trx_trx_type IN ( 'MT41' ) 	
--								AND itm_trx.site_cd = itm_mst.site_cd 	
--								AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--								AND	itm_trx.itm_trx_curr_date < @startdate	
--								ORDER BY itm_trx.itm_trx_curr_date DESC, itm_trx.audit_date DESC ), 0) END, 		
--Closing_Cost = 	CASE itm_det_cr_code 
--					WHEN 'FIFO' 
--						THEN 	COALESCE((SELECT TOP 1 itm_trx.itm_trx_fifo_avg_cost 	
--								FROM itm_trx 	
--								WHERE itm_trx.site_cd = itm_mst.site_cd 	
--								AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--								AND	itm_trx.itm_trx_curr_date < @currdate 	
--								ORDER BY itm_trx.itm_trx_curr_date DESC, itm_trx.audit_date DESC ), 0) 	
--						ELSE COALESCE((SELECT TOP 1 itm_trx.itm_trx_avg_cost 	
--								FROM itm_trx 	
--								WHERE itm_trx.itm_trx_trx_type IN ( 'MT41' ) 	
--								AND itm_trx.site_cd = itm_mst.site_cd 	
--								AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--								AND	itm_trx.itm_trx_curr_date < @currdate 	
--								ORDER BY itm_trx.itm_trx_curr_date DESC, itm_trx.audit_date DESC ), 0)END, 		
--Received_Qty = 	(SELECT COALESCE(SUM(itm_trx.itm_trx_cnv_qty), 0) 	
--							FROM itm_trx 	
--							WHERE itm_trx.itm_trx_trx_type = 'MT41' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn	
--							AND	itm_trx.itm_trx_curr_date >= @startdate 
--							And itm_trx.itm_trx_curr_date < @currdate ), 			
--Issue_Qty = 	(SELECT COALESCE(SUM(itm_trx.itm_trx_isu_qty), 0) 	
--							FROM itm_trx 	
--							WHERE itm_trx.itm_trx_trx_type IN ( 'MT21', 'MT22' ) 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn 	
--							AND	itm_trx.itm_trx_curr_date >= @startdate 
--							And itm_trx.itm_trx_curr_date < @currdate ), 			
--Return_Stock_Qty = 	(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
--							FROM itm_trx 	
--							WHERE itm_trx.itm_trx_trx_type = 'MT51' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn
--							AND	itm_trx.itm_trx_curr_date >= @startdate 
--							And itm_trx.itm_trx_curr_date < @currdate ), 		
--Return_Supplier_Qty = 	(SELECT COALESCE(SUM(itm_trx.itm_trx_rtn_qty), 0) 	
--							FROM itm_trx 	
--							WHERE itm_trx.itm_trx_trx_type = 'MT52' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn	
--							AND	itm_trx.itm_trx_curr_date >= @startdate 
--							And itm_trx.itm_trx_curr_date < @currdate ), 		
--Adjustment_Qty = 	(SELECT COALESCE(SUM(itm_trx.itm_trx_rcv_qty), 0) 	
--							FROM itm_trx 	
--							WHERE itm_trx.itm_trx_trx_type = 'MT71' 	
--							AND itm_trx.site_cd = itm_mst.site_cd 	
--							AND itm_trx.itm_trx_stockno = itm_mst.itm_mst_stockno 	
--							AND itm_trx.itm_trx_stockno = trx.itm_trx_stockno
--							AND itm_trx.itm_trx_stk_locn = trx.itm_trx_stk_locn
--							AND	itm_trx.itm_trx_curr_date >= @startdate 
--							And itm_trx.itm_trx_curr_date < @currdate )

FROM 	
itm_mst (nolock), 
itm_det (nolock),
Stock_location_mst (nolock),
(select distinct itm_trx.site_cd,loc_mst_mst_loc_cd , itm_trx_stk_locn, itm_trx_stockno 
	from itm_trx  (nolock) ,
		loc_mst (nolock)
where  itm_trx.site_cd = loc_mst.site_cd
  and  loc_mst_storage_type = 'STOCK'
  and  itm_trx_stk_locn = loc_mst_stk_loc
  AND   convert(date,itm_trx_trx_date) <= @currdate
   
  --and  itm_trx_stockno = 'STK102575'
  union 
  select distinct itm_mst.site_cd,loc_mst_mst_loc_cd , itm_mst_mstr_locn, itm_mst_stockno 
	from itm_mst  (nolock) ,
		loc_mst (nolock)
where  itm_mst.site_cd = loc_mst.site_cd
  and  loc_mst_storage_type = 'STOCK'
  and  itm_mst_mstr_locn = loc_mst_stk_loc
   
  --AND  itm_trx_curr_date < @currdate
  union
  select distinct itm_mst.site_cd,loc_mst_mst_loc_cd , itm_loc_stk_loc, itm_mst_stockno 
	from	itm_mst  (nolock) ,
		loc_mst (nolock),
		itm_loc (nolock)
	where  itm_mst.site_cd = loc_mst.site_cd
	and   itm_loc.site_cd = loc_mst.site_cd
	and  itm_mst.rowid = itm_loc.mst_RowID
	and  loc_mst_storage_type = 'STOCK'
    and  itm_loc_stk_loc = loc_mst_stk_loc	
	 

  ) trx 
WHERE (	itm_mst.site_cd = itm_det.site_cd 	
AND 		itm_mst.rowid = itm_det.mst_rowid 	
AND 		convert(date,itm_mst.itm_mst_create_date) <= @currdate
AND			itm_mst.site_cd = trx.site_cd 	
AND 		itm_mst_stockno = itm_trx_stockno	  ) 
AND  itm_mst.site_cd  = 'QMS'
and loc_mst_mst_loc_cd = Statecode
and loc_mst_mst_loc_cd = @state
order by itm_mst_stockno,trx.itm_trx_stk_locn ,SatateDesc asc

update tab
set [Open Bal Qty] = OpenBalQty,
	[Open Bal Value (RM)] = isnull(freetext1,0.0)
from Stocktake_Report_tab tab (nolock),
	Stock_take_open_balance_tab bal (nolock)
where GUID = @GUID
and [STATE NAME] = STATENAME
and [STORE LOC] = STORELOC
and [ITEM CODE] = ITEMCODE
and dateadd(dd,-1,[START MONTH]) = [Date]

/*Update Based on the conversation with Mukhriz*/

update tab
set [Open Bal Value (RM)] = [Open Bal Qty] * [Unit Price (RM)]
from Stocktake_Report_tab tab (nolock),
	Stock_take_open_balance_tab bal (nolock)
where GUID = @GUID
and [STATE NAME] = STATENAME
and [STORE LOC] = STORELOC
and [ITEM CODE] = ITEMCODE
and dateadd(dd,-1,[START MONTH]) = [Date]
and [Open Bal Qty] <> 0
and [Open Bal Value (RM)] = 0.00

/*Update Based on the conversation with Mukhriz*/

Update Stocktake_Report_tab
set 
--[Open Bal Value (RM)] = [Unit Price (RM)] * [Open Bal Qty]
--,
[GRN Value (RM)] = [Unit Price (RM)] * [GRN Qty]
,[ISU Value (RM)] = [Unit Price (RM)] * [ISU Qty] 
,[TRF Value (RM)] = [Unit Price (RM)] * [TRF Qty] 
,[RET Value (RM)] = [Unit Price (RM)] * [RET Qty] 
,[RTS Value (RM)] = [Unit Price (RM)] * [RTS Qty]
,[ADJ Value]	  = [Unit Price (RM)] * [ADJ Qty] 
WHERE GUID = @GUID


Update Stocktake_Report_tab
set [Closing Bal Qty] = [Open Bal Qty]+[GRN Qty]-[ISU Qty] -[TRF Qty]+[RET Qty]-[RTS Qty]
WHERE GUID = @GUID

Update Stocktake_Report_tab
set [Closing Bal Value (RM)] = [Open Bal Value (RM)] + ([Unit Price (RM)] * ([GRN Qty]-[ISU Qty] -[TRF Qty]+[RET Qty]-[RTS Qty]))
WHERE GUID = @GUID

Update Stocktake_Report_tab
set [Closing Bal Value (RM)] =([Unit Price (RM)] * [Closing Bal Qty])
WHERE GUID = @GUID
and [Closing Bal Qty] > 0
and [Closing Bal Value (RM)] = 0

Select @state = SatateDesc
 from  Stock_location_mst (nolock)
where Statecode = @state


Delete from Stock_take_open_balance_tab
where [Date] = @currdate
and [STATENAME] = @state
and @currdate <> '2016-12-31'


insert into Stock_take_open_balance_tab (STORELOC,ITEMCODE,STATENAME,Month,year,Date,OpenBalQty , freetext1) 
select [STORE LOC] ,[ITEM CODE] ,[STATE NAME] , month([END MONTH] ), Year([END MONTH] ),[END MONTH], [Closing Bal Qty] ,[Closing Bal Value (RM)]
from Stocktake_Report_tab  (nolock)
WHERE GUID = @GUID
--and [Closing Bal Qty] <> 0 

Delete from Stocktake_Report_tab
WHERE GUID = @GUID
and [Open Bal Qty] = 0.00
and [GRN Qty] =  0.0000 
and [ISU Qty] = 0.0000 
and [TRF Qty] = 0.0000 
and [RET Qty] = 0.0000 
and [RTS Qty] = 0.0000 
and [ADJ Qty] = 0.0000
and [Closing Bal Qty] = 0.000
and [CAMMS Qty] = 0.000
and [CAMMS ITL Qty] = 0.0000
and [PO Out (Due In Qty)] = 0.0000

select Distinct
[Num]					'Num'
,[STATE NAME]			'STATE NAME'
,[STORE LOC]			'STORE LOC'
,[ITEM CODE]			'ITEM CODE'
,[ITEM DESC]			'ITEM DESC'
,[ITEM Extended Description] 'ITEM Extended Description'
,[UOM]					'UOM'
,[Unit Price (RM)]       'Unit Price'
,[Open Bal Qty]			'Open Bal Qty'
,[Open Bal Value (RM)]       'Open Bal Value'
,[GRN Qty]				'GRN Qty'
,[GRN Value (RM)]       'GRN Value'
,[ISU Qty]				'ISU Qty'
,[ISU Value (RM)]       'ISU Value'
,[TRF Qty]				'TRF Qty'
,[TRF Value (RM)]       'TRF Value'
,[RET Qty]				'RET Qty'
,[RET Value (RM)]       'RET Value'
,[RTS Qty]				'RTS Qty'
,[RTS Value (RM)]       'RTS Value'
,[ADJ Qty]				'ADJ Qty'
,[ADJ Value]			'ADJ Value'
,[Closing Bal Qty]       'Closing Bal Qty'
,[Closing Bal Value (RM)]      'Closing Bal Value'
,[CAMMS Qty] 'CAMMS Qty'
,[CAMMS ITL Qty] 'CAMMS ITL Qty'
,[PO Out (Due In Qty)] 'PO Out (Due In Qty)'
,[Remarks]       'Remarks'

from
Stocktake_Report_tab (nolock)
WHERE GUID = @GUID
and ([Open Bal Qty] <> 0 or [GRN Qty]<> 0.0000 or [ISU Qty] <> 0.0000 or [TRF Qty] <> 0.0000 or [RET Qty] <> 0.0000 or [RTS Qty] <> 0.0000 or [ADJ Qty] <> 0.0000 or [Closing Bal Qty] <> 0.000
or [CAMMS Qty] <> 0.00 or  [CAMMS ITL Qty] = 0.0000 or [PO Out (Due In Qty)] = 0.0000)
--murugan test
--and [ITEM CODE] in ('STK104051','STK104046')
order by NUM

Delete from Stocktake_Report_tab 
WHERE GUID = @GUID

End

--itm_trx where itm_trx_stockno ='STK101830' and itm_trx_doc_no like 'RCV%'
--itm_trx where itm_trx_stockno ='STK101830' and itm_trx_doc_no like 'ISU%'
--itm_trx where itm_trx_stockno ='STK101830' and itm_trx_doc_no like 'TRF%'

--itm
--RCV100269
--and itm_trx_stk_locn = 'WKL-001-0001'

--Alter table Stocktake_Report_tab
--Add [ITEM Extended Description] varchar(500)
--Alter table Stocktake_Report_tab
--Add [CAMMS Qty] numeric(28,4)
--Alter table Stocktake_Report_tab
--Add [CAMMS ITL Qty] numeric(28,4)
--Alter table Stocktake_Report_tab
--Add [PO Out (Due In Qty)] numeric(28,4)
--Alter table Stocktake_Report_tab
--Add [Variance Qty] numeric(28,4)
--Alter table Stocktake_Report_tab
--Add [Variance Value (RM)] numeric(28,4)
	
	










