/**
	Find the Proof/Process output type (e.g. PDF/JPG/PNG) for a given uStore Product
 */

USE uStore

DECLARE @StoreID as int
SET @StoreID = NULL --set as NULL (all stores) or an INT of the Store ID

IF OBJECT_ID('tempdb..#tmp_tickets') IS NOT NULL
DROP TABLE #tmp_tickets;

SELECT [DocID],
       [Doc].[StoreID],
       [Doc].[ProductID]                                    as [uStore Product ID],
       Product.ModifiedDate,
       [Name],
       [CampaignID]                                         as [uProduce Campaign ID],
       [UProduceDocID]                                      as [uProduce Document ID],
       [DocTypeID],
       [UProduceProofReferenceJobID]                        as ProofID,
       [UProduceProductionReferenceJobID]                   as ProcessID,
       convert(xml, replace([ProofTicket], '&', '&amp;'))   as [ProofTicket],
       convert(xml, replace([ProcessTicket], '&', '&amp;')) as [ProcessTicket],
       [ThumbnailTypeId],
       [ThumbnailJobId]
       INTO
       #tmp_tickets
FROM [uStore].[dbo].[Doc]
     LEFT JOIN Product on [uStore].[dbo].[Product].ProductID = [uStore].[dbo].[Doc].ProductID
WHERE DocTypeID = 1 --uProduce Document
  AND [Doc].StoreID >=
  CASE
  WHEN @StoreID IS NULL OR @StoreID = 0 THEN 0
  ELSE @StoreID
END
  AND [Doc].StoreID <=
  CASE
  WHEN @StoreID IS NULL OR @StoreID = 0 THEN 100000000000000
  ELSE @StoreID
END;


SELECT [StoreID],
       [uStore Product ID],
       [ModifiedDate],
       [Name],
       [uProduce Campaign ID],
       [uProduce Document ID],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        --,[DocTypeID]
       ProofID,
       ProcessID,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     --proof properties
       [#tmp_tickets].[ProofTicket].value('(/XMPIE_PARAMS/OUTPUT/@TYPE)[1]', 'varchar(100)')                         as [PROOF_TYPE],
       [#tmp_tickets].[ProofTicket].value('(/XMPIE_PARAMS/OUTPUT/PARAM[@NAME="JPG_RES"]/@VALUE)[1]',
                                          'varchar(100)')                                                            as [PROOF_RESOLUTION],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           --process properties
       [#tmp_tickets].[ProcessTicket].value('(/XMPIE_PARAMS/OUTPUT/@TYPE)[1]',
                                            'varchar(100)')                                                          as [PROCESS_TYPE]
FROM #tmp_tickets
ORDER BY [StoreID] ASC,
         [uStore Product ID] ASC;

