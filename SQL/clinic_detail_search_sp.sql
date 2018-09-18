ALTER proc clinic_detail_search_sp
@clinic_code varchar(25)
as
begin
set nocount on

SELECT c.cus_mst_shipvia 'clinic_category',cus_det_city 'District',cus_det_state 'state'
from cus_mst c (NOLOCK)
join cus_det d (nolock)
on c.rowid =d.mst_rowid
where c.cus_mst_customer_cd = @clinic_code

set NOCOUNT OFF
end

