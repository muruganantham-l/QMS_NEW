ALTER proc clinic_batch_update
as
begin
set nocount ON

declare @username varchar(100) = 'patch'
declare @sysdate  datetime = getdate()

delete [clinic_batch$] where cus_mst_customer_cd = 'clinic_code'
delete [clinic_batch$] where cus_mst_customer_cd is NULL
 
update  [clinic_batch$]
SET		cus_mst_customer_cd = replace(replace(REPLACE(cus_mst_customer_cd,char(9),''),CHAR(10),''),CHAR(13),'')
		,cus_mst_fob = replace(replace(REPLACE(cus_mst_fob,char(9),''),CHAR(10),''),CHAR(13),'')--clinic type
		,cus_mst_seller = replace(replace(REPLACE(cus_mst_seller,char(9),''),CHAR(10),''),CHAR(13),'')--cost centre

update m
SET    m.cus_mst_fob = isnull(c.cus_mst_fob,m.cus_mst_fob)--clinic type
       ,m.cus_mst_seller = isnull(c.cus_mst_seller,m.cus_mst_seller)--cost centre
from   cus_mst m 
JOIN   [clinic_batch$] c on m.cus_mst_customer_cd = c.cus_mst_customer_cd 
 
SELECT @@rowcount

update d
SET    d.ast_det_varchar1 = isnull(c.cus_mst_fob,d.ast_det_varchar1 )--clinic type
from   ast_det d 
JOIN   [clinic_batch$] c 
on     d.ast_det_cus_code = c.cus_mst_customer_cd 


update m
set    ast_mst_cost_center = isnull(c.cus_mst_seller,m.ast_mst_cost_center)--cost centre
from   ast_det d (NOLOCK)
JOIN   [clinic_batch$] c on d.ast_det_cus_code = c.cus_mst_customer_cd 
join   ast_mst m (NOLOCK)
on     m.RowID = d.mst_RowID


SELECT @@rowcount

set nocount OFF

end

--cus_mst_shipvia 
 