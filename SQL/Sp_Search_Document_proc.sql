alter Procedure Sp_Search_Document_proc 
@State varchar(100) ='perak' ,
@District varchar (100)='KERIAN',
@DocType varchar(100)='PPM B03 & CHECKLIST',
@Year  Varchar(100)=2019,
@Benumber  Varchar(100)='PRK030704',
@freq  Varchar(100) = 1
as
begin

if @State in ('ALL','','--Select--')
begin
	select @State = '%'
end

if @District in ('ALL','','--Select--')
begin
	select @District = '%'
end

if @DocType in ('ALL','','--Select--')
begin
	select @DocType = '%'
end

if @Year in ('ALL','','--Select--',null)
begin
	select @Year = '%'
end

if @Benumber in ('ALL','','--Select--')
begin
	select @Benumber = '%'
end
else 
begin
	select @Benumber = '%'+@Benumber+'%'
end

--added by murugan for document download issue
update Doc_upload_detail
set filename = replace(   filename,'.'+filetype,'')
,folder = folder +'.'+filetype --replace(folder,'.pdf','')--+'.pdf'
where  State like @State
and  District like @District
and DocumentType like @DocType
and Year like @Year 
and folder not like '%'+'.'+filetype

Select Rowid 'No',State,District,DocumentType 'Document Type',Year,Folder 'File Name' ,Filename 'File'
from  Doc_upload_detail (nolock)
where  State like @State
and  District like @District
and DocumentType like @DocType
and Year like @Year
and Filename like @Benumber+'_'+@freq+'%'

end

--update Doc_upload_detail
--set filename = replace(   filename,filetype,'')
--,folder = folder +'.'+filetype --replace(folder,'.pdf','')--+'.pdf'
--where  State like @State
--and  District like @District
--and DocumentType like @DocType
--and Year like @Year 

--update t set  folder = '2019/PERAK/KERIAN/PPM B03 & CHECKLIST/PRK030704_1.pdf', 

--filename = 
--'PRK030704_1'
-- from Doc_upload_detail t
--where filename = 
--'PRK030704_1'

--2019/PERAK/KERIAN/PPM B03 & CHECKLIST/PRK030704_1.pdf.pdf.pdf

 