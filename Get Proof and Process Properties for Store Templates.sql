/**
	Find the Proof/Process output type (e.g. PDF/JPG/PNG) for a given uStore Product
 */

USE uStore

DECLARE @StoreID as int
SET @StoreID = 13

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
	AND [Doc].StoreID = @StoreID;


SELECT [StoreID],
			 [uStore Product ID],
			 [ModifiedDate],
			 [Name],
			 [uProduce Campaign ID],
			 [uProduce Document ID],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        --,[DocTypeID]
			 ProofID,
			 ProcessID,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     --proof properties
			 [#tmp_tickets].[ProofTicket].value('(/XMPIE_PARAMS/OUTPUT/@TYPE)[1]', 'varchar(100)')													as [PROOF_TYPE],
			 [#tmp_tickets].[ProofTicket].value('(/XMPIE_PARAMS/OUTPUT/PARAM[@NAME="JPG_RES"]/@VALUE)[1]', 'varchar(100)')  as [PROOF_RESOLUTION],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           --process properties
			 [#tmp_tickets].[ProcessTicket].value('(/XMPIE_PARAMS/OUTPUT/@TYPE)[1]', 'varchar(100)') 											  as [PROCESS_TYPE]
FROM #tmp_tickets
ORDER BY [uStore Product ID] ASC;
