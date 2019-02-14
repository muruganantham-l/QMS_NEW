ALTER proc nbe_installment_rpt
 @month 					varchar(30) = '9'
 ,@year 					varchar(30) = '2018'
,@clinic_code			varchar(250)	= null
,@clinic_name			varchar(250)	= 'all'
,@clinic_category		varchar(250)	= 'all'-- '1'
,@district				varchar(250)	= 'all'
,@state					varchar(250)	= 'PULAU PINANG'
,@be_number				varchar(100) = null
as
begin
set nocount ON

declare @month_year date = concat(@year,'-',@month,'-','01')

declare @guid			varchar(300) = newid()
		,@start_date	date = DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) 
		,@end_date		date = DATEADD(SECOND, -1, DATEADD(MONTH, 1,  DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) ) ) 
		,@month_name	varchar(300) = datename(month,@month_year)
		,@sysdate date = getdate()
		,@penalty		int
		--,@year			int	=	year(@month_year) 

select @be_number = ltrim(rtrim(@be_number)) 

--drop table test
if @clinic_code in ( 'all','')
select @clinic_code = null

if @clinic_category = 'all'
select @clinic_category = null

if @state = 'all'
SELECT @state = null

if @district = 'All'
SELECT @district = NULL

if (@be_number = 'all' or @be_number = '')
SELECT @be_number = null

--select @be_number = 'PRNWAS005'
truncate table nbe_installment_tbl
truncate table nbe_installment_tbl_rpt

--select @report_date = dateadd(YEAR,1,getdate())
--alter table nbe_installment_tbl alter column  install_start_date date

--alter table nbe_installment_tbl alter column  install_end_date date

 
insert nbe_installment_tbl 
(
be_no
,state1
,district
,clinic_name
,no_of_mnth_install
,install_start_date
,install_end_date
,amount
)

SELECT	m.ast_mst_asset_no
		,ast_mst_ast_lvl
		,ast_mst_asset_locn
		,d.ast_det_note1
		,datediff(MONTH,ast_det_datetime19,ast_det_datetime20)+1
		,ast_det_datetime19
		,ast_det_datetime20
		,ast_det_numeric9 
from    ast_mst m (NOLOCK)
JOIN	ast_det d (NOLOCK)
on		m.RowID = d.mst_RowID
and     d.ast_det_varchar15 = 'New Biomedical'
and		(ast_mst_ast_lvl = @state or @state is NULL				)
and		(m.ast_mst_asset_locn = @district or @district is null	)
and		(d.ast_det_cus_code = @clinic_code or @clinic_code is null			)
and     (m.ast_mst_asset_code = @clinic_category or @clinic_category is NULL) 
AND		(m.ast_mst_asset_no = @be_number or @be_number is null)
 
;with cte as (
SELECT   be_no,state1,district,clinic_name,no_of_mnth_install,install_start_date,install_end_date, install_start_date 'installment_date',amount
from     nbe_installment_tbl (NOLOCK) a

union ALL

SELECT   be_no,state1,district,clinic_name,no_of_mnth_install,install_start_date,install_end_date,  dateadd(MONTH,1,installment_date),amount
from     cte
where    dateadd(MONTH,1,installment_date) <= @month_year

)

insert nbe_installment_tbl_rpt (
be_no
,state1
,district
,clinic_name
,no_of_mnth_install
,install_start_date
,install_end_date
,date1
,ins_no
,amount
--,status1
)

SELECT
be_no
,state1
,district
,clinic_name
,no_of_mnth_install
,install_start_date
,install_end_date
,installment_date
,concat(datediff(mm,install_start_date,installment_date)+1,'/',no_of_mnth_install)
,amount
 from cte

--select * into nbe_installment_tbl_rpt from nbe_installment_tbl where 1=2

SELECT  

be_no
,state1
,district
,upper(clinic_name) clinic_name
,no_of_mnth_install
,concat(left(datename(month,install_start_date),3),'-',right(year(install_start_date),2)) install_start_date
,concat(left(datename(month,install_end_date),3),'-',right(year(install_end_date),2)) install_end_date
,concat(left(datename(month,date1),3),'-',right(year(date1),2)) date1
,ins_no
,amount
,status1
,date1 date_ord

from nbe_installment_tbl_rpt (NOLOCK)
 ----select distinct ast_det_varchar15 from ast_det
 --alter table nbe_installment_tbl_rpt alter column install_start_date varchar(100)

set nocount OFF
end