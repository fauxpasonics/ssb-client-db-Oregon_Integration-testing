CREATE TABLE [MERGEPROCESS_New].[ReceiveResults]
(
[ResultID] [int] NOT NULL IDENTITY(1, 1),
[PK_MergeID] [int] NULL,
[ErrorCode] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorDescription] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Winning_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Losing_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateInserted] [datetime] NULL CONSTRAINT [DF__ReceiveRe__DateI__10566F31] DEFAULT (getdate()),
[ObjectType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [MERGEPROCESS_New].[ReceiveResults] ADD CONSTRAINT [PK__ReceiveR__97690228DF244A47] PRIMARY KEY CLUSTERED  ([ResultID])
GO
