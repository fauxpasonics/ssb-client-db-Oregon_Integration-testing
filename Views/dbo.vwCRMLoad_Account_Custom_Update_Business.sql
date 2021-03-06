SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE  VIEW [dbo].[vwCRMLoad_Account_Custom_Update_Business]
AS
SELECT  
	 z.[crm_id] Id
	, b.[SSB_CRMSYSTEM_Contact_ID__c] 
	, b.[SSB_CRMSYSTEM_SSID_Winner__c] 
	, b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] 
	, NULLIF(b.[SSB_CRMSYSTEM_DimCustomerID__c] ,'') [SSB_CRMSYSTEM_DimCustomerID__c]
	, NULLIF(b.[AccountId],'') AS [SSB_CRMSYSTEM_SSID_TIX__c]
	, NULLIF(b.[CRMProcess_UpdatedDate],'') [CRMProcess_UpdatedDate]
	, NULLIF(z.EmailPrimary,'') AS Business_Email__c											--,aa.Business_Email__c
	,b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c  
	,b.Football_Full__c	
	,b.Football_Rookie__c	
	,b.Football_Partial__c	
	,b.Men_s_Basketball_Full__c	
	,b.Men_s_Basketball_Rookie__c	 
	,b.Men_s_Basketball_Partial__c 
	,b.SSB_CRMSYSTEM_Last_Donation_Date__c 
	,b.SSB_CRMSYSTEM_Donor_Warning__c  
	,b.SSB_CRMSYSTEM_Development_Owner__c  
	,b.SSB_CRMSYSTEM_Total_Priority_Points__c  
	,b.SSB_CRMSYSTEM_Priority_Point_Rank__c    
	,b.SSB_CRMSYSTEM_Customer_Type__c

	,b.SSB_CRMSYSTEM_Baseball_YOP__c 
	,b.SSB_CRMSYSTEM_Football_YOP__c 
	,b.SSB_CRMSYSTEM_MBB_YOP__c 
	,b.SSB_CRMSYSTEM_WBB_YOP__c 
	,b.SSB_CRMSYSTEM_Volleyball_YOP__c 
	,b.SSB_CRMSYSTEM_Track_YOP__c 
	,b.SSB_CRMSYSTEM_Softball_YOP__c 
	,b.SSB_CRMSYSTEM_Lifetime_Giving__c 
FROM dbo.[vwCRMLoad_Account_Std_Prep] a
INNER JOIN dbo.Contact_Custom b ON [a].[ssb_crmsystem_Contact_ID__c] = b.ssb_crmsystem_Contact_ID__c
INNER JOIN dbo.Contact z ON a.[ssb_crmsystem_Contact_ID__c] = z.ssb_crmsystem_Contact_ID
LEFT JOIN prodcopy.Account AA ON z.crm_ID = aa.ID
LEFT JOIN prodcopy.RecordType rt ON aa.RecordTypeId = rt.Id
WHERE z.[SSB_CRMSYSTEM_Contact_ID] <> z.[crm_id]
AND rt.name = 'Business Account' --Added TCF 6/5/17 in place of line below
--AND ISNULL(CASE WHEN rt.name = 'Business_Account' THEN 1 WHEN rt.name = 'PersonAccount' THEN 0 END, z.isbusinessaccount) = 1
AND (ISNULL(b.SSB_CRMSYSTEM_SSID_Winner__c,'') != ISNULL(aa.ssb_crmsystem_ssid_winner__c,'')
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'')
	OR ISNULL(b.AccountId,'') != 	ISNULL(aa.[SSB_CRMSYSTEM_SSID_TIX__c],'')
	OR ISNULL(b.[SSB_CRMSYSTEM_DimCustomerID__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_DimCustomerID__c],'')
	OR ISNULL(z.EmailPrimary,'') !=  ISNULL(aa.Business_Email__c,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c  	,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c  	,'')
	OR ISNULL(b.Football_Full__c		,'') != ISNULL(aa.Football_Full__c		,'')
	OR ISNULL(b.Football_Rookie__c		,'') != ISNULL(aa.Football_Rookie__c		,'')
	OR ISNULL(b.Football_Partial__c		,'') != ISNULL(aa.Football_Partial__c		,'')
	OR ISNULL(b.Men_s_Basketball_Full__c		,'') != ISNULL(aa.Men_s_Basketball_Full__c		,'')
	OR ISNULL(b.Men_s_Basketball_Rookie__c	   	,'') != ISNULL(aa.Men_s_Basketball_Rookie__c	   	,'')
	OR ISNULL(b.Men_s_Basketball_Partial__c   	,'') != ISNULL(aa.Men_s_Basketball_Partial__c   	,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Last_Donation_Date__c 			,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Donation_Date__c 			,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Donor_Warning__c  				,'') != ISNULL(aa.SSB_CRMSYSTEM_Donor_Warning__c  				,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Development_Owner__c  			,'') != ISNULL(aa.SSB_CRMSYSTEM_Development_Owner__c  			,'')
	OR ISNULL(CAST(b.SSB_CRMSYSTEM_Total_Priority_Points__c AS FLOAT)  		,'') != ISNULL(aa.SSB_CRMSYSTEM_Total_Priority_Points__c  		,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Priority_Point_Rank__c    		,'') != ISNULL(aa.SSB_CRMSYSTEM_Priority_Point_Rank__c    		,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Customer_Type__c				,'') != ISNULL(aa.SSB_CRMSYSTEM_Customer_Type__c				,'')
	OR isnull(b.SSB_CRMSYSTEM_Baseball_YOP__c,0) != isnull(aa.SSB_CRMSYSTEM_Baseball_YOP__c,0) 
	OR isnull(b.SSB_CRMSYSTEM_Football_YOP__c,0) != isnull(aa.SSB_CRMSYSTEM_Football_YOP__c,0) 
	OR isnull(b.SSB_CRMSYSTEM_MBB_YOP__c ,0)!= isnull(aa.SSB_CRMSYSTEM_MBB_YOP__c ,0)
	OR isnull(b.SSB_CRMSYSTEM_WBB_YOP__c ,0)!= isnull(aa.SSB_CRMSYSTEM_WBB_YOP__c ,0)
	OR isnull(b.SSB_CRMSYSTEM_Volleyball_YOP__c,0) != isnull(aa.SSB_CRMSYSTEM_Volleyball_YOP__c,0) 
	OR isnull(b.SSB_CRMSYSTEM_Track_YOP__c,0) != isnull(aa.SSB_CRMSYSTEM_Track_YOP__c,0) 
	OR isnull(b.SSB_CRMSYSTEM_Softball_YOP__c,0) != isnull(aa.SSB_CRMSYSTEM_Softball_YOP__c,0) 
	OR isnull(b.SSB_CRMSYSTEM_Lifetime_Giving__c,0)!= isnull(aa.SSB_CRMSYSTEM_Lifetime_Giving__c,0)
)


GO
