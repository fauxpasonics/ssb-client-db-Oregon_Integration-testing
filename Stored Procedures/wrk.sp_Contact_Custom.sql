SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Created By: Abbey Meitin
-- Create Date: Before we starting tracking
-- Reviewed By: Scott Sales
-- Reviewed Date: 2018/07/20
-- Description: CRM Contact Custom Fields
-- =============================================
 
/***** Revision History
 Scott Sales: 2018/07/20 - Added logic for new custom fields; Reviewed by Ameitin

*****/

CREATE PROCEDURE [wrk].[sp_Contact_Custom]
AS 

TRUNCATE TABLE dbo.Contact_Custom;

MERGE INTO dbo.Contact_Custom Target
USING dbo.[Contact] source
ON source.[SSB_CRMSYSTEM_Contact_ID] = target.[SSB_CRMSYSTEM_Contact_ID__c]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([SSB_CRMSYSTEM_Contact_ID__c]) VALUES (Source.[SSB_CRMSYSTEM_Contact_ID])
WHEN NOT MATCHED BY SOURCE THEN DELETE;

EXEC dbo.sp_CRMProcess_ConcatIDs 'Contact'

DECLARE @currentmemberyear int = (Select  datepart(year,getdate()))
					
DECLARE @previousmemberyear int = @currentmemberyear -1 


UPDATE a
SET [SSB_CRMSYSTEM_SSID_Winner__c] = b.SSID
	,[a].[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] = b.SourceSystem
	,[PersonHomePhone] = b.PhoneHome
	,[PersonOtherPhone] = b.PhoneOther
	,[PersonEmail] = b.EmailOne
	,[PersonBirthdate] = b.Birthday
	
FROM [dbo].[Contact_Custom] a
INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON b.[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_Contact_ID__c]
INNER JOIN dbo.[vwDimCustomer_ModAcctId] c ON b.[DimCustomerId] = c.[DimCustomerId] AND c.SSB_CRMSYSTEM_PRIMARY_FLAG = 1

EXEC  [dbo].[sp_CRMLoad_Contact_ProcessLoad_Criteria]


-- For Last_Ticket_Purchase_Date
UPDATE a
SET [SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c]= p.Ticket_Date
FROM [dbo].[Contact_Custom] a (NOLOCK)
INNER JOIN (SELECT [dc].[SSB_CRMSYSTEM_Contact_ID],  MAX(dd.CalDate) AS Ticket_Date 
			FROM Oregon.[ro].[vw_FactTicketSales_All] fts
			INNER JOIN dbo.[vwDimCustomer_ModAcctId] dc ON dc.SourceSystem = 'TM' AND fts.ETL__SSID_TM_acct_id = dc.AccountId and dc.CustomerType = 'Primary'
			INNER JOIN [Oregon].dbo.dimdate dd ON dd.dimdateid = fts.DimDateId
			GROUP BY [dc].[SSB_CRMSYSTEM_Contact_ID]) p
ON p.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c] 


-- For Last_Donation_Date
UPDATE a
SET [SSB_CRMSYSTEM_Last_Donation_Date__c]= p.Don_Date
FROM [dbo].[Contact_Custom] a (NOLOCK)
INNER JOIN (SELECT [dc].[SSB_CRMSYSTEM_Contact_ID],  MAX(CAST(d.donation_paid_datetime AS DATE)) AS Don_Date 
			FROM Oregon.[ods].[TM_Donation] d (NOLOCK)
			INNER JOIN dbo.[vwDimCustomer_ModAcctId] dc ON dc.SourceSystem = 'TM' AND d.acct_id = dc.AccountId and dc.CustomerType = 'Primary'
			GROUP BY [dc].[SSB_CRMSYSTEM_Contact_ID]) p
ON p.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c] 


--Customer Type--
UPDATE a
SET a.[SSB_CRMSYSTEM_Customer_Type__c] = cust.acct_type_desc
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
	INNER JOIN dbo.[vwDimCustomer_ModAcctId] b WITH (NOLOCK) ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID__c
	JOIN Oregon.ods.TM_Cust cust WITH (NOLOCK) on cust.acct_id = b.AccountId AND b.SourceSystem = 'TM' and b.CustomerType = 'Primary'
where b.SSB_CRMSYSTEM_PRIMARY_FLAG = 1

UPDATE a
SET [Football_Full__c] = 0 
 , [Football_Rookie__c] = 0
 , [Football_Partial__c] = 0 
 , [Men_s_Basketball_Full__c] = 0 
 , [Men_s_Basketball_Rookie__c] = 0 
 , [Men_s_Basketball_Partial__c] = 0 
 , [SSB_CRMSYSTEM_Donor_Warning__c] = 0 
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)



/***********************************
	--TM Attribute/Rep Fields-- added 7/20/2018 SSales
***********************************/
select m.SSB_CRMSYSTEM_CONTACT_ID,c.acct_id,c.Category,c.attrib_name,c.attrib_value,c.attrib_comment
INTO #attributes
--select count(*)
FROM Oregon.[ods].[TM_CustAttrib] c (NOLOCK)
JOIN Oregon.ods.TM_Cust tm (NOLOCK)
	ON tm.acct_id = c.acct_id AND tm.cust_name_id = c.cust_name_id
JOIN dbo.vwDimCustomer_ModAcctId m
	ON m.AccountId = tm.acct_id AND m.CustomerType = 'primary' AND m.SourceSystem = 'tm'
JOIN Oregon.ods.TM_CustRep rep (NOLOCK)
	ON rep.acct_id = m.AccountId AND m.CustomerType = 'primary' AND m.SourceSystem = 'tm' AND rep.acct_rep_type = 'f'
where 1=1
--AND acct_Id = '1405'
AND( Category = 'Current Points and Rank'
OR( Category = 'Lifetime Pledges and Payments' AND attrib_name = 'Payments:')
OR ( Category = 'Years of Purchase'))



UPDATE c
SET c.SSB_CRMSYSTEM_Football_YOP__c = CASE WHEN attrib_name = 'Football' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_MBB_YOP__c= CASE WHEN attrib_name = 'Mens Basketball' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_WBB_YOP__c= CASE WHEN attrib_name = 'Womens Basketball' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Volleyball_YOP__c = CASE WHEN attrib_name = 'Volleyball' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Track_YOP__c = CASE WHEN attrib_name = 'Track' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Softball_YOP__c = CASE WHEN attrib_name = 'Softball' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Baseball_YOP__c= CASE WHEN attrib_name = 'Baseball' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Total_Priority_Points__c = CASE WHEN attrib_name = 'Current Points' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Priority_Point_Rank__c= CASE WHEN attrib_name = 'Current Rank' THEN attrib_value ELSE NULL END,
	c.SSB_CRMSYSTEM_Lifetime_Giving__c= CASE WHEN attrib_name = 'Payments:' THEN attrib_value ELSE NULL END
FROM dbo.Contact_Custom c (NOLOCK)
JOIN #attributes a ON a.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_Contact_ID__c


SELECT m.SSB_CRMSYSTEM_CONTACT_ID,rep.acct_id, rep.rep_full_name
INTO   #custrep
FROM dbo.vwDimCustomer_ModAcctId m 
JOIN Oregon.ods.TM_CustRep rep (NOLOCK)
	ON rep.acct_id = m.AccountId AND m.CustomerType = 'primary' 
	AND m.SourceSystem = 'tm' AND rep.acct_rep_type = 'f' 
	AND m.SSB_CRMSYSTEM_PRIMARY_FLAG = 1



SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID,REPLACE(rep_full_name,'_','')rep_full_name
INTO   #reps
FROM #custrep


UPDATE c
SET SSB_CRMSYSTEM_Development_Owner__c= rep_full_name
FROM #reps r
JOIN dbo.Contact_Custom c (NOLOCK)
	ON c.SSB_CRMSYSTEM_Contact_ID__c = r.SSB_CRMSYSTEM_CONTACT_ID

GO
