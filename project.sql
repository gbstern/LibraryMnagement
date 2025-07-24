--SQL ������ ����
-------------------

CREATE DATABASE LibraryDB

---------------------------------------------------------------------------------------------------

USE LibraryDB
GO

CREATE TABLE Category_tbl
(
	Code TINYINT IDENTITY (01, 1) PRIMARY KEY,
	Category VARCHAR (15) NOT NULL
)
GO


CREATE TABLE Authors_tbl
(
	AuthorId TINYINT IDENTITY (20, 1) PRIMARY KEY,
	AuthorName VARCHAR (15) NOT NULL
)
GO


CREATE TABLE Books_tbl
(
	BookCode SMALLINT PRIMARY KEY,
	BookName VARCHAR (20),
	AuthorCode TINYINT REFERENCES Authors_tbl,
	CategoryCode TINYINT REFERENCES Category_tbl,
	LendingPeriod VARCHAR(10) DEFAULT '�������',
	ContinueBook SMALLINT REFERENCES Books_tbl
)

ALTER TABLE Books_tbl
ALTER COLUMN BookName VARCHAR(30)

ALTER TABLE Books_tbl
ADD BuyingDate DATE
GO

CREATE TABLE Subscribers_tbl
(
	SubscriberCode SMALLINT IDENTITY (1500, 10) PRIMARY KEY,
	SubscriberId INT UNIQUE NOT NULL,
	RegistraitionDate DATE CHECK (RegistraitionDate <= GETDATE()),
	SubLastName VARCHAR (12) NOT NULL,
	SubFirstName VARCHAR (12) DEFAULT '�����',
	SubAddress VARCHAR (20),
	NumKids TINYINT,
	AdultBooks VARCHAR (2) DEFAULT '��' NOT NULL,
	PhoneNumber VARCHAR(10),
	Fine MONEY
)
GO


CREATE TABLE Lending_tbl
(
	LendingId SMALLINT IDENTITY (100, 1) PRIMARY KEY,
	LendingDate DATE CHECK (LendingDate <= GETDATE()) DEFAULT GETDATE(),
	SubscriberCode SMALLINT REFERENCES Subscribers_tbl,
	BookCode SMALLINT REFERENCES Books_tbl,
	ReturnDate DATE,
	Returned DATE,
	Fine MONEY
)
GO


CREATE TABLE BooksLended_tbl
(
	LendedBookId INT IDENTITY (1000, 1) PRIMARY KEY,
	LendingId SMALLINT REFERENCES Lending_tbl,
	BookCode SMALLINT REFERENCES Books_tbl,
	ReturnDate DATE,
	Returned DATE,
	Fine MONEY
)

DROP TABLE BooksLended_tbl
GO



--------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertCategory (@Code TINYINT, @Category VARCHAR(15))
AS
	INSERT INTO Category_tbl
	VALUES (@Category)

EXEC InsertCategory 01, '��� ���'
EXEC InsertCategory 02, '����� - �����'
EXEC InsertCategory 03, '���� - �� �����'
EXEC InsertCategory 04, '������'
EXEC InsertCategory 05, '�������'
EXEC InsertCategory 06, '�����'
GO


---------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertAuthors (@AuthorId TINYINT, @AuthorName VARCHAR(15))
AS
	INSERT INTO Authors_tbl
	VALUES (@AuthorName)

EXEC InsertAuthors 20, '��� ����'
EXEC InsertAuthors 20, '���� �����'
EXEC InsertAuthors 20, '��� ������'
EXEC InsertAuthors 20, '���� ����'
EXEC InsertAuthors 20, '��� ��������'
EXEC InsertAuthors 20, '��� ����'
EXEC InsertAuthors 20, '����� ����'
EXEC InsertAuthors 20, '���� ������'
EXEC InsertAuthors 20, '��� ����'
EXEC InsertAuthors 20, '���� ����'
EXEC InsertAuthors 20, '���� ����'
EXEC InsertAuthors 20, '����'
EXEC InsertAuthors 20, '����� ������'
EXEC InsertAuthors 20, '����� �����'
EXEC InsertAuthors 20, '��� ����'
EXEC InsertAuthors 20, '����� ���'
EXEC InsertAuthors 20, '���� ����'
EXEC InsertAuthors 20, '��� ������'
EXEC InsertAuthors 20, '���� ������'
EXEC InsertAuthors 20, '��� ����'
GO


---------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertBooks (@BookCode SMALLINT, @BookName VARCHAR(30), @AuthorCode TINYINT, @CategoryCode TINYINT, @LendingPeriod VARCHAR(10), @ContinueBook SMALLINT)
AS
	INSERT INTO Books_tbl
	VALUES (@BookCode, @BookName, @AuthorCode, @CategoryCode, @LendingPeriod, @ContinueBook)


EXEC InsertBooks 01101, '��� ���� ����� - ��', 39, 01, '�������', 01102
EXEC InsertBooks 01102, '��� ���� ����� - ����', 39, 01, '�������', 01103
EXEC InsertBooks 01103, '��� ���� ����� - ������', 39, 01, '�������', 01104
EXEC InsertBooks 01104, '��� ���� ����� - ����� �����', 39, 01, '�������', NULL
EXEC InsertBooks 02101, '����� ���� ���� ��� - 1', 22, 02, '�������', 02102
EXEC InsertBooks 02102, '����� ���� ���� ��� - 2', 22, 02, '�������', 02103
EXEC InsertBooks 02103, '����� ���� ���� ��� - 3', 22, 02, '�������', 02104
EXEC InsertBooks 02104, '����� ���� ���� ��� - 4', 22, 02, '�������', NULL
EXEC InsertBooks 02105, '��� �����', 25, 02, '�������', 02106
EXEC InsertBooks 02106, '���� �� ����', 25, 02, '�������', 02107
EXEC InsertBooks 02107, '����� ������', 25, 02, '�������', NULL
EXEC InsertBooks 03101, '���� �������', 20, 03, '�������', NULL
EXEC InsertBooks 03102, '�� �� ���', 20, 03, '�������', NULL
EXEC InsertBooks 03103, '���� ��� ����', 20, 03, '�������', NULL
EXEC InsertBooks 04101, '����� ��������� �', 29, 04, '����', 04102
EXEC InsertBooks 04102, '����� ��������� �', 29, 04, '����', NULL
EXEC InsertBooks 05101, '������', 20, 05, '�������', 05102
EXEC InsertBooks 05102, '������', 20, 05, '�������', 05103
EXEC InsertBooks 05103, '����� �', 20, 05, '�������', 05104
EXEC InsertBooks 05104, '����� �', 20, 05, '�������', 05105
EXEC InsertBooks 05105, '�����', 20, 05, '�������', NULL
EXEC InsertBooks 05106, '��� ����', 24, 05, '�������', NULL
EXEC InsertBooks 05108, '������', 24, 05, '�������', NULL
GO


------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertSubscribers (@SubscriberCode SMALLINT, @SubscriberId INT, @RegistraitionDate DATE,
									@SubLastName VARCHAR(12), @SubFirstName VARCHAR(12), @SubAddress VARCHAR(20),
									@NumKids TINYINT, @AdultBooks VARCHAR(3), @phoneNumber VARCHAR(10), @Fine MONEY)
AS
	INSERT INTO Subscribers_tbl
	VALUES (@SubscriberId, @RegistraitionDate, @SubLastName,
				@SubFirstName, @SubAddress, @NumKids, @AdultBooks, @PhoneNumber, @Fine)

EXEC InsertSubscribers 1, 326337599, '2024-02-21', '����',  '����', '����� ����� 8', 2, '��', '0556762413'  ,NULL
EXEC InsertSubscribers 1, 317761708, '2024-02-24', '����',  '�����', '���� ���� 8', 4, '��', '0533123896'  ,NULL
EXEC InsertSubscribers 1, 322782525, '2024-02-24', '����',  '�����', '���� ������ 7', 8, '��', '0527655521'  ,NULL
EXEC InsertSubscribers 1, 351582468, '2024-02-24', '�������',  '�����', '���� ��� 5', 4, '��', '025388466'  ,NULL
GO


------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertLending (@LendingId SMALLINT, @LendingDate DATE, @SubscriberCode SMALLINT,
								@BookCode SMALLINT, @ReturnDate DATE, @Returned DATE, @Fine MONEY)
AS
	INSERT INTO Lending_tbl
	VALUES (@LendingDate, @SubscriberCode, @BookCode, @ReturnDate, @Returned, @Fine)
GO

EXEC InsertLending 101, '2024-02-23', 1500, 5101, '2024-03-08', NULL, NULL
EXEC InsertLending 104, '2024-02-24', 1510, 4102, '2024-03-09', NULL, NULL
EXEC InsertLending 104, '2024-02-24', 1520, 2103, '2024-03-09', NULL, NULL
EXEC InsertLending 104, '2024-02-24', 1530, 5102, '2024-03-09', NULL, NULL
EXEC InsertLending 104, '2024-02-24', 1530, 5103, '2024-03-09', NULL, NULL
GO


------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertBooksLended (@LendedBookId INT, @LendingId SMALLINT, @BookCode SMALLINT,
									@ReturnDate DATE, @Returned DATE, @Fine MONEY)
AS
	INSERT INTO BooksLended_tbl
	VALUES (@LendingId, @BookCode,@ReturnDate, @Returned, @Fine)


DROP PROCEDURE InsertBooksLended
GO


------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE AdualtBooks (@SubscriberCode SMALLINT)
	AS
	UPDATE Subscribers_tbl
	SET AdultBooks = '��'
GO

-------------------------------------------------------------------------------------------------------------------------


CREATE VIEW NewBooks
AS
SELECT BookName ,AuthorName
FROM Books_tbl b JOIN Authors_tbl a
ON b.AuthorCode = a.AuthorId
WHERE DATEDIFF (DD, BuyingDate, GETDATE()) < 30
GO

SELECT *
FROM NewBooks
GO

-------------------------------------------------------------------------------------------------------------------------


CREATE TRIGGER CheckAdualtTrigger ON Lending_tbl
FOR INSERT
AS
	BEGIN
		PRINT 'Trigger Began'
		DECLARE @SubCode SMALLINT
		DECLARE @Category SMALLINT
		SELECT @SubCode =  SubscriberCode, @Category = RowTable.BookCode
							FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY LendingId DESC) AS rownum
									FROM Lending_tbl) RowTable
							WHERE rownum = 1
		PRINT @SubCode
		PRINT @Category
		DECLARE @Permition VARCHAR(2)
		SELECT @Permition = AdultBooks
		FROM Subscribers_tbl
		WHERE SubscriberCode = @SubCode
		PRINT @Permition
		IF @Category LIKE '5%'
			BEGIN
				PRINT CASE @Permition
					WHEN '��' THEN '�� ����� ����� �������'
					WHEN '��' THEN '��� ������ ���� ���� �������'
					ELSE '��� ������ ���� ���� �������'
				END
			END
	END
GO


--------------------------------------------------------------------------------------------------------------------------


CREATE FUNCTION FindContinueBook (@BookCode SMALLINT)
RETURNS VARCHAR(30)
AS
	BEGIN
		DECLARE @ContinueBookName VARCHAR(30)
		SELECT @ContinueBookName = b2.BookName
		FROM Books_tbl b1 JOIN Books_tbl b2 --b1 ���, b2 ��� ����
		ON b2.BookCode = b1.ContinueBook AND b1.BookCode = @BookCode
		RETURN @ContinueBookName
	END
GO

PRINT dbo.FindContinueBook(5101)
GO


--------------------------------------------------------------------------------------------------------------------------


CREATE FUNCTION FindBook (@BookCode SMALLINT) RETURNS TABLE
AS
	RETURN (SELECT SubFirstName + ' ' + SubLastName AS Name, SubAddress, PhoneNumber
			FROM Subscribers_tbl
			WHERE SubscriberCode = (SELECT SubscriberCode
									FROM Lending_tbl
									WHERE BookCode = @BookCode))
GO

SELECT *
FROM FindBook(2103)


--------------------------------------------------------------------------------------------------------------------------

CREATE VIEW BooksTaken
AS
	SELECT AuthorId, AuthorName, COUNT(AuthorId) AmountOfTimes
	FROM Authors_tbl a JOIN (Lending_tbl l LEFT JOIN Books_tbl b
							ON l.BookCode = b.BookCode)
	ON a.AuthorId = b.AuthorCode
	GROUP BY AuthorId, AuthorName
GO

SELECT *
FROM BooksTaken