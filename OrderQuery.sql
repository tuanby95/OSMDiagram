USE OMSDb
GO
;

WITH CTE AS
  (SELECT odr.OrderedAt ,
          odr.OrderStatus ,
          COUNT(odr.Id) AS NumberOfRows ,

     (SELECT SUM(tmp.TotalPrice)
      FROM [OrderList] tmp
      WHERE tmp.OrderedAt = odr.OrderedAt) AS TotalOrders
   FROM [OrderList] odr
   WHERE odr.OrderedAt BETWEEN '2023-01-27 00:00:00.000' AND '2023-01-30 23:59:00.000'
   GROUP BY odr.OrderedAt,
            odr.OrderStatus)

SELECT *
FROM CTE c
	PIVOT(SUM(c.NumberOfRows) FOR OrderStatus IN ([COMPLETED], [FAILED], [RETURN]))  as PIVOTED
 
--Lap danh sach order theo ngay va status de lay thong tin sau:
--Ngay, OrderStatus, SoRows tuong ung theo OrderStatus, TotalOrder Theo ngay tuong ung

