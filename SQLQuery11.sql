CREATE VIEW vw_LowStockMedicines AS
SELECT 
    M.MedicineID, 
    M.MedicineName, 
    M.ReorderLevel, 
    ISNULL(SUM(I.Quantity), 0) AS TotalStock
FROM MEDICINE M
LEFT JOIN INVENTORY I ON M.MedicineID = I.MedicineID
GROUP BY M.MedicineID, M.MedicineName, M.ReorderLevel
HAVING ISNULL(SUM(I.Quantity), 0) <= M.ReorderLevel;
GO