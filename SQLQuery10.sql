CREATE VIEW vw_PatientAppointments AS
SELECT 
    A.AppointmentID, 
    A.AppDate, 
    A.AppTime, 
    P.FirstName + ' ' + P.LastName AS PatientName, 
    D.FirstName + ' ' + D.LastName AS DoctorName, 
    A.Status
FROM APPOINTMENT A
INNER JOIN PATIENT P ON A.PatientID = P.PatientID
INNER JOIN DOCTOR D ON A.DoctorID = D.DoctorID;
GO