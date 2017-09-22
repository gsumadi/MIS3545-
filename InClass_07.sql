USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */

select OrderDate, SUM(totaldue) as Daily_Amount, 
COUNT(SalesOrderID) as Number_of_Orders
From Sales.SalesOrderHeader
Group By OrderDate
Order by SUM(totaldue) DESC; 

/*2, Display the total amount collected from selling the products, FROM 700 to 800. Also Order by most popular product, 
then more than 3000 units*/
SELECT ProductID, sum(LineTotal) as Total_Amount, 
AVG(UnitPrice) as Avg_Unit_Price,
MAX(UnitPrice) as Max_Unit_Price,
MIN(UnitPrice) as Min_Unit_Price, 
SUM(OrderQty) as Total_Number_Units_Sold
FROM Sales.SalesOrderDetail
WHERE ProductID Between 700 and 800
Group By ProductID
HAVING SUM(OrderQty) > 3000
Order by SUM(OrderQty) DESC;
 
/*3, Write a query to display the sales person BusinessEntityID, last name and first name of ALL the sales persons
and the name of the territory to which they belong. Even though they dont belong to any territories*/
SELECT SP.BusinessEntityID,
		 P.FirstName, 
		 P.LastName, 
		 ST.Name as Territory 
FROM Sales.SalesPerson as SP
FULL OUTER JOIN Sales.SalesTerritory  as ST
ON SP.TerritoryID = ST.TerritoryID
JOIN Person.Person as P 
ON SP.BusinessEntityID = P.BusinessEntityID; 


/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
Select s.BusinessEntityID, p.CardType, r.CreditCardID 
From Person.Person as S
Join Sales.PersonCreditCard as R
on s.BusinessEntityID=r.BusinessEntityID
Join Sales.CreditCard as P
on p.CreditCardID=r.CreditCardID
Where p.CardType='Vista';  


/*Show the number of customers for each type of credit cards*/
Select count(s.BusinessEntityID), p.CardType
From Person.Person as S
Join Sales.PersonCreditCard as R
on s.BusinessEntityID=r.BusinessEntityID
Join Sales.CreditCard as P
on p.CreditCardID=r.CreditCardID
Group By p.CardType;


/*5, Write a query to display ALL (outer join) the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory; then include nulls*/
SELECT CR.CountryRegionCode,
		CR.Name as Country_Region_Name,
		ST.TerritoryID,
		ST.Name as Territory
FROM Sales.SalesTerritory as ST
Right outer join Person.CountryRegion as CR 
ON ST.CountryRegionCode = CR.CountryRegionCode
Where ST.TerritoryID is null;   /* this is what you need the right order join for*/ 



/*6, Find out the average of the total dues of all the orders.*/
Select AVG(TotalDue) 
FROM sales.SalesOrderHeader; 

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of 
the total dues of all the orders*/
Select SalesOrderID, TotalDue
FROM sales.SalesOrderHeader 
Where TotalDue > 
		(
		Select AVG(TotalDue) 
		FROM sales.SalesOrderHeader
		);