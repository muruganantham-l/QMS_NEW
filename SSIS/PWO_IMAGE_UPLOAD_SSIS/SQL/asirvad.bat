@echo off

set servername=%1
set username=%2
set password=%3
Set dbname=%4

Rem If 4 parameters are not supplied call error.

@if "%servername%" == "" goto error
@if "%username%" == "" goto error
@if "%password%" == "" goto error
@if "%dbname%" == "" goto error

cls
@echo Deployment Starts

osql -n -U%username% -S%servername% -d%dbname% -P%password% -i1_aml_ars_processed_status.sql -o1_aml_ars_processed_status.err
osql -n -U%username% -S%servername% -d%dbname% -P%password% -i2_aml_ars_ssis_tbl.sql -o2_aml_ars_ssis_tbl.err
osql -n -U%username% -S%servername% -d%dbname% -P%password% -i3_file_names.sql -o3_file_names.err
osql -n -U%username% -S%servername% -d%dbname% -P%password% -iaml_ars_ssis_sp.sql -oaml_ars_ssis_sp.err
osql -n -U%username% -S%servername% -d%dbname% -P%password% -igenerate_session_id.sql -ogenerate_session_id.err
osql -n -U%username% -S%servername% -d%dbname% -P%password% -iget_list_of_files.sql -oget_list_of_files.err

@echo Deployment Ends - Please check the error files for any errors.

goto end

:error
@echo .
@echo .
@echo .
@echo Syntax wrong! Give the syntax as mentioned below.
@echo syntax : %0 servername username password databasename
@echo eg.    : %0 HRMS sa sa FIN40

: End

@echo .
@echo .
