USE uStore

DECLARE @StoreID as int
SET @StoreID = 0


SELECT Product.StoreID,
       Product_Culture.ProductID,
       Product.StatusID,
       ProductGroup_Culture.Name AS [Category Name],
       Product_Culture.Name,
       Product_Culture.ShortDescription,
       Product_Culture.KeyWords,
       PrepressWorkflow.PrepressWorkflowName,
       Product.DefaultPrepressWorkflowID,
       Product.IsPrepressAutoRun
FROM Product_Culture FULL
     OUTER JOIN Product ON Product_Culture.ProductID = Product.ProductID FULL
                           OUTER JOIN ProductGroupMembership ON Product.ProductID = ProductGroupMembership.ProductID FULL
                           OUTER JOIN ProductGroup_Culture
                           ON ProductGroupMembership.ProductGroupID = ProductGroup_Culture.ProductGroupID FULL
                           OUTER JOIN ProductPrepressWorkflow ON Product.ProductID = ProductPrepressWorkflow.ProductID FULL
                           OUTER JOIN PrepressWorkflow ON ProductPrepressWorkflow.PrepressWorkflowID = PrepressWorkflow.PrepressWorkflowID
WHERE (Product.StoreID = @StoreID)
  AND (Product.StatusID NOT IN (2))
  AND PrepressWorkflow.PrepressWorkflowName IS NULL
ORDER BY ProductGroup_Culture.ProductGroupID, ProductGroupMembership.DisplayOrder, Product.StatusID,
         Product_Culture.ProductID;


