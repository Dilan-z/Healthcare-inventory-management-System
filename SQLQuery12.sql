CREATE PROCEDURE sp_AddNewPatient
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DOB DATE,
    @Gender CHAR(1),
    @NIC VARCHAR(15),
    @ContactNo VARCHAR(15),
    @BloodGroup VARCHAR(5)
AS
BEGIN
    INSERT INTO PATIENT (FirstName, LastName, DOB, Gender, NIC, ContactNo, BloodGroup)
    VALUES (@FirstName, @LastName, @DOB, @Gender, @NIC, @ContactNo, @BloodGroup);

    SELECT 'Patient Added Successfully' AS Result;
END;
GO