# Assignment 03

## Problem Statement
Prepare the following scenarios for your database:

* create a stored procedure that inserts data in tables that are in a m:n relationship; if one insert fails, all the operations performed by the procedure must be rolled back );
* create a stored procedure that inserts data in tables that are in a m:n relationship; if an insert fails, try to recover as much as possible from the entire operation: for example, if the user wants to add a book and its authors, succeeds creating the authors, but fails with the book, the authors should remain in the database;
* reproduce the following concurrency issues under pessimistic isolation levels: dirty reads, non-repeatable reads, phantom reads, and a deadlock (4 different scenarios); you can use stored procedures and / or stand-alone queries; find solutions to solve / workaround the concurrency issues;
* reproduce the update conflict under an optimistic isolation level.
