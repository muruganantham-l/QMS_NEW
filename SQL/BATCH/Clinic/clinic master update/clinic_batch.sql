ALTER proc clinic_batch_update
as
begin
set nocount ON
delete [clinic_batch$] where cus_mst_customer_cd = 'clinic_code'
 
update  [clinic_batch$]
SET		cus_mst_customer_cd = replace(replace(REPLACE(cus_mst_customer_cd,char(9),''),CHAR(10),''),CHAR(13),'')
		,cus_mst_fob = replace(replace(REPLACE(cus_mst_fob,char(9),''),CHAR(10),''),CHAR(13),'')

update m
SET    m.cus_mst_fob = isnull(c.cus_mst_fob,m.cus_mst_fob)--clinic type
from   cus_mst m 
JOIN   [clinic_batch$] c on m.cus_mst_customer_cd = c.cus_mst_customer_cd 

SELECT @@rowcount

update d
SET    d.ast_det_varchar1 = isnull(c.cus_mst_fob,d.ast_det_varchar1 )--clinic type
from   ast_det d 
JOIN   [clinic_batch$] c on d.ast_det_cus_code = c.cus_mst_customer_cd 

SELECT @@rowcount

set nocount OFF

end
 