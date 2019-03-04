use hrms40
go

if exists ( select 'y' from sysobjects where name = 'generate_session_id' and type = 'P')
    drop proc generate_session_id
go



 

create proc generate_session_id
@guid	 varchar(500) output
as
begin
set nocount on
select @guid = newid()
set nocount off
end

go

if exists ( select 'y' from sysobjects where name = 'generate_session_id' and type = 'P')
    grant exec on generate_session_id to public
go
