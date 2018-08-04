SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vwCRMLoad_Account_Std_Upsert_Person] AS
SELECT --top 1

ssb_crmsystem_Contact_ID__c, a.FirstName, a.LastName ,a.Suffix AS Suffix__c, 
 BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, a.Phone, [LoadType]
 , CASE WHEN b.IsBusinessAccount = 1 THEN '012360000003ybnAAA' ELSE '0123600000040IIAAY' END RecordTypeId --updateme
FROM [dbo].[vwCRMLoad_Account_Std_Prep] a
JOIN dbo.Contact b ON a.ssb_crmsystem_Contact_ID__c = b.ssb_crmsystem_Contact_ID
WHERE LoadType = 'Upsert' AND b.IsBusinessAccount = 0
AND a.ssb_crmsystem_Contact_ID__c NOT IN (
'35EF729C-F99F-4BD9-8781-0F96F205E7D4',
'FFDBE26B-4903-45DA-9D12-9AD61A550E38',
'AA098687-AD75-448C-9148-4F5D1FDCEA8E',
'C64ADB7D-7550-4B2F-8DA1-483A354F1591'
)




GO
