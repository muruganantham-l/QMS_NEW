alter procedure sp_billing_report_summary_out 
@statename		varchar(100) ='JOHOR',
@District varchar(100) = 'BATU PAHAT' ,
@batchanumber varchar(100) = 'Batch 9',
@clinicName varchar(100) = 0,
@ownership varchar(100) = 'Purchase Biomedical',
@clinicCateg varchar(100) = 'KESIHATAN',
@invoicedate date = '2018-12-31',
@paymonth date = '2018-10-31'
as
begin
set nocount on


--drop table test
 

--select @statename 'statename',@District 'District',@batchanumber 'batchanumber',@clinicName 'clinicName',@ownership 'ownership',@clinicCateg 'clinicCateg'
--,@invoicedate 'invoicedate',@paymonth 'paymonth'

--into test

select @batchanumber = replace(@batchanumber,'''','')

Declare @batchdetail table (batchnumber varchar(100))

if @batchanumber in  ('ALL','0','')
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
--set @batchanumber = '%'
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
declare @temp table
(
 CLINICCODE			varchar(700)
,CLINICNAME			varchar(700)
,STATE				varchar(700)
,DISTRICT			varchar(700)
,ADDRESS			varchar(700)
,BENUMBER			varchar(700)
,RENTAL				varchar(700)
,CATEGORY			varchar(700)
,STATEREF			varchar(700)
,REF				varchar(700)

)

Declare @getdate datetime = dateadd(mm,-1,getdate())

if @ownership = 'New Biomedical'
		begin
				 
					Delete from BV_support_data_upload_tab
					where [Invoicedate] = convert(varchar,@invoicedate,120)
					and [StateName] like @statename
					and [SupportDistrict] like @District
					and [ClinicCategory] like @clinicCateg
					and [BatchNumber] in (select batchnumber from @batchdetail )


					insert into BV_support_data_upload_tab
					([Invoicedate],[StateName],[SupportDistrict],[noofBE],[Amount],[ClinicCategory],[SupportState],[SupportClinic],[SupportClinicRef],[BatchNumber],[SupportType])									SELECT
					convert(varchar,@invoicedate,120),
					ast_mst_ast_lvl 'STATE',
					ast_mst_asset_locn 'DISTRICT',
					Count(ast_mst_asset_no)  'BENUMBER',
					SUm(ast_det_numeric9) 'RENTAL',
					ast_mst_asset_code 'CATEGORY' ,
					StateRef 'STATEREF',
					PKDPPDRef 'REF',
					PKDPPDRef 'REF',
					ast_det_varchar21,
					'FIN03A' 
					
					FROM
					ast_mst (NOLOCK) ,
					AST_DET (NOLOCK) ,
					Pkd_Ppd_loc (nolock)
					WHERE ast_mst.ROWID			= AST_DET.mst_RowID
					and ast_mst_asset_locn		= District
					and ast_mst_asset_code		= category
					and ast_mst_ast_lvl			= state
					and ast_mst_ast_lvl		like @statename
					and ast_mst_asset_locn	like @District
					and ast_mst_asset_code	like @clinicCateg
					and ast_mst_asset_grpcode like @clinicName
					and ast_det_varchar21   in (select batchnumber from @batchdetail )
					--and convert(date,@invoicedate ) between convert(date,ast_det_datetime19) and convert(date,ast_det_datetime20)
					and @invoicedate between ast_det_datetime19   and  ast_det_datetime20
					AND ast_det_varchar15 = 'New Biomedical'
					and ast_mst_asset_status = 'ACT'
					AND ast_mst_asset_grpcode not in ('11-285N')
					group by ast_mst_asset_code,ast_mst_ast_lvl , ast_mst_asset_locn,StateRef,PKDPPDRef,ast_det_varchar21
		 
--			if SUSER_NAME() = 'tommsadm'	
--			BEGIN
--SELECT 'test'
--END
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
					Pkd_Ppd_loc (nolock)
					--,
					--(select ast_det_cus_code, ast_det_note1 , Sum(ast_det_numeric9) 'Amount' 
					--FROM
					--ast_mst (NOLOCK) ,
					--AST_DET (NOLOCK) 
					--WHERE ast_mst.ROWID = AST_DET.mst_RowID
					--AND ast_det_varchar15 = 'New Biomedical'
					--AND ast_mst_asset_grpcode not in ('11-285N')
					--group by ast_det_cus_code, ast_det_note1
					-- ) func
					WHERE ast_mst.ROWID			= AST_DET.mst_RowID
					----and func.ast_det_cus_code	= ast_det.ast_det_cus_code
					and ast_mst_asset_locn		= District
					and ast_mst_asset_code		= category
					and ast_mst_ast_lvl			= state
					and ast_mst_ast_lvl		like @statename
					and ast_mst_asset_locn	like @District
					and ast_mst_asset_code	like @clinicCateg
					and ast_mst_asset_grpcode like @clinicName
					and ast_det_varchar21   in (select batchnumber from @batchdetail )
					and convert(date,@invoicedate ) between convert(date,ast_det_datetime19) and convert(date,ast_det_datetime20)
					--commented by murgan and @invoicedate between ast_det_datetime19   and  ast_det_datetime20
					AND ast_det_varchar15 = 'New Biomedical'
					and ast_mst_asset_status = 'ACT'
					AND ast_mst_asset_grpcode not in ('11-285N')
					group by ast_det.ast_det_cus_code, ast_mst_asset_code,ast_det.ast_det_note1	,ast_mst_ast_lvl , ast_mst_asset_locn,ltrim(rtrim(Name))+'  '+char(13)+char(10)+ltrim(rtrim(Address)),StateRef,PKDPPDRef
					order by ast_det.ast_det_cus_code
		end

if @ownership = 'Purchase Biomedical'
		begin

					SELECT  
					ast_det.ast_det_cus_code	'CLINICCODE',
					ast_det.ast_det_note1		'CLINICNAME',
					ast_mst_ast_lvl 'STATE',
					ast_mst_asset_locn 'DISTRICT',
					ltrim(rtrim(Name))+'  '+char(13)+char(10)+ltrim(rtrim(Address)) 'ADDRESS',
					Count(ast_mst_asset_no)  'BENUMBER',
					SUm(ast_det_asset_cost) 'RENTAL',
					ast_mst_asset_code 'CATEGORY' ,
					StateRef 'STATEREF',
					PKDPPDRef 'REF'
					FROM
					ast_mst (NOLOCK) ,
					AST_DET (NOLOCK) ,
					Pkd_Ppd_loc (nolock)--,
					--(select ast_det_cus_code, ast_det_note1 , Sum(ast_det_asset_cost) 'Amount' 
					--FROM
					--ast_mst (NOLOCK) ,
					--AST_DET (NOLOCK) 
					--WHERE ast_mst.ROWID = AST_DET.mst_RowID
					--AND ast_det_varchar15 = 'Purchase Biomedical'
					--AND ast_mst_asset_grpcode not in ('11-285N')
					--group by ast_det_cus_code, ast_det_note1
					-- ) func
					WHERE ast_mst.ROWID			= AST_DET.mst_RowID
					--and func.ast_det_cus_code	= ast_det.ast_det_cus_code
					and ast_mst_asset_locn		= District
					and ast_mst_asset_code		= category
					and ast_mst_ast_lvl			= state
					and ast_mst_ast_lvl		like @statename
					and ast_mst_asset_locn	like @District
					and ast_mst_asset_code	like @clinicCateg
					and ast_mst_asset_grpcode like @clinicName
					and ast_det_varchar21   in (select batchnumber from @batchdetail )
					--and convert(date,@invoicedate ) between convert(date,ast_det_datetime19) and convert(date,ast_det_datetime20)
					and @invoicedate between ast_det_datetime19   and  ast_det_datetime20
					AND ast_det_varchar15	= 'Purchase Biomedical'
					and ast_mst_asset_status = 'ACT'
					AND ast_mst_asset_grpcode not in ('11-285N')
					--added by murugan
					and ast_det_varchar29 is null
					group by ast_det.ast_det_cus_code, ast_mst_asset_code,ast_det.ast_det_note1	,ast_mst_ast_lvl , ast_mst_asset_locn,ltrim(rtrim(Name))+'  '+char(13)+char(10)+ltrim(rtrim(Address)),StateRef,PKDPPDRef
					order by ast_det.ast_det_cus_code
		end
	set nocount off

end




















