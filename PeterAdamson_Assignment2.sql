--Author Peter Adamson

--Question 1
Select *
from CUSTOMER_T
Where CUSTOMERSTATE like 'N%' or CUSTOMERSTATE like 'C%'
order by CUSTOMERSTATE;

--Question 2
Select ORDERDATE, ORDERID, SALESPERSONNAME
FROM ORDER_T o, SALESPERSON_T s
where o.SALESPERSONID = s.SALESPERSONID
order by ORDERDATE;

--Question 3
Select distinct c.CUSTOMERNAME as CUSTOMERS
from CUSTOMER_T c, ORDER_T o, SALESPERSON_T
where c.CUSTOMERID = o.SALESPERSONID and o.CUSTOMERID = 4;

--Question 4
Select distinct c.CUSTOMERNAME as CUSTOMERS, o.SALESPERSONID
from CUSTOMER_T c, ORDER_T o, SALESPERSON_T
where c.CUSTOMERID = o.SALESPERSONID and o.CUSTOMERID = 4
order by c.CUSTOMERNAME desc;

--Question 5
select sum(pr.PRODUCTSTANDARDPRICE), PRODUCTLINENAME
from PRODUCT_T pr, PRODUCTLINE_T pl
where pr.PRODUCTLINEID = pl.PRODUCTLINEID 
group by PRODUCTLINENAME
having sum(PRODUCTSTANDARDPRICE) > 1000
order by pl.PRODUCTLINENAME desc;

--Question 6
Select CUSTOMERNAME, ORDERDATE
from CUSTOMER_T cu, ORDER_T o
where cu.CUSTOMERID = o.CUSTOMERID
and extract(day from o.ORDERDATE) <= 15
order by ORDERDATE;

--Question 7
CREATE TABLE orderBK
AS(Select *
  From ORDER_T WHERE 1=2);
  
CREATE OR REPLACE PROCEDURE orderBackUp(cid int)
IS
  orderRec ORDER_T%rowtype;
  CURSOR orderCurs IS 
    Select * 
    from ORDER_T
    where CUSTOMERID = cid;
BEGIN
  for orderRec in orderCurs
  LOOP
    insert into orderBK(ORDERID, CUSTOMERID, ORDERDATE, FULFILLMENTDATE, SALESPERSONID, SHIPADRSID)
    values (orderrec.ORDERID, orderrec.CUSTOMERID, orderrec.ORDERDATE, orderrec.FULFILLMENTDATE, orderrec.SALESPERSONID, orderrec.SHIPADRSID);
  END LOOP;
END;

--Testing Question 7
DECLARE
cid int;
BEGIN
cid := 4;
orderBackUp(cid);
end;

Select *
from orderBK;
