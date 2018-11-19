ALTER proc clinic_detail_search_sp
@clinic_code varchar(25)
as
begin
set nocount on

SELECT cus_mst_customer_cd 'clinic_code'
from cus_mst c (NOLOCK)
join cus_det d (nolock)
on c.rowid =d.mst_rowid
where c.cus_mst_customer_cd = @clinic_code

set NOCOUNT OFF
end


