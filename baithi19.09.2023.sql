--1.tao csdl AZBank
CREATE DATABASE AZBank
GO

--2.tao bang vs rang buoc theo yeu cau
Use AZBank
GO

--Customer
CREATE TABLE Customer(
CustomerId int primary key,
Name nvarchar(50),
City nvarchar(50),
Country nvarchar(50),
Phone nvarchar(15),
Email nvarchar(50)
)
GO

--CustomerAccount
CREATE TABLE CustomerAccount(
AccountNumber char(9) primary key,
CustomerId int not null foreign key references Customer(CustomerId),
Balance money not null,
MiniAccount money 
)
GO

--CustomerTransaction
CREATE TABLE CustomerTransaction(
TransactionId int primary key,
AccountNumber char(9) foreign key references CustomerAccount(AccountNumber),
TransactionDate smalldatetime,
Amount money,
DepositorWithdraw bit
)
GO

--3.INSERT INTO
INSERT INTO Customer VALUES(1, 'Customer01', 'Hanoi', 'VietNam', 1133445566, 'Boku@gmail.com'),
						   (2, 'Customer02', 'Vungtau', 'VietNam', 2233445588, 'No@gmail.com'),
						   (3, 'Customer03', 'Namdinh', 'VietNam', 3333445599, 'Pico@gmail.com')
GO

INSERT INTO CustomerAccount VALUES('123', 1, 400000 ,0), ('456', 2, 800000 ,0), ('789', 3, 1200000 ,0)
GO

INSERT INTO CustomerTransaction VALUES(1, '123', '2023-09-20', 100000, 1), (2, '456', '2023-09-21', 200000, 1), (3, '789', '2023-09-22', 300000, 1)
GO

--4. THONG TIN TU BANG CUSTOMER. KH O HANOI
SELECT * FROM Customer WHERE City = 'Hanoi'
Go

--5.lay thong tin tu kh Name, Phone, Email, AccountNumber, Balance
SELECT Customer.Name, Customer.Phone, Customer.Email, CustomerAccount.AccountNumber, CustomerAccount.Balance
FROM Customer JOIN CustomerAccount ON Customer.CustomerId = CustomerAccount.CustomerId
GO

--6.CHECK AMOUNT COLUMN > 0 AND <= 1000000
ALTER TABLE CustomerTransaction ADD CONSTRAINT Amount CHECK(Amount > 0 and Amount <= 1000000)
go

--7.View vCustomerTransactions
create view vCustomerTransactions
as
SELECT Customer.Name, CustomerAccount.AccountNumber, CustomerTransaction.TransactionDate, CustomerTransaction.Amount, CustomerTransaction.DepositorWithdraw
FROM (Customer JOIN CustomerAccount ON Customer.CustomerId = CustomerAccount.CustomerId)
JOIN CustomerTransaction ON CustomerTransaction.AccountNumber = CustomerAccount.AccountNumber
GO
