SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [MERGEPROCESS_New].[PreMerge]
	AS 
Declare @LogDate datetime = (Select getdate())

INSERT INTO MERGEPROCESS_New.LogPreMergeAccount
(
	FK_MergeID
	,ObjectType
	,MergeRecordType
	,LogDate
--update with prodcopy fields
,Id,	IsDeleted,	MasterRecordId,	Name,	LastName,	FirstName,	Salutation,	Type,	RecordTypeId,	ParentId,	BillingStreet,	BillingCity,	BillingState,	BillingPostalCode,	BillingCountry,	BillingLatitude,	BillingLongitude,	BillingGeocodeAccuracy,	BillingAddress,	ShippingStreet,	ShippingCity,	ShippingState,	ShippingPostalCode,	ShippingCountry,	ShippingLatitude,	ShippingLongitude,	ShippingGeocodeAccuracy,	ShippingAddress,	Phone,	Fax,	Website,	PhotoUrl,	Industry,	AnnualRevenue,	NumberOfEmployees,	Description,	OwnerId,	CreatedDate,	CreatedById,	LastModifiedDate,	LastModifiedById,	SystemModstamp,	LastActivityDate,	LastViewedDate,	LastReferencedDate,	PersonContactId,	IsPersonAccount,	PersonMailingStreet,	PersonMailingCity,	PersonMailingState,	PersonMailingPostalCode,	PersonMailingCountry,	PersonMailingLatitude,	PersonMailingLongitude,	PersonMailingGeocodeAccuracy,	PersonMailingAddress,	PersonOtherStreet,	PersonOtherCity,	PersonOtherState,	PersonOtherPostalCode,	PersonOtherCountry,	PersonOtherLatitude,	PersonOtherLongitude,	PersonOtherGeocodeAccuracy,	PersonOtherAddress,	PersonMobilePhone,	PersonHomePhone,	PersonOtherPhone,	PersonAssistantPhone,	PersonEmail,	PersonTitle,	PersonDepartment,	PersonAssistantName,	PersonLeadSource,	PersonBirthdate,	PersonLastCURequestDate,	PersonLastCUUpdateDate,	PersonEmailBouncedReason,	PersonEmailBouncedDate,	Jigsaw,	JigsawCompanyId,	AccountSource,	SicDesc,	Full_Account_ID__c,	Business_Email__c,	Employer__c,	Reasons_Why_Bought__c,	Men_s_Basketball_Partial__c,	Football_Partial__c,	Inactive__pc,	Secondary_Email__pc,	Full_Contact_ID__pc,	PersonHasOptedOutOfEmail,	PersonDoNotCall,	Account_Flag__c,	Account_Warning__c,	Business_Other_Phone__c,	Football_Full__c,	Football_Rookie__c,	Men_s_Basketball_Full__c,	Men_s_Basketball_Rookie__c,	Patron_ID__c,	Full_PA_Contact_ID__c,	StubHub_F15_Quantity_Purchased__c,	F15_StubHub_Spend__c,	F16_StubHub_Quantity_Purchased__c,	F16_StubHub_Spend__c,	B15_StubHub_Spend__c,	B15_StubHub_Quantity_Purchased__c,	B16_StubHub_Quantity_Purchased__c,	B16_StubHub_Spend__c,	F15_StubHub_Quantity_sold__c,	F15_StubHub_Amount_Sold__c,	F16_StubHub_Quantity_Sold__c,	F16_StubHub_Amount_Sold__c,	B15_StubHub_Quantity_Sold__c,	B15_StubHub_Amount_Sold__c,	B16_StubHub_Quantity_Sold__c,	B16_StubHub_Amount_Sold__c,	Oregon_Alum_Spouse__pc,	Oregon_Alum__pc,	Oregon_Grad_Year_Spouse__pc,	Oregon_Grad_Year__pc,	Oregon_Student_Athlete__pc,	Oregon_Student_Athlete_Spouse__pc,	copyloaddate,	SSB_CRMSYSTEM_ACCT_ID__c,	SSB_CRMSYSTEM_CONTACT_ID__c,	SSB_CRMSYSTEM_SSID_Winner__c,	SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c,	SSB_CRMSYSTEM_Priority_Point_Rank__c,	SSB_CRMSYSTEM_Total_Priority_Points__c,	Suffix__c,	SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,	SSB_CRMSYSTEM_Last_Donation_Date__c,	SSB_CRMSYSTEM_DimCustomerID__c,	SSB_CRMSYSTEM_Donor_Warning__c,	SSB_CRMSYSTEM_SSID_TIX__c,	SSB_CRMSYSTEM_Customer_Type__c,	SSB_CRMSYSTEM_Development_Owner__c
)
Select a.FK_MergeID,ObjectType, 'Winning' MergeRecordType, @LogDate LogDate
--update with prodcopy fields
,Id,	IsDeleted,	MasterRecordId,	Name,	LastName,	FirstName,	Salutation,	Type,	RecordTypeId,	ParentId,	BillingStreet,	BillingCity,	BillingState,	BillingPostalCode,	BillingCountry,	BillingLatitude,	BillingLongitude,	BillingGeocodeAccuracy,	BillingAddress,	ShippingStreet,	ShippingCity,	ShippingState,	ShippingPostalCode,	ShippingCountry,	ShippingLatitude,	ShippingLongitude,	ShippingGeocodeAccuracy,	ShippingAddress,	Phone,	Fax,	Website,	PhotoUrl,	Industry,	AnnualRevenue,	NumberOfEmployees,	Description,	OwnerId,	CreatedDate,	CreatedById,	LastModifiedDate,	LastModifiedById,	SystemModstamp,	LastActivityDate,	LastViewedDate,	LastReferencedDate,	PersonContactId,	IsPersonAccount,	PersonMailingStreet,	PersonMailingCity,	PersonMailingState,	PersonMailingPostalCode,	PersonMailingCountry,	PersonMailingLatitude,	PersonMailingLongitude,	PersonMailingGeocodeAccuracy,	PersonMailingAddress,	PersonOtherStreet,	PersonOtherCity,	PersonOtherState,	PersonOtherPostalCode,	PersonOtherCountry,	PersonOtherLatitude,	PersonOtherLongitude,	PersonOtherGeocodeAccuracy,	PersonOtherAddress,	PersonMobilePhone,	PersonHomePhone,	PersonOtherPhone,	PersonAssistantPhone,	PersonEmail,	PersonTitle,	PersonDepartment,	PersonAssistantName,	PersonLeadSource,	PersonBirthdate,	PersonLastCURequestDate,	PersonLastCUUpdateDate,	PersonEmailBouncedReason,	PersonEmailBouncedDate,	Jigsaw,	JigsawCompanyId,	AccountSource,	SicDesc,	Full_Account_ID__c,	Business_Email__c,	Employer__c,	Reasons_Why_Bought__c,	Men_s_Basketball_Partial__c,	Football_Partial__c,	Inactive__pc,	Secondary_Email__pc,	Full_Contact_ID__pc,	PersonHasOptedOutOfEmail,	PersonDoNotCall,	Account_Flag__c,	Account_Warning__c,	Business_Other_Phone__c,	Football_Full__c,	Football_Rookie__c,	Men_s_Basketball_Full__c,	Men_s_Basketball_Rookie__c,	Patron_ID__c,	Full_PA_Contact_ID__c,	StubHub_F15_Quantity_Purchased__c,	F15_StubHub_Spend__c,	F16_StubHub_Quantity_Purchased__c,	F16_StubHub_Spend__c,	B15_StubHub_Spend__c,	B15_StubHub_Quantity_Purchased__c,	B16_StubHub_Quantity_Purchased__c,	B16_StubHub_Spend__c,	F15_StubHub_Quantity_sold__c,	F15_StubHub_Amount_Sold__c,	F16_StubHub_Quantity_Sold__c,	F16_StubHub_Amount_Sold__c,	B15_StubHub_Quantity_Sold__c,	B15_StubHub_Amount_Sold__c,	B16_StubHub_Quantity_Sold__c,	B16_StubHub_Amount_Sold__c,	Oregon_Alum_Spouse__pc,	Oregon_Alum__pc,	Oregon_Grad_Year_Spouse__pc,	Oregon_Grad_Year__pc,	Oregon_Student_Athlete__pc,	Oregon_Student_Athlete_Spouse__pc,	copyloaddate,	SSB_CRMSYSTEM_ACCT_ID__c,	SSB_CRMSYSTEM_CONTACT_ID__c,	SSB_CRMSYSTEM_SSID_Winner__c,	SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c,	SSB_CRMSYSTEM_Priority_Point_Rank__c,	SSB_CRMSYSTEM_Total_Priority_Points__c,	Suffix__c,	SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,	SSB_CRMSYSTEM_Last_Donation_Date__c,	SSB_CRMSYSTEM_DimCustomerID__c,	SSB_CRMSYSTEM_Donor_Warning__c,	SSB_CRMSYSTEM_SSID_TIX__c,	SSB_CRMSYSTEM_Customer_Type__c,	SSB_CRMSYSTEM_Development_Owner__c
FROM MERGEPROCESS_New.Queue a with (nolock)
JOIN mergeprocess_new.tmp_pcaccount b with (nolock)
	ON a.Winning_ID = b.ID
UNION ALL
Select a.FK_MergeID,ObjectType, 'Losing' MergeRecordType, @LogDate LogDate
--update with prodcopy fields
,Id,	IsDeleted,	MasterRecordId,	Name,	LastName,	FirstName,	Salutation,	Type,	RecordTypeId,	ParentId,	BillingStreet,	BillingCity,	BillingState,	BillingPostalCode,	BillingCountry,	BillingLatitude,	BillingLongitude,	BillingGeocodeAccuracy,	BillingAddress,	ShippingStreet,	ShippingCity,	ShippingState,	ShippingPostalCode,	ShippingCountry,	ShippingLatitude,	ShippingLongitude,	ShippingGeocodeAccuracy,	ShippingAddress,	Phone,	Fax,	Website,	PhotoUrl,	Industry,	AnnualRevenue,	NumberOfEmployees,	Description,	OwnerId,	CreatedDate,	CreatedById,	LastModifiedDate,	LastModifiedById,	SystemModstamp,	LastActivityDate,	LastViewedDate,	LastReferencedDate,	PersonContactId,	IsPersonAccount,	PersonMailingStreet,	PersonMailingCity,	PersonMailingState,	PersonMailingPostalCode,	PersonMailingCountry,	PersonMailingLatitude,	PersonMailingLongitude,	PersonMailingGeocodeAccuracy,	PersonMailingAddress,	PersonOtherStreet,	PersonOtherCity,	PersonOtherState,	PersonOtherPostalCode,	PersonOtherCountry,	PersonOtherLatitude,	PersonOtherLongitude,	PersonOtherGeocodeAccuracy,	PersonOtherAddress,	PersonMobilePhone,	PersonHomePhone,	PersonOtherPhone,	PersonAssistantPhone,	PersonEmail,	PersonTitle,	PersonDepartment,	PersonAssistantName,	PersonLeadSource,	PersonBirthdate,	PersonLastCURequestDate,	PersonLastCUUpdateDate,	PersonEmailBouncedReason,	PersonEmailBouncedDate,	Jigsaw,	JigsawCompanyId,	AccountSource,	SicDesc,	Full_Account_ID__c,	Business_Email__c,	Employer__c,	Reasons_Why_Bought__c,	Men_s_Basketball_Partial__c,	Football_Partial__c,	Inactive__pc,	Secondary_Email__pc,	Full_Contact_ID__pc,	PersonHasOptedOutOfEmail,	PersonDoNotCall,	Account_Flag__c,	Account_Warning__c,	Business_Other_Phone__c,	Football_Full__c,	Football_Rookie__c,	Men_s_Basketball_Full__c,	Men_s_Basketball_Rookie__c,	Patron_ID__c,	Full_PA_Contact_ID__c,	StubHub_F15_Quantity_Purchased__c,	F15_StubHub_Spend__c,	F16_StubHub_Quantity_Purchased__c,	F16_StubHub_Spend__c,	B15_StubHub_Spend__c,	B15_StubHub_Quantity_Purchased__c,	B16_StubHub_Quantity_Purchased__c,	B16_StubHub_Spend__c,	F15_StubHub_Quantity_sold__c,	F15_StubHub_Amount_Sold__c,	F16_StubHub_Quantity_Sold__c,	F16_StubHub_Amount_Sold__c,	B15_StubHub_Quantity_Sold__c,	B15_StubHub_Amount_Sold__c,	B16_StubHub_Quantity_Sold__c,	B16_StubHub_Amount_Sold__c,	Oregon_Alum_Spouse__pc,	Oregon_Alum__pc,	Oregon_Grad_Year_Spouse__pc,	Oregon_Grad_Year__pc,	Oregon_Student_Athlete__pc,	Oregon_Student_Athlete_Spouse__pc,	copyloaddate,	SSB_CRMSYSTEM_ACCT_ID__c,	SSB_CRMSYSTEM_CONTACT_ID__c,	SSB_CRMSYSTEM_SSID_Winner__c,	SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c,	SSB_CRMSYSTEM_Priority_Point_Rank__c,	SSB_CRMSYSTEM_Total_Priority_Points__c,	Suffix__c,	SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,	SSB_CRMSYSTEM_Last_Donation_Date__c,	SSB_CRMSYSTEM_DimCustomerID__c,	SSB_CRMSYSTEM_Donor_Warning__c,	SSB_CRMSYSTEM_SSID_TIX__c,	SSB_CRMSYSTEM_Customer_Type__c,	SSB_CRMSYSTEM_Development_Owner__c
FROM MERGEPROCESS_New.Queue a with (nolock)
JOIN mergeprocess_new.tmp_pcaccount b with (nolock)
	ON a.Losing_ID = b.ID



GO
