 --update swk_ppm_list_sa7 set lpm_date = cast(lpm_date as date)
--update swk_ppm_list_sa7 set lpm_date = dateadd(YEAR,-1,lpm_date) where freq_code = 1
--update swk_ppm_list_sa7 set lpm_date = dateadd(MONTH,-6,lpm_date) where freq_code = 2

--alter table swk_ppm_list_sa7 add err_id int
--alter table swk_ppm_list_sa7 add err_desc varchar (500)
--alter table swk_ppm_list_sa7 add pm_no varchar (150)

----alter table swk_ppm_list_sa7 add item_type varchar(10)
--update t
--set item_type = 'E'--N for new item
--,PM_no = m.prm_mst_pm_no
--from swk_ppm_list_sa7 t join prm_mst m on t.be_number = m.prm_mst_assetno
--and err_id = 3 and err_desc = 'BE Number alreay have PM No'

--update swk_ppm_list_sa7 set item_type = 'N' where item_type is NULL

--SELECT * from sbh_ppm_list (NOLOCK) where freq_code is     null
 
 /************* ppm table list
 
SELECT pm_no from perak_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from wpkl_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from SLR_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from jhr_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from KLPM_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from mlk_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from nsb_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from png_ppm_list where pm_no is not NULL
UNION
SELECT pm_no from sbh_ppm_list where pm_no is not NULL




 *****************/
ALTER proc ppm_generate_sp
as
begin
set nocount ON

declare @total_rec int
,@cur_rec int = 0
,@be_number varchar(100)
,@pm_no varchar(100)
,@error_id int = 0 
,@error_desc varchar(400)
,@freq_code int
,@lpm_date date
,@pm_no_IN varchar(400)
,@item_type varchar(10)

select @total_rec = count(*) from  swk_ppm_list_n (NOLOCK)

while @cur_rec <=  @total_rec
BEGIN

--begin TRAN

SELECT @error_id = 0
--SELECT @cur_rec
SELECT @be_number  = be_number,@freq_code = freq_code,@lpm_date = lpm_date,@pm_no_IN = pm_no,@item_type=item_type
from  swk_ppm_list_n (NOLOCK)
where no = @cur_rec
--and err_id is NULL

exec ppm_create_sp
 @be_number = @be_number
,@site_code	=	'QMS'
,@freq_code = @freq_code
,@lpm_date	=	@lpm_date
,@lpm_close_date	=	NULL
,@lpm_due_date	=	NULL
,@lead_days		=	28
,@plan_priority	=	2
,@description	=	null
,@pm_no = @pm_no_IN
,@item_type = @item_type
,@pm_no_out		= @pm_no output
,@error_id = @error_id OUT
,@error_desc = @error_desc OUT

  
           if  @error_id  <>  0
           begin
               --rollback  tran
               
			   update  swk_ppm_list_n
			   set     err_id  =  @error_id,  err_desc  =  @error_desc
			   where   be_number = @be_number and no = @cur_rec
		   end
           else
           begin
               --commit  tran
                 
               update  swk_ppm_list_n
			   set       pm_no  =  @pm_no
			   where   be_number = @be_number and no = @cur_rec
		   end

SELECT @cur_rec = @cur_rec + 1


END


set nocount OFF
end

 
 --select * from cnt_mst where cnt_mst_module_cd ='PM' -- 254229


