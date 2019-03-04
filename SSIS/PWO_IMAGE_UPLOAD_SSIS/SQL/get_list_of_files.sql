use hrms40
go

if exists ( select 'y' from sysobjects where name = 'get_list_of_files' and type = 'P')
    drop proc get_list_of_files
go



 

create PROC get_list_of_files @guid          VARCHAR(500)
AS
     BEGIN
          SET NOCOUNT ON
          SELECT DISTINCT file_name1 AS 'file_name'
          FROM file_names
          WHERE session_id = @guid

          DELETE file_names
          WHERE session_id = @guid
          SET NOCOUNT OFF
     END

go

if exists ( select 'y' from sysobjects where name = 'get_list_of_files' and type = 'P')
    grant exec on get_list_of_files to public
go
