Alter procedure sp_billing_report_summary_out 
@statename varchar(100),
@District varchar(100) ,
@batchanumber varchar(100),
@clinicName varchar(100) ,
@ownership varchar(100) ,
@clinicCateg varchar(100),
@invoicedate date ,
@paymonth date
as
begin

if @statename in ('ALL','0')
begin
set @statename = '%'
end

if @District in  ('ALL','0')
begin
set @District = '%'
end

if @batchanumber in  ('ALL','0')
begin
set @batchanumber = '%'
end

if @clinicCateg in  ('ALL','0')
begin
set @clinicCateg = '%'
end

if @ownership in  ('ALL','0')
begin
set @ownership = '%'
end

if @clinicName in  ('ALL','0')
begin
set @clinicName = '%'
end

Declare @getdate datetime = dateadd(mm,-1,getdate())

SELECT  
ast_det.ast_det_cus_code	'CLINICCODE',
ast_det.ast_det_note1		'CLINICNAME',
ast_mst_ast_lvl 'STATE',
ast_mst_asset_locn 'DISTRICT',
ltrim(rtrim(Name))+'  '+char(13)+char(10)+ltrim(rtrim(Address)) 'ADDRESS',
Count(ast_mst_asset_no)  'BENUMBER',
SUm(ast_det_numeric9) 'RENTAL',
ast_mst_asset_code 'CATEGORY' ,
StateRef 'STATEREF',
PKDPPDRef 'REF'
FROM
ast_mst (NOLOCK) ,
AST_DET (NOLOCK) ,
Pkd_Ppd_loc (nolock),
(select ast_det_cus_code, ast_det_note1 , Sum(ast_det_numeric9) 'Amount' 
FROM
ast_mst (NOLOCK) ,
AST_DET (NOLOCK) 
WHERE ast_mst.ROWID = AST_DET.mst_RowID
AND ast_det_varchar15 = 'New Biomedical'
group by ast_det_cus_code, ast_det_note1
 ) func
WHERE ast_mst.ROWID			= AST_DET.mst_RowID
and func.ast_det_cus_code	= ast_det.ast_det_cus_code
and ast_mst_asset_locn		= District
and ast_mst_asset_code		= category
and ast_mst_ast_lvl			= state
AND ast_det_varchar15	like @ownership
and ast_mst_ast_lvl		like @statename
and ast_mst_asset_locn	like @District
and ast_mst_asset_code	like @clinicCateg
and ast_det_varchar21   like @batchanumber
group by ast_det.ast_det_cus_code, ast_mst_asset_code,ast_det.ast_det_note1	,ast_mst_ast_lvl , ast_mst_asset_locn,ltrim(rtrim(Name))+'  '+char(13)+char(10)+ltrim(rtrim(Address)),StateRef,PKDPPDRef
order by ast_det.ast_det_cus_code

end






