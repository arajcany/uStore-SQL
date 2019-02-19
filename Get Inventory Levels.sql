USE uStore

DECLARE @StoreID as int
SET @StoreID = 0

DECLARE @ActiveUserId as int
SET @ActiveUserId = 0


SELECT SC.StoreID                                                                                          AS 'StoreID',
       SC.Name                                                                                             AS 'StoreName',
       P.ProductID                                                                                         AS 'Product ID',
       PC.Name                                                                                             AS 'Product Name',
       P.ExternalID                                                                                        AS 'External ID',
       PrIn.InventoryQuantity                                                                              AS 'On-shelf Inventory',
       prIn.Comments                                                                                       as 'Comment',
       PrIn.SafetyQuantity                                                                                 AS 'Safety Inventory',
       PrIn.InventoryQuantity - PrIn.SafetyQuantity                                                        AS 'Storefront Inventory',
       dbo.fn_GetProductUnitName(1, P.ProductUnitID, dbo.fn_StoreSetupCulture(SC.StoreID)) + CASE
                                                                                               WHEN
                                                                                                   dbo.fn_GetProductUnitConversionString(
                                                                                                       P.ProductUnitID,
                                                                                                       dbo.fn_StoreSetupCulture(SC.StoreID)) <>
                                                                                                   '' THEN ' (' +
                                                                                                           dbo.fn_GetProductUnitConversionString(
                                                                                                               P.ProductUnitID,
                                                                                                               dbo.fn_StoreSetupCulture(SC.StoreID)) +
                                                                                                           ')'
                                                                                               ELSE '' END AS 'Units of Measure'
FROM ProductInventory PrIn
       JOIN Product P on PrIn.ProductID = P.ProductID
       JOIN fn_UserStores(@ActiveUserId, 12) US ON P.StoreId = US.StoreId
       JOIN Store_Culture SC on P.StoreID = SC.StoreID AND SC.CultureID = dbo.fn_StoreSetupCulture(SC.StoreID)
       JOIN Product_Culture PC on P.ProductID = PC.ProductID AND PC.CultureID = dbo.fn_StoreSetupCulture(SC.StoreID)
WHERE PrIn.InventoryEnabled = 1
  AND P.StatusID NOT IN (0, 2)
  AND (P.StoreID = @StoreID OR @StoreID IS NULL OR @StoreID = '')