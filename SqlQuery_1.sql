SELECT 
prd.Id,
prd.ProductMainImg,
prd.SKU,
prd.ProductName,
prd.CreatedAt,
prc.UpdatedAt,
prc.AvaiableStock,
prd.Price,
prc.ProductChannelStatus
FROM ProductChannel prc
JOIN Product prd ON prc.ProductId = prd.Id
JOIN Channel chn ON chn.Id = prc.ChannelId
WHERE chn.Id = 3 AND ProductChannelStatus = 'ACTIVE'
