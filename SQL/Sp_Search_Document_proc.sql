alter Procedure Sp_Search_Document_proc 
@State varchar(100) ,
@District varchar (100),
@DocType varchar(100),
@Year  Varchar(100),
@Benumber  Varchar(100),
@freq  Varchar(100)
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

if @Year in ('ALL','','--Select--')
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

Select Rowid 'No',State,District,DocumentType 'Document Type',Year,Folder 'File Name' ,Filename 'File'
from  Doc_upload_detail (nolock)
where  State like @State
and  District like @District
and DocumentType like @DocType
and Year like @Year
and Filename like @Benumber+'_'+@freq

end


