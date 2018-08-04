SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [MERGEPROCESS_New].[vw_Cust_Account_ColumnLogic]
AS
SELECT  ID,
		Losing_ID AS Losing_ID ,					
        CAST(SUBSTRING(PersonTitle, 2, 82) AS nvarchar(80)) PersonTitle,
		ISNULL(CAST(SUBSTRING(PersonDoNotCall, 2, 1) AS BIT),0) PersonDoNotCall,
		ISNULL(CAST(SUBSTRING(PersonHasOptedOutOfEmail, 2, 1) AS BIT),0) PersonHasOptedOutOfEmail,
		ISNULL(CAST(SUBSTRING(Account_Flag__c, 2, 1) AS BIT),0) Account_Flag__c,
		CAST(SUBSTRING(Employer__c, 2, 82) AS nvarchar(80)) Employer__c,
		CAST(SUBSTRING([Description], 2, 3999) AS nvarchar(max)) [Description]
FROM    ( SELECT    Winning_ID AS ID ,
					Losing_ID AS Losing_ID ,					
                    MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND PersonTitle IS NOT NULL and Persontitle != ''
                             THEN '2' + CAST(PersonTitle AS VARCHAR(80))
                             WHEN dta.xtype = 'Losing'
                                  AND PersonTitle IS NOT NULL and Persontitle != ''
                             THEN '1' + CAST(PersonTitle AS VARCHAR(80))
                        END) PersonTitle,

					 MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND PersonDoNotCall IS NOT NULL AND	PersonDoNotCall != ''
                             THEN '2' + CAST(PersonDoNotCall AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND PersonDoNotCall IS NOT NULL AND PersonDoNotCall != ''
                             THEN '1' + CAST(PersonDoNotCall AS NVARCHAR(50))
                        END) PersonDoNotCall,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND PersonHasOptedOutOfEmail IS NOT NULL AND	PersonHasOptedOutOfEmail != ''
                             THEN '2' + CAST(PersonHasOptedOutOfEmail AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND PersonHasOptedOutOfEmail IS NOT NULL AND PersonHasOptedOutOfEmail != ''
                             THEN '1' + CAST(PersonHasOptedOutOfEmail AS NVARCHAR(50))
                        END) PersonHasOptedOutOfEmail,
					
					 MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Account_Flag__c IS NOT NULL AND	Account_Flag__c != ''
                             THEN '2' + CAST(Account_Flag__c AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND Account_Flag__c IS NOT NULL AND Account_Flag__c != ''
                             THEN '1' + CAST(Account_Flag__c AS NVARCHAR(50))
                        END) Account_Flag__c,
						
					  MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Employer__c IS NOT NULL and Employer__c != ''
                             THEN '2' + CAST(PersonTitle AS VARCHAR(80))
                             WHEN dta.xtype = 'Losing'
                                  AND Employer__c IS NOT NULL and Employer__c != ''
                             THEN '1' + CAST(Employer__c AS VARCHAR(80))
                        END) Employer__c,

						MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND [Description]	 IS NOT NULL and [Description] != ''
                             THEN '2' + CAST([Description]	 AS VARCHAR(max))
                             WHEN dta.xtype = 'Losing'
                                  AND [Description]	 IS NOT NULL and [Description] != ''
                             THEN '1' + CAST([Description]	AS VARCHAR(max))
                        END) [Description]
											                    
FROM      ( SELECT    *
            FROM      ( SELECT    'Winning' xtype ,
                                a.Winning_ID ,
								a.Losing_ID ,					
                                b.*
                        FROM      [MERGEPROCESS_New].[Queue] a
                                JOIN Prodcopy.vw_Account b ON a.Winning_ID = b.ID
                        UNION ALL
                        SELECT    'Losing' xtype ,
                                a.Winning_ID ,
								a.Losing_ID ,					
                                b.*
                        FROM      [MERGEPROCESS_New].[Queue] a
                                JOIN Prodcopy.vw_Account b ON a.Losing_ID = b.ID
                    ) x
        ) dta

GROUP BY  Winning_ID ,
		Losing_ID					
        ) aa

;



GO
