alter proc update_NBE_bill_sp
@rowid					varchar(100)
,@installment_year 		varchar(100)
,@installment_month		varchar(100)
,@be_number        		varchar(100)
,@paid_flag        		varchar(100)
,@audit_user        	varchar(100)



as
begin
set NOCOUNT on 

declare @install_date date = concat(@installment_year,'-',@installment_month,'-','01')
,@sysdate datetime = getdate()
--insert nbe_bill_dtl_tbl (ast_mst_asset_no,installment_date,paid_flag,audit_user,audit_date)
--	 select @be_number,@install_date,@paid_flag,@audit_user,getdate()

  if EXISTS (SELECT '' from nbe_bill_dtl_tbl (NOLOCK) where rowid =   @rowid)
   BEGIN
     
	 update nbe_bill_dtl_tbl
	 set    paid_flag = @paid_flag,audit_user = iif(paid_flag =@paid_flag,audit_user, @audit_user),audit_date = iif(paid_flag =@paid_flag,audit_date,@sysdate)
	 where rowid = @rowid
	 
   END
   ELSE
   BEGIN

   if @paid_flag = 'false' 
   begin
   SELECT @audit_user = null
   ,@sysdate = null

   end
   insert nbe_bill_dtl_tbl (ast_mst_asset_no,installment_date,paid_flag,audit_user,audit_date)
	 select @be_number,@install_date,@paid_flag,@audit_user,@sysdate

   END

set NOCOUNT off
end

--drop table test
--create table test
--(
--be_number  varchar(30)
--)


