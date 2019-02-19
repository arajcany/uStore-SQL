SELECT
  'Value' = S.StoreID,
  'Name' = SC.Name,
  'Selected' = 0
FROM
  Store S
    join Store_Culture SC on (S.StoreID = SC.StoreID and SC.CultureID = dbo.fn_StoreSetupCulture(S.StoreID))
    JOIN fn_UserStores(@ActiveUserId, 12) US ON S.StoreID = us.StoreId
WHERE
  S.StatusID <> 2
ORDER BY
  Name
