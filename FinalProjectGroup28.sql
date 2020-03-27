/*
 * Info6210 Final Project Group_28(Members: Hao Zuo, Handan Gu)
 */
DROP DATABASE GROUP28_Project;
CREATE DATABASE GROUP28_Project;

--Create Tables
CREATE TABLE dbo.Customer (
	CustomerID INT IDENTITY(100000,1) NOT NULL,
	LastName VARCHAR(45) NOT NULL,
	MiddleName VARCHAR(45) NULL,
	FirstName VARCHAR(45) NOT NULL,
	Gender VARCHAR(45) NULL,
	BirthDate DATETIME NULL,
	PhoneNumber VARCHAR(45) NULL,
	Street VARCHAR(45) NULL,
	City VARCHAR(45) NULL,
	State VARCHAR(45) NULL,
	Country VARCHAR(45) NULL,
	Zipcode VARCHAR(45) NULL,
	PRIMARY KEY (CustomerID)
);

CREATE TABLE dbo.Car (
	  CarID INT NOT NULL IDENTITY(200000,1),
	  Brand VARCHAR(45) NOT NULL,
	  Model VARCHAR(45) NOT NULL,
	  ProduceYear VARCHAR(45) NULL,
	  Color VARCHAR(45) NULL,
	  PRIMARY KEY (CarID)
);
 
CREATE TABLE dbo.CustomerCarRecord (
	  RecordID INT NOT NULL IDENTITY(100000,1),
	  RegistTime DATETIME NOT NULL,
	  CarCarID INT NOT NULL,
	  CustomerCustomerID INT NOT NULL,
	  PRIMARY KEY (RecordID),
	  CONSTRAINT fkCustomerCarRecordCar1
	    FOREIGN KEY (CarCarID)
	    REFERENCES dbo.Car (CarID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkCustomerCarRecordCustomer1
	    FOREIGN KEY (CustomerCustomerID)
	    REFERENCES dbo.Customer (CustomerID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.ParkingGarage (
	  GarageID INT NOT NULL IDENTITY(300000,1),
	  GarageType VARCHAR(45) NOT NULL,
	  Status VARCHAR(45) NOT NULL,
	  PRIMARY KEY (GarageID)
);

CREATE TABLE dbo.CustomerGarageRecord(
	  RecordID INT NOT NULL IDENTITY(100000,1),
	  RegistTime DATETIME NOT NULL,
	  StartTime DATETIME NOT NULL,
	  EndTime DATETIME NOT NULL,
	  Fee INT NOT NULL,
	  CustomerCustomerID INT NOT NULL,
	  ParkingGarageGarageID INT NOT NULL,
	  PRIMARY KEY (RecordID),
	  CONSTRAINT fkCustomerGarageRecordParkingGarage1
	    FOREIGN KEY (ParkingGarageGarageID)
	    REFERENCES dbo.ParkingGarage (GarageID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkCustomerGarageRecordCustomer1
	    FOREIGN KEY (CustomerCustomerID)
	    REFERENCES dbo.Customer (CustomerID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.FeeRegistManagement (
	  FeeID INT NOT NULL IDENTITY(1,1),
	  oneHourPrice INT NOT NULL,
	  PerHourPriceAboveOneHour INT NOT NULL,
	  PerPrice INT NOT NULL,
	  FeeType CHAR(45) NOT NULL,
	  RegistTime DATETIME NOT NULL,
	  PRIMARY KEY (FeeID)
);

CREATE TABLE dbo.ParkingRecord(
	  RecordID INT NOT NULL IDENTITY(100000,1),
	  GarageID INT NOT NULL,
	  InTime DATETIME NOT NULL,
	  OutTime DATETIME NULL,
	  Fee INT NULL,
	  OnDutyID INT NOT NULL,
	  FeeRegistManagementFeeID INT NOT NULL,
	  ParkingGarageGarageID INT NOT NULL,
	  CarCarID INT NOT NULL,
	  PRIMARY KEY (RecordID),
	  CONSTRAINT fkParkingRecordFeeRegistManagement1
	    FOREIGN KEY (FeeRegistManagementFeeID)
	    REFERENCES  dbo.FeeRegistManagement (FeeID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkParkingRecordParkingGarage1
	    FOREIGN KEY (ParkingGarageGarageID)
	    REFERENCES dbo.ParkingGarage (GarageID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkParkingRecordCar1
	    FOREIGN KEY (CarCarID)
	    REFERENCES dbo.Car (CarID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.Item(
		ItemID INT NOT NULL IDENTITY(400000,1),
		ItemName VARCHAR(45) NOT NULL,
		ItemPrice INT NOT NULL,
		producer VARCHAR(45) NOT NULL,
		PRIMARY KEY (ItemID)
);

CREATE TABLE dbo.Apartment(
	ApartmentID INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(45) NOT NULL,
	Priority INT NOT NULL,
	PRIMARY KEY (ApartmentID)
);

CREATE TABLE dbo.Staff (
	  StaffID INT NOT NULL IDENTITY(500000,1),
	  LastName VARCHAR(20) NOT NULL,
	  MiddleName VARCHAR(45) NULL,
	  FirstName VARCHAR(45) NOT NULL,
	  Gender VARCHAR(45) NULL,
	  BirthDate DATETIME NULL,
	  ApartmentID INT NOT NULL,
	  PhoneNumber VARCHAR(45) NOT NULL,
	  Street VARCHAR(45) NULL,
	  City VARCHAR(45) NULL,
	  Country VARCHAR(45) NULL,
	  Zipcode VARCHAR(45) NULL,
	  RegistTime DATETIME NOT NULL,
	  PRIMARY KEY (StaffID),
	  CONSTRAINT fkApartmentID1
	    FOREIGN KEY (ApartmentID)
	    REFERENCES  dbo.Apartment (ApartmentID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.Procurement (
	  ProcurementID INT NOT NULL IDENTITY(100000,1),
	  ProcurementTime DATETIME NOT NULL,
	  ItemID INT NOT NULL,
	  ItemNum INT NOT NULL,
	  TotalValue INT NOT NULL,
	  StaffStaffID INT NOT NULL,
	  PRIMARY KEY (ProcurementID),
	  CONSTRAINT fkStaffStaffID
	  	FOREIGN KEY(StaffStaffID)
	  	REFERENCES dbo.Staff(StaffID)
	  	ON DELETE NO ACTION
	  	ON UPDATE NO ACTION,
	  CONSTRAINT ItemID
	    FOREIGN KEY (ItemID)
	    REFERENCES  dbo.Item (ItemID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);


CREATE TABLE dbo.FundIncome (
	  FundRecordID INT NOT NULL IDENTITY(100000,1),
	  FromName VARCHAR(45) NOT NULL,
	  FundValue INT NOT NULL,
	  Status VARCHAR(45) NOT NULL,
	  FundTime DATETIME NOT NULL,
	  PRIMARY KEY (FundRecordID)
);

CREATE TABLE dbo.Investor (
	  InvestorID INT NOT NULL IDENTITY(1,1),
	  Name VARCHAR(45) NOT NULL,
	  InvestTime DATETIME NOT NULL,
	  QuitTime DATETIME NULL,
	  FundIncomeFundRecordID INT NOT NULL,
	  PRIMARY KEY (InvestorID),
	  CONSTRAINT fkInvestorFundIncome1
	    FOREIGN KEY (FundIncomeFundRecordID)
	    REFERENCES dbo.FundIncome (FundRecordID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.IncomeManagement (
	  IncomeRecordID INT NOT NULL IDENTITY(100000,1),
	  IncomeType VARCHAR(45) NOT NULL,
	  Value INT NOT NULL,
	  RegistTime DATETIME NOT NULL,
	  ParkingRecordRecordID INT NULL,
	  FundIncomeFundRecordID INT NULL,
	  GarageRecordID INT NULL,
	  PRIMARY KEY (IncomeRecordID),
	  CONSTRAINT fkIncomeManagementParkingRecord1
	    FOREIGN KEY (ParkingRecordRecordID)
	    REFERENCES dbo.ParkingRecord (RecordID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkIncomeManagementFundIncome1
	    FOREIGN KEY (FundIncomeFundRecordID)
	    REFERENCES  dbo.FundIncome (FundRecordID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkIncomeManagementGarageRecord1
	    FOREIGN KEY (GarageRecordID)
	    REFERENCES dbo.CustomerGarageRecord (RecordID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.StaffSchdeule (
	OnDutyID INT NOT NULL IDENTITY(1,1),
	ScheduleDate DATETIME NOT NULL,
	RegistTime DATETIME NOT NULL,
	PRIMARY KEY (OnDutyID)	
);

CREATE TABLE dbo.StaffSchdeulehasStaff (
	HasStaffSchdeuleOnDutyID INT NOT NULL,
	HasStaffStaffID INT NOT NULL,
	PRIMARY KEY (HasStaffSchdeuleOnDutyID, HasStaffStaffID),
	CONSTRAINT fkHasStaffSchdeuleOnDutyID FOREIGN KEY (HasStaffSchdeuleOnDutyID) REFERENCES dbo.StaffSchdeule (OnDutyID)
		ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	CONSTRAINT fkHasStaffStaffID FOREIGN KEY (HasStaffStaffID) REFERENCES dbo.Staff (StaffID)
		ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.FixedAsset (
	AssetID INT NOT NULL IDENTITY(100000,1),
	ItemNum INT NOT NULL,
	ItemPrice INT NOT NULL,
	TotalValue INT NOT NULL,
	ProcurementProcurementID INT NOT NULL,
	PRIMARY KEY (AssetID),
	CONSTRAINT fkProcurementProcurementID FOREIGN KEY (ProcurementProcurementID) REFERENCES dbo.Procurement(ProcurementID)
		ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.StaffSalaryRecord(
	SalaryID INT NOT NULL IDENTITY(100000,1),
	StandardSalary INT NOT NULL,
	Ensurance INT NOT NULL,
	SalaryTime DATETIME NOT NULL,
	Satus VARCHAR(45) NOT NULL,
	TotalSalary INT NOT NULL,
	StaffStaffID INT NOT NULL,
	PRIMARY KEY (SalaryID),
	CONSTRAINT fkStaffSalaryRecordStaff1 FOREIGN KEY (StaffStaffID) REFERENCES dbo.Staff (StaffID)
		ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

CREATE TABLE dbo.OutcomeManagement (
	OutcomeRecordID INT NOT NULL IDENTITY(100000,1),
	OutType VARCHAR(45) NOT NULL,
	Value INT NOT NULL,
	RegistTime DATETIME NOT NULL,
	StaffSalaryRecordSalaryID INT NULL,
	ProcurementProcurementID INT NULL,
	PRIMARY KEY (OutcomeRecordID),
	CONSTRAINT fkOutcomeManagementStaffSalaryRecord1
	    FOREIGN KEY (StaffSalaryRecordSalaryID)
	    REFERENCES dbo.StaffSalaryRecord (SalaryID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT fkOutcomeManagementProcurement1
	    FOREIGN KEY (ProcurementProcurementID)
	    REFERENCES dbo.Procurement (ProcurementID)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION
);

--Insert Values to Tables<10rows
INSERT INTO dbo.CustomerCarRecord
(RegistTime, CarCarID, CustomerCustomerID)
VALUES
('2018-07-06 20:00:00', 200005, 100005),
('2018-07-06 20:00:00', 200006, 100006),
('2018-07-06 20:00:00', 200007, 100007),
('2018-07-06 20:00:00', 200008, 100008),
('2018-07-06 20:00:00', 200009, 100009);


INSERT INTO dbo.CustomerGarageRecord
(RegistTime, StartTime, EndTime, Fee, CustomerCustomerID, ParkingGarageGarageID)
VALUES('2018-07-06 20:00:00', '2020-08-01 00:00:00', '2022-08-01 00:00:00', 100, 100005, 300000),
('2018-07-06 20:00:00', '2020-08-01 00:00:00', '2022-08-01 00:00:00', 100, 100006, 300001),
('2018-07-06 20:00:00', '2020-08-01 00:00:00', '2022-08-01 00:00:00', 100, 100007, 300002),
('2018-07-06 20:00:00', '2020-08-01 00:00:00', '2022-08-01 00:00:00', 100, 100008, 300003),
('2018-07-06 20:00:00', '2020-08-01 00:00:00', '2022-08-01 00:00:00', 100, 100009, 300004);

INSERT INTO dbo.IncomeManagement
(IncomeType, Value, RegistTime, ParkingRecordRecordID, FundIncomeFundRecordID, GarageRecordID)
VALUES('Benefit', 100, '2018-07-06 20:00:00',NULL , NULL , 100005),
('Benefit', 100, '2018-07-06 20:00:00',NULL , NULL , 100006),
('Benefit', 100, '2018-07-06 20:00:00',NULL , NULL , 100007),
('Benefit', 100, '2018-07-06 20:00:00',NULL , NULL , 100008),
('Benefit', 100, '2018-07-06 20:00:00',NULL , NULL , 100009);


INSERT INTO dbo.FeeRegistManagement
(oneHourPrice, PerHourPriceAboveOneHour, PerPrice, FeeType, RegistTime)
VALUES(5, 4, 45, 'Public', '2019-11-20 01:00:00'),
(5, 5, 45, 'Public', '2019-11-20 02:00:00'),
(5, 6, 35, 'Public', '2019-11-20 03:00:00'),
(5, 4, 45, 'Public', '2019-11-20 04:00:00'),
(5, 4, 35, 'Public', '2019-11-20 05:00:00');

INSERT INTO dbo.ParkingRecord
(GarageID, InTime, OutTime, Fee, OnDutyID, FeeRegistManagementFeeID, ParkingGarageGarageID, CarCarID)
VALUES(300000, '2019-11-19 01:00:00', '2019-11-19 02:00:00', 0, 5, 1, 300000, 200000),
(300000, '2019-11-19 02:30:00', '2019-11-19 03:00:00', 0, 5, 1, 300000, 200000),
(300000, '2019-11-19 04:00:00', '2019-11-19 05:00:00', 0, 5, 1, 300000, 200000),
(300000, '2019-11-19 05:30:00', '2019-11-19 06:00:00', 0, 5, 1, 300000, 200000),
(300000, '2019-11-19 07:00:00', '2019-11-19 08:00:00', 0, 5, 1, 300000, 200000);

DROP TABLE dbo.MonthbasedMainFinancialIndicators;
--Use Stored Procedures to Enter Data. Use Computed Columns Based on a Function.
CREATE TABLE dbo.MonthbasedMainFinancialIndicators (
	RecordID INT NOT NULL IDENTITY(100000,1) PRIMARY KEY,
	Years INT NOT NULL,
	Months INT NOT NULL,
	IncomeTotal INT NOT NULL,
	OutcomeTotal INT NOT NULL,
	Balance INT NOT NULL,
	ModificationTime DATETIME NOT NUll
);

CREATE FUNCTION dbo.MonthIncomeRecord (@Year INT, @Month INT)
RETURNS MONEY
AS 
BEGIN
  DECLARE @Output MONEY = 0;
  SELECT @Output = SUM(Value)
  FROM dbo.IncomeManagement
  WHERE YEAR(RegistTime) = @Year AND MONTH(RegistTime) = @Month
  RETURN ISNULL(@Output, 0);
END

DROP PROCEDURE dbo.MonthBasedProcedure;

CREATE FUNCTION dbo.MonthOutRecord (@Year INT, @Month INT)
RETURNS MONEY
AS 
BEGIN
  DECLARE @Output MONEY = 0;
  SELECT @Output = SUM(Value)
  FROM dbo.OutcomeManagement
  WHERE YEAR(RegistTime) = @Year AND MONTH(RegistTime) = @Month
  RETURN ISNULL(@Output, 0);
END

DROP TABLE MonthbasedMainFinancialIndicators;

CREATE PROCEDURE MonthBasedProcedure
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	WHILE @StartDate < @EndDate 
		BEGIN 
			INSERT INTO MonthbasedMainFinancialIndicators (Years, Months, IncomeTotal, OutcomeTotal, Balance, ModificationTime)
			VALUES (DATEPART(YEAR,@StartDate), 
					DATEPART(MONTH,@StartDate),
			        dbo.MonthIncomeRecord(DATEPART(YEAR,@StartDate),DATEPART(MONTH,@StartDate)), 
			        dbo.MonthOutRecord(DATEPART(YEAR,@StartDate),DATEPART(MONTH,@StartDate)),
			        dbo.MonthIncomeRecord(DATEPART(YEAR,@StartDate),DATEPART(MONTH,@StartDate))-dbo.MonthOutRecord(DATEPART(YEAR,@StartDate),
			        	DATEPART(MONTH,@StartDate)),
			        CURRENT_TIMESTAMP
			       );
			SET @StartDate = DATEADD(MONTH,1,@StartDate);
	    END	
END

--Activate procedure:
DECLARE @StartDate DATE, @EndDate DATE;
SET @StartDate='2018-01-01';
SET @EndDate='2019-12-31';
EXECUTE MonthBasedProcedure @StartDate,@EndDate;
SELECT * FROM MonthbasedMainFinancialIndicators;



--To encrypt a column of data using symmetric encryption that includes an authenticator
CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = 'helloworld'; 

CREATE CERTIFICATE staff01  
   WITH SUBJECT = 'Staff CardNumber'; 
   
CREATE SYMMETRIC KEY CreditCards_Key01  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE staff01; 
 
--ALTER TABLE dbo.Staff DROP COLUMN CardNumber;
--ALTER TABLE dbo.Staff DROP COLUMN CardNumber_Encrypted;
ALTER TABLE dbo.Staff ADD CardNumber nvarchar(20);
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500000
UPDATE dbo.Staff SET CardNumber='33332664695311' WHERE StaffID=500001
UPDATE dbo.Staff SET CardNumber='33332664695312' WHERE StaffID=500002
UPDATE dbo.Staff SET CardNumber='33332664695313' WHERE StaffID=500003
UPDATE dbo.Staff SET CardNumber='33332664695314' WHERE StaffID=500004
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500005
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500006
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500007
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500008
UPDATE dbo.Staff SET CardNumber='33332664695310' WHERE StaffID=500009;
   
ALTER TABLE dbo.Staff   
    ADD CardNumber_Encrypted varbinary(160);  
    
OPEN SYMMETRIC KEY CreditCards_Key01  
   DECRYPTION BY CERTIFICATE staff01;  
   
UPDATE Staff 
SET CardNumber_Encrypted = EncryptByKey(Key_GUID('CreditCards_Key01')  
    , CardNumber, 1, HashBytes('SHA1', CONVERT( varbinary  
    , StaffID)));  
    
OPEN SYMMETRIC KEY CreditCards_Key01  
   DECRYPTION BY CERTIFICATE staff01;
  
SELECT CardNumber, CardNumber_Encrypted   
    AS 'Encrypted card number', CONVERT(nvarchar,  
    DecryptByKey(CardNumber_Encrypted, 1 ,   
    HashBytes('SHA1', CONVERT(varbinary, StaffID))))  
    AS 'Decrypted card number' FROM Staff; 


--Create View
DROP VIEW [Garage Parking Record Details];
CREATE VIEW [Garage Parking Record Details] AS
SELECT pr.RecordID,cus.CustomerID,cus.FirstName,cus.MiddleName,cus.LastName,cus.Gender,cus.PhoneNumber,
		car.CarID,car.Brand,car.Model,
		pg.GarageID,pg.GarageType,
		pr.InTime,pr.OutTime,
		pr.Fee,f.FeeType,f.oneHourPrice,f.PerHourPriceAboveOneHour,f.PerPrice
FROM dbo.ParkingRecord pr 
JOIN dbo.ParkingGarage pg
ON pr.GarageID=pg.GarageID
LEFT JOIN dbo.Car car
ON pr.CarCarID=car.CarID
LEFT JOIN dbo.CustomerCarRecord ccr
ON car.CarID=ccr.CarCarID
LEFT JOIN dbo.Customer cus
ON ccr.CustomerCustomerID=cus.CustomerID
LEFT JOIN dbo.FeeRegistManagement f
ON pr.FeeRegistManagementFeeID=f.FeeID;

CREATE VIEW [Staff Salary Record Details] AS
SELECT ssr.SalaryTime, ssr.StaffStaffID,
		s.FirstName,s.MiddleName,s.LastName,s.Gender,s.PhoneNumber,
		a.Name AS [Apartment Name],
		ssr.TotalSalary AS [Salary]
FROM dbo.StaffSalaryRecord ssr
JOIN dbo.Staff s
ON ssr.StaffStaffID=s.StaffID
JOIN dbo.Apartment a
ON s.ApartmentID=a.ApartmentID;

CREATE VIEW [Financial Details] AS
SELECT TOP 100 PERCENT * FROM(
SELECT im.IncomeType AS [Type],im.Value,im.RegistTime
FROM dbo.IncomeManagement im
UNION ALL
SELECT om.OutType AS [Type],om.Value,om.RegistTime
FROM dbo.OutcomeManagement om
) AS a;

--Table Level Check Function on CustomerCarRecord
CREATE FUNCTION getCustomerID(@id int)
RETURNS INT
AS
BEGIN
        RETURN ISNULL((select top(1) 1 from Customer where CustomerID=@id), 0)
END
GO

CREATE FUNCTION getCarID(@id int)
RETURNS INT
AS
BEGIN
        RETURN ISNULL((select top(1) 1 from Car where CarID=@id), 0)
END
GO

ALTER TABLE dbo.CustomerCarRecord WITH NOCHECK ADD CONSTRAINT chk_Customer
        CHECK (dbo.getCustomerID(CustomerCustomerID)=1)
GO
ALTER TABLE dbo.CustomerCarRecord WITH NOCHECK ADD CONSTRAINT chk_Car
        CHECK (dbo.getCarID(CarCarID)=1)
GO

-- If you try to update CustomerCustomerID and CarCarID it fails
UPDATE dbo.CustomerCarRecord
SET CustomerCustomerID = 900019;

UPDATE dbo.CustomerCarRecord
SET CarCarID = 900019;





   