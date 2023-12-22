-- ZADANIE 1
-- wyrażenie CTE do znalezienia najwyższej stawki w historii płac pracownika
WITH EmployeeCTE AS (
    SELECT 
        e.BusinessEntityID AS EmployeeID,
        p.FirstName,
        p.LastName,
        MAX(ep.Rate) AS MaxRate
    FROM HumanResources.EmployeePayHistory ep
    INNER JOIN HumanResources.Employee e ON ep.BusinessEntityID = e.BusinessEntityID
    INNER JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    GROUP BY e.BusinessEntityID, p.FirstName, p.LastName
)

--tabela tymczasowej TempEmployeeInfo
SELECT 
    ec.EmployeeID,
    ec.FirstName,
    ec.LastName,
    ec.MaxRate
INTO TempEmployeeInfo
FROM EmployeeCTE ec
WHERE ec.MaxRate IS NOT NULL;


--zawartość tabeli tymczasowej TempEmployeeInfo
SELECT *
FROM TempEmployeeInfo;





-- ZADANIE 2
-- zapytanie wykorzystujące wyrażenie CTE, które wyświetli ID klienta, ID terytorium na którym prowadzi działalność, a także wyświetli imię i nazwisko salesperson powiązanej z danym Customer.TerritoryID
WITH CustomerCTE AS (
    SELECT 
        c.CustomerID,
        c.TerritoryID,
        CONCAT(p.FirstName, ' ', p.LastName) AS SalespersonFullName
    FROM Sales.Customer c
    INNER JOIN Sales.SalesTerritory st ON c.TerritoryID = st.TerritoryID
    LEFT JOIN Sales.SalesPerson sp ON st.TerritoryID = sp.TerritoryID
    LEFT JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
    LEFT JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
)

-- wyswietlenie tabeli
SELECT 
    cc.CustomerID,
    cc.TerritoryID,
    cc.SalespersonFullName
FROM CustomerCTE cc;