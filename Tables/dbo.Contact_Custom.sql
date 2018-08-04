CREATE TABLE [dbo].[Contact_Custom]
(
[SSB_CRMSYSTEM_Contact_ID__c] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SSB_CRMSYSTEM_SSID_Winner__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_SSID_TIX__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_DimCustomerID__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountId] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CRMProcess_UpdatedDate] [datetime] NULL,
[PersonOtherPhone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonEmail] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonHomePhone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonBirthdate] [date] NULL,
[SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c] [date] NULL,
[Football_Full__c] [bit] NULL,
[Football_Rookie__c] [bit] NULL,
[Football_Partial__c] [bit] NULL,
[Men_s_Basketball_Full__c] [bit] NULL,
[Men_s_Basketball_Rookie__c] [bit] NULL,
[Men_s_Basketball_Partial__c] [bit] NULL,
[SSB_CRMSYSTEM_Last_Donation_Date__c] [date] NULL,
[SSB_CRMSYSTEM_Donor_Warning__c] [bit] NULL,
[SSB_CRMSYSTEM_Development_Owner__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_Total_Priority_Points__c] [decimal] (10, 2) NULL,
[SSB_CRMSYSTEM_Priority_Point_Rank__c] [int] NULL,
[SSB_CRMSYSTEM_Customer_Type__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_Baseball_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_Football_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_MBB_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_WBB_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_Volleyball_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_Track_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_Softball_YOP__c] [int] NULL,
[SSB_CRMSYSTEM_Lifetime_Giving__c] [decimal] (18, 2) NULL
)
GO
ALTER TABLE [dbo].[Contact_Custom] ADD CONSTRAINT [PK_Contact_Custom] PRIMARY KEY CLUSTERED  ([SSB_CRMSYSTEM_Contact_ID__c])
GO
