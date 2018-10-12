--exec Sp_Inventory_trans_Report_out 'PERAK','PRK-001-0001','2015-07-10', '2017-07-12' ,'RECEIVE'
Alter procedure Sp_Inventory_trans_Report_out
@state nvarchar(100),
@location nvarchar(100),
@receivefrom date ,
@receiveto date ,
@transtype nvarchar(200) = NULL
as 
begin

/*
Declare @Guid varchar(100)

select @guid = newid()

if @state in ('ALL','0','')
begin 
	select @state = '%'
end
else
begin 
	select @state = '%'+@state
end

if @location in ('ALL','0','')
begin 
	select @location = '%'
end
else
begin 
	select @location = '%'+@location
end
*/

if @transtype = 'Receive'
begin
	exec Sp_Grn_Report_out1  @state, @location ,@receivefrom, @receiveto
end
else if @transtype = 'Transfer'
begin
	exec Sp_trf_Report_out  @state, @location ,@receivefrom, @receiveto
end
else if @transtype = 'Issue'
begin
	exec Sp_Grn_Report_out  @state, @location ,@receivefrom, @receiveto
end

end

