with RFM_statistic as (select CustomerID, 
datediff(day,max(Purchase_Date),'2022-09-01') as Recency,
count(distinct(Purchase_Date)) as Frequency,
sum(GMV) as Monetary
from Customer_Transaction ct
group by CustomerID
having sum(GMV) > 0 and CustomerID != 0)

select A.*, concat([R score],[F score],[M score]) as RFM from (select CustomerID,
Recency,
ntile(4) over(order by Recency desc) as 'R score',
Frequency,
ntile(4) over(order by Frequency asc) as 'F score',
Monetary,
ntile(4) over(order by Monetary asc) as 'M score'
from RFM_statistic) A
