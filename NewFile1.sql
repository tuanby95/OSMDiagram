SELECT
prd.ProductMainImg,
prd.ProductName,
prd.SKU,
prd.Barcode,
odt.Quantity,
prd.Price AS PerProductPrice,
(odt.Quantity * prd.Price) as TotalPerProductPrice,
odl.RecipientName,
odl.RecipientPhoneNumber,
odl.ShippingAddress
FROM OrderList AS odl
JOIN OrderDetail AS odt ON odl.Id = odt.OrderId
JOIN Product AS prd ON odt.ProductId = prd.Id
WHERE odl.Id = 1
