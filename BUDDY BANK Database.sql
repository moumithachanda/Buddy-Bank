DROP DATABASE IF EXISTS BUDDY_BANK;

CREATE DATABASE BUDDY_BANK ;

USE BUDDY_BANK ;

-- Drop existing tables if they exist (for re-runs)
DROP TABLE IF EXISTS Registered_at, Transaction, Supervise, Customer_creditcard, Employee_phone, Passbook,
                     DebitCard, Loan, Account, Customer, Employee, Branch;

-- Create tables
CREATE TABLE Branch (
    IFSC VARCHAR(20) PRIMARY KEY,
    Manager_ID VARCHAR(10),
    Helpdeskcontact VARCHAR(15),
    Hno VARCHAR(10),
    Street VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    Pincode VARCHAR(10)
);

CREATE TABLE Employee (
    EmpID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Branch_IFSC VARCHAR(20),
    Email VARCHAR(100),
    DOJ DATE,
    Designation VARCHAR(50)
);

INSERT INTO Branch VALUES
('IFSC001', 'E001', '1800123456', '12', 'Main Street', 'Mumbai', 'MH', '400001'),
('IFSC002', 'E002', '1800654321', '34', 'Park Lane', 'Delhi', 'DL', '110001');

INSERT INTO Employee VALUES
('E001', 'Amit Sharma', 'IFSC001', 'amit@bank.com', '2015-06-01', 'Manager'),
('E002', 'Sunita Rao', 'IFSC002', 'sunita@bank.com', '2017-03-15', 'Clerk');

ALTER TABLE Branch
ADD CONSTRAINT fk_manager
FOREIGN KEY (Manager_ID) REFERENCES Employee(EmpID);

ALTER TABLE Employee
ADD CONSTRAINT fk_branch
FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC);

CREATE TABLE Customer (
    CID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE,
    Phoneno VARCHAR(10),
    Hno VARCHAR(10),
    Street VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    Pincode VARCHAR(10)
);

CREATE TABLE Account (
    Accno VARCHAR(20) PRIMARY KEY,
    CID VARCHAR(10),
    Branch_IFSC VARCHAR(20),
    Date_opened DATE,
    PANno VARCHAR(10),
    Account_type VARCHAR(20),
    Balance DECIMAL(12, 2),
    FOREIGN KEY (CID) REFERENCES Customer(CID),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC)
);

CREATE TABLE Loan (
    LoanID VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    Start_date DATE,
    Amount DECIMAL(12, 2),
    Term INT,
    Loan_type VARCHAR(30),
    Interest_rate DECIMAL(5,2),
    FOREIGN KEY (Accno) REFERENCES Account(Accno)
);

CREATE TABLE DebitCard (
    Cardno VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    CVV INT,
    exp_month INT,
    exp_year INT,
    FOREIGN KEY (Accno) REFERENCES Account(Accno)
);

CREATE TABLE Passbook (
    PID VARCHAR(20) PRIMARY KEY,
    Accno VARCHAR(20),
    Branch_IFSC VARCHAR(20),
    DOI DATE,
    Date_of_last_commit DATE,
    FOREIGN KEY (Accno) REFERENCES Account(Accno),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC)
);

CREATE TABLE Employee_phone (
    EmpID VARCHAR(10),
    Phoneno VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

CREATE TABLE Customer_creditcard (
    CID VARCHAR(10),
    Cardno VARCHAR(20) PRIMARY KEY,
    exp_month INT,
    exp_year INT,
    FOREIGN KEY (CID) REFERENCES Customer(CID)
);

CREATE TABLE Supervise (
    Supervisor VARCHAR(10),
    Subordinate VARCHAR(10),
    PRIMARY KEY (Supervisor, Subordinate),
    FOREIGN KEY (Supervisor) REFERENCES Employee(EmpID),
    FOREIGN KEY (Subordinate) REFERENCES Employee(EmpID)
);

CREATE TABLE Transaction (
    TID VARCHAR(20) PRIMARY KEY,
    from_acc VARCHAR(20),
    to_acc VARCHAR(20),
    method VARCHAR(30),
    Date DATE,
    Time TIME,
    Amount DECIMAL(12, 2),
    FOREIGN KEY (from_acc) REFERENCES Account(Accno),
    FOREIGN KEY (to_acc) REFERENCES Account(Accno)
);

CREATE TABLE Registered_at (
    Branch_IFSC VARCHAR(20),
    CID VARCHAR(10),
    PRIMARY KEY (Branch_IFSC, CID),
    FOREIGN KEY (Branch_IFSC) REFERENCES Branch(IFSC),
    FOREIGN KEY (CID) REFERENCES Customer(CID)
);


-- Insert Customers
INSERT INTO Customer VALUES 
('C001', 'Riya Verma', '2000-01-15', '9876543210', '101', 'Rose Ave', 'Mumbai', 'MH', '400002'),
('C002', 'Rahul Jain', '1995-09-20', '9123456780', '202', 'Lake View', 'Delhi', 'DL', '110002');

-- Insert Accounts
INSERT INTO Account VALUES 
('ACC001', 'C001', 'IFSC001', '2020-08-10', 'ABCDE1234F', 'Savings', 50000.00),
('ACC002', 'C002', 'IFSC002', '2021-05-12', 'PQRSX9876Y', 'Current', 75000.00);

-- Insert Loans
INSERT INTO Loan VALUES 
('L001', 'ACC001', '2022-01-01', 200000.00, 60, 'Home', 7.5),
('L002', 'ACC002', '2023-06-15', 100000.00, 36, 'Personal', 10.0);

-- Insert DebitCards
INSERT INTO DebitCard VALUES 
('DC001', 'ACC001', 123, 12, 2025),
('DC002', 'ACC002', 456, 5, 2026);

-- Insert Passbooks
INSERT INTO Passbook VALUES 
('PB001', 'ACC001', 'IFSC001', '2020-08-10', '2025-04-01'),
('PB002', 'ACC002', 'IFSC002', '2021-05-12', '2025-04-02');

-- Insert Employee phones
INSERT INTO Employee_phone VALUES 
('E001', '9876543211'),
('E002', '9123456789');

-- Insert Customer credit cards
INSERT INTO Customer_creditcard VALUES 
('C001', 'CC001', 10, 2026),
('C002', 'CC002', 11, 2027);

-- Insert Supervise relationships
INSERT INTO Supervise VALUES 
('E001', 'E002');

-- Insert Transactions
INSERT INTO Transaction VALUES 
('T001', 'ACC001', 'ACC002', 'NEFT', '2025-04-01', '12:30:00', 1000.00),
('T002', 'ACC002', 'ACC001', 'IMPS', '2025-04-02', '15:45:00', 2000.00);

-- Insert Registered_at entries
INSERT INTO Registered_at VALUES 
('IFSC001', 'C001'),
('IFSC002', 'C002');
