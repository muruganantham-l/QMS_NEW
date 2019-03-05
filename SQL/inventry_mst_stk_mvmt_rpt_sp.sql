alter proc inventry_mst_stk_mvmt_rpt_sp
@stock_no varchar(50)  = 'STK100001'
,@startdate date = '1990-01-01'
,@enddate date ='2019-03-04'
as
begin
set nocount ON

truncate table inventry_mst_stk_mvmt_rpt_tbl

 
IF OBJECT_ID('tempdb..#temp1') IS NOT NULL DROP TABLE #temp1
IF OBJECT_ID('tempdb..#temp2') IS NOT NULL DROP TABLE #temp2
IF OBJECT_ID('tempdb..#temp3') IS NOT NULL DROP TABLE #temp3
IF OBJECT_ID('tempdb..#temp4') IS NOT NULL DROP TABLE #temp4
IF OBJECT_ID('tempdb..#temp5') IS NOT NULL DROP TABLE #temp5
 

SELECT itm_mst_stockno			'Item code'
		,itm_mst_desc			'Description'
		,m.itm_mst_mstr_locn	'Stock Location'
into   #temp1
from   itm_mst m (NOLOCK)
where  m.itm_mst_stockno = @stock_no
 

SELECT    t.*,
         itm_trx.itm_trx_trx_date 'Rcv Transaction date',    
         itm_trx.itm_trx_pono 'Rec PO no', 
		  itm_trx.itm_trx_stk_locn 'Rcv Stock location',   
		  itm_trx_cnv_qty 'Received Qty'
		 
into #temp2
FROM itm_trx
right join #temp1 t on t.[Item code] = itm_trx_stockno
and 	( itm_trx_trx_type = 'MT41' )
AND		( itm_trx.site_cd = 'qms') 
and convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
And  convert(date,itm_trx.itm_trx_trx_date) <= @enddate 
 

 
 SELECT    T.*,
         itm_trx.itm_trx_trx_date 'Ret Transaction date',   
        
         itm_trx.itm_trx_wo 'CWO no',  
         itm_trx.itm_trx_stk_locn 'Ret Stock location',   
		 itm_trx_rtn_qty 'Ret Qty'
		into #temp3  
    FROM itm_trx
	
right join #temp2 t on t.[Item code] = itm_trx_stockno
and 	( itm_trx_trx_type = 'MT52' )
AND		( itm_trx.site_cd = 'QMS' )
AND		( itm_trx.itm_trx_stockno = t.[Item code] ) 
 and convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
And  convert(date,itm_trx.itm_trx_trx_date) <= @enddate 


 SELECT    T.*,
         itm_trx.itm_trx_trx_date 'Ret Sup Transaction date',   
         itm_trx_pono 'Ret Sup PO no',
         itm_trx.itm_trx_stk_locn 'Ret Sup Stock location',  
           
		 itm_trx_rtn_qty 'Ret Sup Qty'
		into #temp4  
    FROM itm_trx
	
right join #temp3 t on t.[Item code] = itm_trx_stockno
and 	( itm_trx_trx_type = 'MT52' )
AND		( itm_trx.site_cd = 'QMS' )
AND		( itm_trx.itm_trx_stockno = t.[Item code] ) 
 and convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
And  convert(date,itm_trx.itm_trx_trx_date) <= @enddate 
 

 
 SELECT    T.*,
         itm_trx.itm_trx_trx_date 'Trf Transaction date',   
         itm_trx_stk_locn 'Trf Stock location',
         itm_trx.itm_trx_to_stk_locn 'To stock location',  
           
		 itm_trx_rcv_qty 'Trf Qty'
		into #temp5  
    FROM itm_trx
	
right join #temp4 t on t.[Item code] = itm_trx_stockno
and 	( itm_trx_trx_type = 'MT61' )
AND		( itm_trx.site_cd = 'QMS' )
AND		( itm_trx.itm_trx_stockno = t.[Item code] ) 
and convert(date,itm_trx.itm_trx_trx_date) >= @startdate 
And  convert(date,itm_trx.itm_trx_trx_date) <= @enddate 

insert inventry_mst_stk_mvmt_rpt_tbl
SELECT * FROM #temp5
 
  

select 

 [Item code]
,[Description]
,[Stock Location]
,format(cast([Rcv Transaction date] as datetime),'dd/MM/yyyy') [Rcv Transaction date]
,[Rec PO no]
,[Rcv Stock location]
,cast([Received Qty] as decimal(20,2)) [Received Qty]
,format(cast([Ret Transaction date]  as datetime),'dd/MM/yyyy')	[Ret Transaction date]
,[CWO no]
,[Ret Stock location]
,cast([Ret Qty] as decimal(20,2)) [Ret Qty]
,format(cast([Ret Sup Transaction date] as datetime),'dd/MM/yyyy')	[Ret Sup Transaction date]
,[Ret Sup PO no]
,[Ret Sup Stock location]
,cast([Ret Sup Qty] as decimal(20,2)) [Ret Sup Qty]
,format(cast([Trf Transaction date]  as datetime),'dd/MM/yyyy') 	[Trf Transaction date]
,[Trf Stock location]
,[To stock location]
,cast([Trf Qty] as decimal(20,2)) [Trf Qty] 



from inventry_mst_stk_mvmt_rpt_tbl (NOLOCK)
 
 

set nocount OFF
end

GO
exec inventry_mst_stk_mvmt_rpt_sp