USE OMSDb
GO

SELECT odr.Region
		,COUNT(odr.Id) AS NumberOfOrders
		,SUM(odr.TotalPrice) AS TotalSales
FROM OrderList odr
WHERE odr.OrderedAt BETWEEN '2023-01-27 00:00:00.000' AND '2023-01-30 00:00:00.000'
GROUP BY odr.Region
ORDER BY TotalSales DESC