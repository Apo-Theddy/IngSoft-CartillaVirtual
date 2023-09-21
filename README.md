# Entities

## Dishs
- DishID INT **(PK)** NOT NULL UNIQUE
- CategoryID INT NULL **(FK)**
- DishName VARCHAR  NOT NULL
- UnitPrice FLOAT NOT NULL
- CreationDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsActive BIT NULL _**[DEFAULT 0]**_
- QuantityAvailable INT NULL

## Categories
- CategoryID INT **(PK)** NOT NULL UNIQUE
- CategoryName VARCHAR NOT NULL
- Description TEXT NULL
- IsActive BIT NULL _**[DEFAULT 0]**_
- CreationDate DATE NULL _**[DEFAULT SYSDATETIME()]**_

## Tables
- TableID INT **(PK)** NOT NULL UNIQUE
- TableName VARCHAR NOT NULL
- CreationDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsActive BIT NULL _**[DEFAULT 0]**_

## Payments
- PaymentID INTEGER **(OK)** NOT NULL UNIQUE
- PaymentType VARCHAR NOT NULL
- PaymentDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsActive BIT NULL _**[DEFAULT 0]**_

## Clients
- ClientID INT **(PK)** NOT NULL UNIQUE
- ClientName VARCHAR NULL
- PhoneNumber CHAR(9) NULL
- CreationDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsActive BIT NULL _**[DEFAULT 0]**_

## Orders
- OrderId INT **(PK)** NOT NULL UNIQUE
- DishID INT **(FK)**
- TableID INT **(FK)**
- Name VARCHAR NOT NULL
- OrderDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsComplete BIT NULL _**[DEFAULT 1]**_
- IsActive BIT NULL _**[DEFAULT 0]**_

## Order Complete
- OrderID INT **(FK)**
- PaymentID INT **(FK)**
- ClientName
- OrderDate DATE NULL _**[DEFAULT SYSDATETIME()]**_
- IsActive BIT NULL _**[DEFAULT 0]**_

## Relations
- A __table__ can have multiple __orders__. (One To Many)
- One or more __orders__ can be on a __table__. (Many to One)
- An __order__ can have several __dishes__. (One To Many)
- A __dish__ can be in several __orders__ (Many to One)


