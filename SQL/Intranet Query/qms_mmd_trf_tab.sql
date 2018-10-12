Create table qms_mmd_trf_tab
(
[Guid] nvarchar(200),
[NUM] int,
[STATE NAME] nvarchar(200),
[FROM STOCK LOCATION] Nvarchar(200),
[TO STOCK LOCATION] Nvarchar(200),
[STOCK NUM] Nvarchar(200),
[STOCK DESCR] Nvarchar(200),
[PART NUM] Nvarchar(200),
[UOM] Nvarchar(200),
[STOCK COST (RM)] numeric(13,2),
[CAMMS TRF DATE] Nvarchar(200),
[ACTUAL TRF DATE] Nvarchar(200),
[TRF QTY] numeric(5,2),
[TRF NUM] Nvarchar(200),
[TOTAL TRF COST (RM)] numeric(13,2),
[TRF BY (NAME)] Nvarchar(200),
[TRF REQUESTED BY (REMARK)] Nvarchar(200),
[TRF PURPOSE (REMARK)] Nvarchar(200)
)