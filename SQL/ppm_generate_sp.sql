

--alter table perak_ppm_list
--add pm_no varchar(100)
--add err_desc varchar(500)


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

select @total_rec = count(*) from  perak_ppm_list (NOLOCK)

while @cur_rec <= 10--@total_rec
BEGIN

begin TRAN

SELECT @error_id = 0

SELECT @be_number  = be_number,@freq_code = freq_code,@lpm_date = lpm_date
from  perak_ppm_list (NOLOCK)
where no = @cur_rec

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
,@pm_no_out		= @pm_no output
,@error_id = @error_id OUT
,@error_desc = @error_desc OUT

  
           if  @error_id  <>  0
           begin
               rollback  tran
               
			   update  perak_ppm_list
			   set     err_id  =  @error_id,  err_desc  =  @error_desc
			   where   be_number = @be_number and no = @cur_rec
		   end
           else
           begin
               commit  tran
                 
               update  perak_ppm_list
			   set       pm_no  =  @pm_no
			   where   be_number = @be_number and no = @cur_rec
		   end

SELECT @cur_rec = @cur_rec + 1


END


set nocount OFF
end

 
 
