CREATE TRIGGER trg_UpdateAppointmentStatus
ON BILL
AFTER INSERT
AS
BEGIN
    UPDATE APPOINTMENT
    SET Status = 'Billed'
    FROM APPOINTMENT A
    INNER JOIN inserted i ON A.AppointmentID = i.AppointmentID;
END;
GO