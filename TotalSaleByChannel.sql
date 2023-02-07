USE OMSDb
GO
--Total Sale By Channel
DECLARE @TotalSale float
SET @TotalSale =
  (SELECT SUM(odr.TotalPrice) AS TotalSale
   FROM [OrderList] odr
   WHERE odr.OrderedAt BETWEEN '2023-01-27 00:00:00.000' AND '2023-01-30 23:59:00.000' 
   )

SELECT chal.Id
	   ,chal.ChannelName
	   ,SUM(odr.TotalPrice) AS Total
	   ,ROUND((SUM(odr.TotalPrice)/@TotalSale) * 100,0) AS Percentages 
FROM  Channel chal
JOIN  [OrderList] odr ON chal.Id = odr.ChannelId
WHERE odr.OrderedAt BETWEEN '2023-01-27 00:00:00.000' AND '2023-01-30 23:59:00.000' 
GROUP BY chal.Id,
		 chal.ChannelName
;



