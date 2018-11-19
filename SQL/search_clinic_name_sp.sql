 

ALTER proc search_clinic_name_sp
@state varchar(300)
,@district varchar(300)
,@clinic_category varchar(300)
as
begin

if @district = 'all'
select @district = null

if @clinic_category = 'all'
SELECT @clinic_category = null

SELECT m.cus_mst_customer_cd 'clinic_code',m.cus_mst_desc 'clinic_name' 
from cus_mst m (NOLOCK)  
join cus_det d (NOLOCK) 
on m.RowID = d.mst_RowID 
where cus_det_state = @state
and  (cus_det_city = @district or @district is null)
and ( cus_mst_shipvia = @clinic_category or @clinic_category is NULL)

end