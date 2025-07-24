1. **Database Creation**:
   - Creates a new database named `LibraryDB`.

2. **Table Definitions**:
   - **Category_tbl**: Stores categories of books with a unique code.
   - **Authors_tbl**: Stores authors with a unique author ID.
   - **Books_tbl**: Contains details about books, including references to authors and categories, lending period, and a potential sequel.
   - **Subscribers_tbl**: Contains information about library subscribers, including personal details and whether they can borrow adult books.
   - **Lending_tbl**: Records lending transactions, linking subscribers to borrowed books.
   - **BooksLended_tbl**: Intended to track individual books that have been lent out (though it is subsequently dropped).

3. **Data Insertion Procedures**:
   - Procedures (`InsertCategory`, `InsertAuthors`, `InsertBooks`, `InsertSubscribers`, `InsertLending`) are created to insert data into their respective tables. These procedures are then executed to insert predefined data.

4. **Adult Book Permission Update**:
   - The `AdualtBooks` procedure updates a subscriber's permission to borrow adult books.

5. **Views**:
   - **NewBooks**: A view that shows books purchased within the last 30 days along with their authors.
   - **BooksTaken**: A view that counts how many times each author’s books have been lent out.

6. **Triggers**:
   - **CheckAdualtTrigger**: A trigger that activates on inserting a new lending record. It checks if the subscriber is allowed to borrow adult books based on their status.

7. **Functions**:
   - **FindContinueBook**: A function that returns the name of the sequel to a given book.
   - **FindBook**: A function that returns subscriber details for a specific book that has been lent.

Overall, this code sets up a comprehensive library management system with functionalities for managing books, authors, subscribers, and lending records, along with necessary checks and data retrieval features.
