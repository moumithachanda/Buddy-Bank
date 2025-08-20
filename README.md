# BuddyBank

## 📌 Overview  
BuddyBank is a relational database management system designed as part of a DBMS course project.  
It models real-world banking operations such as customers, accounts, loans, transactions, employees, and branches.  
The system emphasizes **data consistency, integrity, and efficient retrieval** using SQL.  

---

## 🚀 Features  
- ER model and relational schema for a complete banking system.  
- Normalized design to avoid redundancy and ensure consistency.  
- Supports customer registration, account creation, transactions, and loan management.  
- Handles employee–branch relationships and supervision hierarchy.  
- Tracks debit/credit cards, passbooks, and expiry details.  
- Provides secure and efficient transactions with detailed records.  

---

## 🗂 Database Schema  
**Entities:**  
- Customer (with credit card details)  
- Employee (with supervisor relationships)  
- Branch  
- Account  
- Loan  
- DebitCard  
- Passbook  
- Transaction  
- Address  

**Key Relationships:**  
- Customer ↔ Branch (registration)  
- Customer ↔ Account (maintains)  
- Account ↔ Loan (applies for)  
- Account ↔ Transaction (initiates)  
- Employee ↔ Branch (works at)  
- Employee ↔ Employee (supervises)  

---

## ⚙️ How to Run  
1. Install any SQL database (MySQL / PostgreSQL / Oracle).  
2. Create a new database:  
   ```sql
   CREATE DATABASE buddybank;
   USE buddybank;
