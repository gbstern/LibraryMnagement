--SQL פרויקט סיום
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
	LendingPeriod VARCHAR(10) DEFAULT 'שבועיים',
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
	SubFirstName VARCHAR (12) DEFAULT 'משפחת',
	SubAddress VARCHAR (20),
	NumKids TINYINT,
	AdultBooks VARCHAR (2) DEFAULT 'לא' NOT NULL,
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

EXEC InsertCategory 01, 'גיל הרך'
EXEC InsertCategory 02, 'ילדים - מנוקד'
EXEC InsertCategory 03, 'נוער - לא מנוקד'
EXEC InsertCategory 04, 'קומיקס'
EXEC InsertCategory 05, 'מבוגרים'
EXEC InsertCategory 06, 'מחשבה'
GO


---------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertAuthors (@AuthorId TINYINT, @AuthorName VARCHAR(15))
AS
	INSERT INTO Authors_tbl
	VALUES (@AuthorName)

EXEC InsertAuthors 20, 'מיה קינן'
EXEC InsertAuthors 20, 'אסתר קווין'
EXEC InsertAuthors 20, 'רות רפפורט'
EXEC InsertAuthors 20, 'יונה ספיר'
EXEC InsertAuthors 20, 'לאה סמילנסקי'
EXEC InsertAuthors 20, 'רבי מנדל'
EXEC InsertAuthors 20, 'מנוחה פוקס'
EXEC InsertAuthors 20, 'רותי טטנולד'
EXEC InsertAuthors 20, 'לאה פריד'
EXEC InsertAuthors 20, 'שפרה גליק'
EXEC InsertAuthors 20, 'חיים ולדר'
EXEC InsertAuthors 20, 'גולד'
EXEC InsertAuthors 20, 'אברהם אוחיון'
EXEC InsertAuthors 20, 'אברהם זמורה'
EXEC InsertAuthors 20, 'גדי פולק'
EXEC InsertAuthors 20, 'דבורי רנד'
EXEC InsertAuthors 20, 'רותי קפלר'
EXEC InsertAuthors 20, 'שרה קיסטנר'
EXEC InsertAuthors 20, 'ספרי מחניים'
EXEC InsertAuthors 20, 'אלי לומד'
GO


---------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertBooks (@BookCode SMALLINT, @BookName VARCHAR(30), @AuthorCode TINYINT, @CategoryCode TINYINT, @LendingPeriod VARCHAR(10), @ContinueBook SMALLINT)
AS
	INSERT INTO Books_tbl
	VALUES (@BookCode, @BookName, @AuthorCode, @CategoryCode, @LendingPeriod, @ContinueBook)


EXEC InsertBooks 01101, 'אלי לומד להזהר - אש', 39, 01, 'שבועיים', 01102
EXEC InsertBooks 01102, 'אלי לומד להזהר - כביש', 39, 01, 'שבועיים', 01103
EXEC InsertBooks 01103, 'אלי לומד להזהר - תרופות', 39, 01, 'שבועיים', 01104
EXEC InsertBooks 01104, 'אלי לומד להזהר - חומרי ניקוי', 39, 01, 'שבועיים', NULL
EXEC InsertBooks 02101, 'עשרים ואחד בבית אחד - 1', 22, 02, 'שבועיים', 02102
EXEC InsertBooks 02102, 'עשרים ואחד בבית אחד - 2', 22, 02, 'שבועיים', 02103
EXEC InsertBooks 02103, 'עשרים ואחד בבית אחד - 3', 22, 02, 'שבועיים', 02104
EXEC InsertBooks 02104, 'עשרים ואחד בבית אחד - 4', 22, 02, 'שבועיים', NULL
EXEC InsertBooks 02105, 'הכד השבור', 25, 02, 'שבועיים', 02106
EXEC InsertBooks 02106, 'נדרו של השיח', 25, 02, 'שבועיים', 02107
EXEC InsertBooks 02107, 'גורדי תהומות', 25, 02, 'שבועיים', NULL
EXEC InsertBooks 03101, 'עגור הברונזה', 20, 03, 'שבועיים', NULL
EXEC InsertBooks 03102, 'לב של קרח', 20, 03, 'שבועיים', NULL
EXEC InsertBooks 03103, 'המלך הבא בתור', 20, 03, 'שבועיים', NULL
EXEC InsertBooks 04101, 'משפחת שיקופיצקי א', 29, 04, 'שבוע', 04102
EXEC InsertBooks 04102, 'משפחת שיקופיצקי ב', 29, 04, 'שבוע', NULL
EXEC InsertBooks 05101, 'איסתרק', 20, 05, 'שבועיים', 05102
EXEC InsertBooks 05102, 'מהלאלל', 20, 05, 'שבועיים', 05103
EXEC InsertBooks 05103, 'יוזבד א', 20, 05, 'שבועיים', 05104
EXEC InsertBooks 05104, 'יוזבד ב', 20, 05, 'שבועיים', 05105
EXEC InsertBooks 05105, 'פדהאל', 20, 05, 'שבועיים', NULL
EXEC InsertBooks 05106, 'פגע וברח', 24, 05, 'שבועיים', NULL
EXEC InsertBooks 05108, 'תהומות', 24, 05, 'שבועיים', NULL
GO


------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE InsertSubscribers (@SubscriberCode SMALLINT, @SubscriberId INT, @RegistraitionDate DATE,
									@SubLastName VARCHAR(12), @SubFirstName VARCHAR(12), @SubAddress VARCHAR(20),
									@NumKids TINYINT, @AdultBooks VARCHAR(3), @phoneNumber VARCHAR(10), @Fine MONEY)
AS
	INSERT INTO Subscribers_tbl
	VALUES (@SubscriberId, @RegistraitionDate, @SubLastName,
				@SubFirstName, @SubAddress, @NumKids, @AdultBooks, @PhoneNumber, @Fine)

EXEC InsertSubscribers 1, 326337599, '2024-02-21', 'שטרן',  'גיטי', 'קדושת אהרון 8', 2, 'כן', '0556762413'  ,NULL
EXEC InsertSubscribers 1, 317761708, '2024-02-24', 'שטרן',  'משפחת', 'מנחת יצחק 8', 4, 'כן', '0533123896'  ,NULL
EXEC InsertSubscribers 1, 322782525, '2024-02-24', 'גרוס',  'צפורה', 'פנים מאירות 7', 8, 'כן', '0527655521'  ,NULL
EXEC InsertSubscribers 1, 351582468, '2024-02-24', 'וקסשטוק',  'משפחת', 'תורת חסד 5', 4, 'לא', '025388466'  ,NULL
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
	SET AdultBooks = 'כן'
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
					WHEN 'כן' THEN 'יש אישור לספרי מבוגרים'
					WHEN 'לא' THEN 'אין אפשרות לקחת ספרי מבוגרים'
					ELSE 'אין אפשרות לקחת ספרי מבוגרים'
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
		FROM Books_tbl b1 JOIN Books_tbl b2 --b1 ספר, b2 ספר המשך
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