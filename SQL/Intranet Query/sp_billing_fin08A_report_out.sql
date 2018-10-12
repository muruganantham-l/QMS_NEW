Create  procedure sp_billing_fin08A_report_out 
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

select @batchanumber = replace(@batchanumber,'''','')

Declare @batchdetail table (batchnumber varchar(100))

if @batchanumber in  ('ALL','0')
begin 

	insert into @batchdetail (batchnumber)
	select distinct ast_det_varchar21 from ast_det(nolock) where ast_det_varchar15 ='New Biomedical'
	
end
else
begin 
	while charindex(',',@batchanumber) > 0
	begin
	
		insert into @batchdetail (batchnumber)
		select left(@batchanumber,charindex(',',@batchanumber)-1)

		set @batchanumber = right(@batchanumber, len(@batchanumber) - charindex(',',@batchanumber))

	end
	
	insert into @batchdetail (batchnumber)
	select @batchanumber
end

Delete from @batchdetail
where batchnumber = 'ALL'

if @statename in ('ALL','0')
begin
set @statename = '%'
end

if @District in  ('ALL','0')
begin
set @District = '%'
end

--if @batchanumber in  ('ALL','0')
--begin
--set @batchanumber = 'BATCH%'
--end

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

DECLARE @guid varchar(100)
select @guid = newid()

insert into number_to_fun_table (guid,
clinic,
clinicname,
amount)
select @guid , ast_det_cus_code,ast_det_note1, Sum(ast_det_numeric8) 'Amount' 
FROM
ast_mst (NOLOCK) ,
AST_DET (NOLOCK) 
WHERE ast_mst.ROWID = AST_DET.mst_RowID
AND ast_det_varchar15 = 'New Biomedical'
and ast_mst_asset_status = 'ACT'
and ast_mst_ast_lvl			like @statename
and ast_mst_asset_locn		like @District
and ast_mst_asset_code		like @clinicCateg
and ast_mst_asset_grpcode	like @clinicName
and ast_det_varchar21 in (select batchnumber from @batchdetail )
and convert(date,@invoicedate ) > convert(date,ast_det_datetime2)
and convert(date,@invoicedate ) between convert(date,ast_det_datetime19) and convert(date,ast_det_datetime20)
AND ast_mst_asset_grpcode not in ('11-285N')
group by ast_det_cus_code ,ast_det_note1

update number_to_fun_table with (updlock)
set numtoword = dbo.fNumToWords (Amount)
where guid = @guid

SELECT  
ast_det.ast_det_cus_code	'CLINICCODE',
ast_det.ast_det_note1		'CLINICNAME',
ast_det_note2		'CLINICADDRESS',
ast_mst_asset_no  'BENUMBER',
ast_mst_asset_shortdesc 'ASSETNAME',
RIGHT(ast_det_varchar21,2) 'BATCHNUMBER',
ast_det_asset_cost 'PURCAHSECOST',
isnull(ast_det_numeric8 ,0.0) 'MaintananceValue',
ast_mst_asset_no 'REFE' ,
ast_mst_ast_lvl 'STATE',
ast_mst_asset_locn 'DISTRICT',
convert(varchar,Datediff(mm,ast_det_datetime19,@invoicedate)+1)+'/'+ convert(varchar,(Datediff(mm,ast_det_datetime19,ast_det_datetime20)+1)) 'INSTALMENTNO',
numtoword 'AMOUNT',
@invoicedate 'INVOICEDATE'
FROM
ast_mst (NOLOCK) ,
AST_DET (NOLOCK) ,
number_to_fun_table func (nolock)
WHERE ast_mst.ROWID = AST_DET.mst_RowID
and func.clinic = ast_det.ast_det_cus_code
and func.guid = @guid
AND ast_det_varchar15 = 'New Biomedical'
and ast_mst_asset_status = 'ACT'
AND ast_mst_asset_grpcode not in ('11-285N')
and convert(date,@invoicedate ) > convert(date,ast_det_datetime2)
and convert(date,@invoicedate ) between convert(date,ast_det_datetime19) and convert(date,ast_det_datetime20)
and ast_mst_ast_lvl			like @statename
and ast_mst_asset_locn		like @District
and ast_mst_asset_code		like @clinicCateg
and ast_mst_asset_grpcode	like @clinicName
and ast_det_varchar21 in (select batchnumber from @batchdetail)
order by ast_det.ast_det_cus_code

Delete from number_to_fun_table
where guid = @guid


end

