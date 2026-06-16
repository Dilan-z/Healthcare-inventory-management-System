CREATE PROCEDURE sp_GetBranchRevenueSummary
AS
BEGIN
    SELECT 
        B.BranchName, 
        SUM(BL.TotalAmount) AS TotalRevenue,
        COUNT(A.AppointmentID) AS TotalAppointments
    FROM BRANCH B
    INNER JOIN APPOINTMENT A ON B.BranchID = A.BranchID
    INNER JOIN BILL BL ON A.AppointmentID = BL.AppointmentID
    GROUP BY B.BranchName
    ORDER BY TotalRevenue DESC;
END;
GO