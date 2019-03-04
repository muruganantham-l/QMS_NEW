USE hrms40
GO

IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE name = 'file_names'
          AND type = 'u'
)
BEGIN
     DROP TABLE file_names
END
GO

CREATE TABLE dbo.file_names
(file_name1          VARCHAR(300)
,session_id          UDD_GUID
);