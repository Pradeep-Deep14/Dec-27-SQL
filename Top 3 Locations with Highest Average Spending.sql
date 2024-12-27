CREATE TABLE locations (
         location_id INT, 
         location_name VARCHAR(100)
     );
     CREATE TABLE purchases (
         purchase_id INT, 
         location_id INT, 
         amount DECIMAL(10, 2), 
         purchase_date DATE
     );
     INSERT INTO locations VALUES 
         (1, 'New York'), 
         (2, 'Los Angeles'), 
         (3, 'Chicago'), 
         (4, 'Houston');
     INSERT INTO purchases VALUES 
         (1, 1, 200.00, '2023-01-15'), 
         (2, 1, 300.00, '2023-02-20'), 
         (3, 2, 250.00, '2023-03-05'), 
         (4, 2, 150.00, '2023-04-11'), 
         (5, 3, 300.00, '2023-06-21'), 
         (6, 4, 500.00, '2023-05-30'), 
         (7, 1, 100.00, '2023-03-12'), 
         (8, 3, 400.00, '2023-07-18');

SELECT * FROM LOCATIONS
SELECT * FROM PURCHASES


/*
List the top 3 locations with the highest average spending per transaction in the last year and the total number of transactions.
*/
--Approach 1

WITH CTE AS (
    SELECT 
        location_id,
        AVG(amount) AS average_spending,
        COUNT(*) AS total_number_of_transactions
    FROM purchases
    WHERE EXTRACT(YEAR FROM purchase_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
    GROUP BY location_id
)
SELECT 
    L.location_id,
    L.location_name,
    CTE.average_spending,
    CTE.total_number_of_transactions
FROM CTE
JOIN locations L
ON CTE.location_id = L.location_id
ORDER BY CTE.average_spending DESC
LIMIT 3;


--Approach 2

SELECT 
    l.location_id,
    l.location_name, 
    AVG(pu.amount) AS avg_spending, 
    COUNT(pu.purchase_id) AS total_transactions 
FROM 
    locations l 
JOIN 
    purchases pu 
ON 
    l.location_id = pu.location_id 
WHERE 
    pu.purchase_date >= CURRENT_DATE - INTERVAL '1 year' 
GROUP BY 
    l.location_id, l.location_name 
ORDER BY 
    avg_spending DESC 
LIMIT 3;

