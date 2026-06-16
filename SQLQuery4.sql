USE HealthcareDB;
GO

-- 1. HOSPITAL Table Data
INSERT INTO HOSPITAL (HospitalName, Address, Phone, RegistrationNo) VALUES
('Asiri Central', 'Colombo 10', '0112684684', 'REG001'),
('Nawaloka Hospital', 'Colombo 02', '0112544444', 'REG002'),
('Lanka Hospitals', 'Narahenpita', '0115430000', 'REG003'),
('Durdans Hospital', 'Colombo 03', '0112140000', 'REG004'),
('Hemsworth Care', 'Kandy', '0812223333', 'REG005'),
('Green Cross Medical', 'Galle', '0912244555', 'REG006'),
('Sunrise Health', 'Kurunegala', '0372221111', 'REG007'),
('MediCare Center', 'Negombo', '0312233444', 'REG008'),
('Suwasewana Hospital', 'Anuradhapura', '0252226677', 'REG009'),
('City Health', 'Gampaha', '0332225566', 'REG010');

-- 2. BRANCH Table Data
INSERT INTO BRANCH (BranchName, Address, HospitalID) VALUES
('Colombo Main', 'Colombo 10', 1),
('Nawaloka Negombo', 'Negombo', 2),
('Lanka Hosp Kandy', 'Kandy', 3),
('Durdans Kurunegala', 'Kurunegala', 4),
('Hemsworth Galle', 'Galle', 5),
('Green Cross Matara', 'Matara', 6),
('Sunrise Colombo', 'Colombo 05', 7),
('MediCare Gampaha', 'Gampaha', 8),
('Suwasewana Kandy', 'Kandy', 9),
('City Health Main', 'Gampaha', 10);

-- 3. DEPARTMENT Table Data
INSERT INTO DEPARTMENT (DeptName, DeptHead, BranchID) VALUES
('Cardiology', 'Dr. Perera', 1),
('Neurology', 'Dr. Silva', 2),
('Pediatrics', 'Dr. Fernando', 3),
('Orthopedics', 'Dr. Gunasekara', 4),
('Oncology', 'Dr. Jayasinghe', 5),
('Dermatology', 'Dr. Kumara', 6),
('Radiology', 'Dr. Bandara', 7),
('Pathology', 'Dr. Rajapaksha', 8),
('Gynaecology', 'Dr. Rathnayake', 9),
('ENT', 'Dr. Dissanayake', 10);

-- 4. DOCTOR Table Data
INSERT INTO DOCTOR (FirstName, LastName, Specialization, LicenseNo, DeptID, ConsultFee) VALUES
('Kamal', 'Perera', 'Cardiologist', 'LIC1001', 1, 2500.00),
('Nimal', 'Silva', 'Neurologist', 'LIC1002', 2, 3000.00),
('Sunil', 'Fernando', 'Pediatrician', 'LIC1003', 3, 2000.00),
('Ruwan', 'Gunasekara', 'Orthopedic Surgeon', 'LIC1004', 4, 3500.00),
('Anura', 'Jayasinghe', 'Oncologist', 'LIC1005', 5, 4000.00),
('Mahinda', 'Kumara', 'Dermatologist', 'LIC1006', 6, 2000.00),
('Saman', 'Bandara', 'Radiologist', 'LIC1007', 7, 2500.00),
('Ajith', 'Rajapaksha', 'Pathologist', 'LIC1008', 8, 2200.00),
('Namal', 'Rathnayake', 'Gynaecologist', 'LIC1009', 9, 2800.00),
('Wasantha', 'Dissanayake', 'ENT Specialist', 'LIC1010', 10, 2000.00);

-- 5. PATIENT Table Data
INSERT INTO PATIENT (FirstName, LastName, DOB, Gender, NIC, ContactNo, BloodGroup) VALUES
('Amila', 'Senanayake', '1990-05-14', 'M', '901234567V', '0771234567', 'O+'),
('Kasun', 'Kalhara', '1985-08-22', 'M', '852345678V', '0712345678', 'A+'),
('Nadun', 'Madushanka', '1992-11-30', 'M', '923456789V', '0783456789', 'B+'),
('Samanthi', 'Perera', '1988-02-15', 'F', '885432198V', '0724567890', 'AB+'),
('Nirosha', 'Kumari', '1995-07-10', 'F', '956789012V', '0755678901', 'O-'),
('Damith', 'Asanka', '1980-04-25', 'M', '801239876V', '0766789012', 'A-'),
('Tharindu', 'Heshan', '1998-09-18', 'M', '981234590V', '0777890123', 'B-'),
('Chamari', 'Athapaththu', '1990-12-05', 'F', '908765432V', '0718901234', 'AB-'),
('Gayan', 'Sandaruwan', '1987-03-28', 'M', '871234560V', '0729012345', 'O+'),
('Sanduni', 'Fernando', '1993-06-12', 'F', '935678901V', '0780123456', 'A+');

-- 6. APPOINTMENT Table Data
INSERT INTO APPOINTMENT (PatientID, DoctorID, BranchID, AppDate, AppTime, Status) VALUES
(1, 1, 1, '2026-06-20', '09:00', 'Completed'),
(2, 2, 2, '2026-06-20', '09:30', 'Completed'),
(3, 3, 3, '2026-06-20', '10:00', 'Completed'),
(4, 4, 4, '2026-06-21', '10:30', 'Completed'),
(5, 5, 5, '2026-06-21', '11:00', 'Completed'),
(6, 6, 6, '2026-06-22', '11:30', 'Completed'),
(7, 7, 7, '2026-06-22', '12:00', 'Scheduled'),
(8, 8, 8, '2026-06-23', '12:30', 'Scheduled'),
(9, 9, 9, '2026-06-23', '13:00', 'Scheduled'),
(10, 10, 10, '2026-06-24', '13:30', 'Scheduled');

-- 7. PRESCRIPTION Table Data
INSERT INTO PRESCRIPTION (AppointmentID, PrescribedDate, Status, PharmacistID) VALUES
(1, '2026-06-20', 'Dispensed', 1),
(2, '2026-06-20', 'Dispensed', 2),
(3, '2026-06-20', 'Dispensed', 3),
(4, '2026-06-21', 'Dispensed', 4),
(5, '2026-06-21', 'Dispensed', 5),
(6, '2026-06-22', 'Active', NULL),
(7, '2026-06-22', 'Active', NULL),
(8, '2026-06-23', 'Active', NULL),
(9, '2026-06-23', 'Active', NULL),
(10, '2026-06-24', 'Active', NULL);

-- 8. MEDICINE Table Data
INSERT INTO MEDICINE (MedicineName, GenericName, CategoryID, UnitPrice, ReorderLevel, DosageForm, Strength) VALUES
('Panadol', 'Paracetamol', 1, 5.00, 500, 'Tablet', '500mg'),
('Amoxil', 'Amoxicillin', 2, 25.00, 200, 'Capsule', '250mg'),
('Piriton', 'Chlorphenamine', 3, 10.00, 300, 'Tablet', '4mg'),
('Losartan', 'Losartan Potassium', 4, 15.00, 150, 'Tablet', '50mg'),
('Metformin', 'Metformin HCl', 5, 12.00, 400, 'Tablet', '500mg'),
('Atorvastatin', 'Atorvastatin', 6, 20.00, 250, 'Tablet', '20mg'),
('Omeprazole', 'Omeprazole', 7, 18.00, 350, 'Capsule', '20mg'),
('Salbutamol', 'Salbutamol', 8, 8.00, 100, 'Inhaler', '100mcg'),
('Ibuprofen', 'Ibuprofen', 1, 15.00, 300, 'Tablet', '400mg'),
('Cetirizine', 'Cetirizine HCl', 3, 12.00, 200, 'Tablet', '10mg');

-- 9. INVENTORY Table Data
INSERT INTO INVENTORY (BranchID, MedicineID, BatchNo, Quantity, ExpiryDate, CostPrice) VALUES
(1, 1, 'B001', 1000, '2027-12-31', 4.00),
(1, 2, 'B002', 500, '2028-05-30', 20.00),
(2, 3, 'B003', 800, '2027-10-15', 8.00),
(3, 4, 'B004', 400, '2028-01-20', 12.00),
(4, 5, 'B005', 1200, '2027-11-25', 10.00),
(5, 6, 'B006', 600, '2028-08-10', 16.00),
(6, 7, 'B007', 700, '2027-09-05', 15.00),
(7, 8, 'B008', 300, '2028-03-12', 6.00),
(8, 9, 'B009', 900, '2027-07-18', 12.00),
(9, 10, 'B010', 650, '2028-04-22', 10.00);

-- 10. SUPPLIER Table Data
INSERT INTO SUPPLIER (SupplierName, ContactPerson, Phone, Email) VALUES
('Hemas Pharmaceuticals', 'Ruwan', '0112345678', 'info@hemas.lk'),
('Morison PLC', 'Saman', '0112987654', 'sales@morison.lk'),
('State Pharmaceuticals', 'Nuwan', '0112444555', 'spc@gov.lk'),
('GlaxoSmithKline', 'David', '0112666777', 'contact@gsk.lk'),
('Sunshine Healthcare', 'Kamal', '0112888999', 'info@sunshine.lk'),
('Baur & Co', 'Nimal', '0112111222', 'med@baur.lk'),
('George Steuart Health', 'Ajith', '0112333444', 'health@gs.lk'),
('Emerchemie NB', 'Dasun', '0112555666', 'sales@emerchemie.lk'),
('Astron Ltd', 'Lahiru', '0112777888', 'info@astron.lk'),
('Ceylinco Healthcare', 'Pathum', '0112999000', 'contact@ceylinco.lk');

-- 11. PURCHASE_ORDER Table Data
INSERT INTO PURCHASE_ORDER (BranchID, SupplierID, OrderDate, Status, TotalAmount) VALUES
(1, 1, '2026-06-01', 'Delivered', 50000.00),
(2, 2, '2026-06-02', 'Delivered', 75000.00),
(3, 3, '2026-06-03', 'Pending', 40000.00),
(4, 4, '2026-06-04', 'Pending', 60000.00),
(5, 5, '2026-06-05', 'Delivered', 85000.00),
(6, 6, '2026-06-06', 'Pending', 45000.00),
(7, 7, '2026-06-07', 'Delivered', 55000.00),
(8, 8, '2026-06-08', 'Pending', 30000.00),
(9, 9, '2026-06-09', 'Delivered', 65000.00),
(10, 10, '2026-06-10', 'Pending', 90000.00);

-- 12. PO_ITEM Table Data
INSERT INTO PO_ITEM (POID, MedicineID, Quantity, UnitPrice) VALUES
(1, 1, 1000, 4.00),
(2, 2, 500, 20.00),
(3, 3, 800, 8.00),
(4, 4, 400, 12.00),
(5, 5, 1200, 10.00),
(6, 6, 600, 16.00),
(7, 7, 700, 15.00),
(8, 8, 300, 6.00),
(9, 9, 900, 12.00),
(10, 10, 650, 10.00);

-- 13. BILL Table Data
INSERT INTO BILL (AppointmentID, BillDate, ConsultFee, MedicineFee, TotalAmount, PaymentStatus) VALUES
(1, '2026-06-20', 2500.00, 500.00, 3000.00, 'Paid'),
(2, '2026-06-20', 3000.00, 1000.00, 4000.00, 'Paid'),
(3, '2026-06-20', 2000.00, 750.00, 2750.00, 'Paid'),
(4, '2026-06-21', 3500.00, 1200.00, 4700.00, 'Paid'),
(5, '2026-06-21', 4000.00, 800.00, 4800.00, 'Paid'),
(6, '2026-06-22', 2000.00, 0.00, 2000.00, 'Pending'),
(7, '2026-06-22', 2500.00, 0.00, 2500.00, 'Pending'),
(8, '2026-06-23', 2200.00, 0.00, 2200.00, 'Pending'),
(9, '2026-06-23', 2800.00, 0.00, 2800.00, 'Pending'),
(10, '2026-06-24', 2000.00, 0.00, 2000.00, 'Pending');

-- 14. ROLE Table Data
INSERT INTO ROLE (RoleName, AccessLevel) VALUES
('Admin', 5),
('Doctor', 4),
('Pharmacist', 3),
('Receptionist', 2),
('Nurse', 2),
('Accountant', 3),
('Inventory Manager', 4),
('Lab Technician', 3),
('Ward Boy', 1),
('Security', 1);

-- 15. STAFF Table Data
INSERT INTO STAFF (FirstName, LastName, RoleID, BranchID) VALUES
('Saman', 'Perera', 1, 1),
('Kamal', 'Silva', 3, 1),
('Nayana', 'Kumari', 4, 1),
('Ruwan', 'Fernando', 5, 2),
('Amila', 'Bandara', 6, 2),
('Kasun', 'Jayasinghe', 7, 3),
('Nimali', 'Rathnayake', 8, 3),
('Sunil', 'Gunasekara', 9, 4),
('Jagath', 'Dissanayake', 10, 4),
('Damith', 'Rajapaksha', 4, 5);