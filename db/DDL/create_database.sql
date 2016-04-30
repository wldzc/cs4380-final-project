/*
	DATABASE CREATION
*/

#	Drop the database to start fresh again
DROP DATABASE IF EXISTS photoarchiving;

#	Make sure the correct database (photoarchiving) is created
CREATE DATABASE IF NOT EXISTS photoarchiving;

#	Make sure you're using the right database
USE photoarchiving;



/*
	TABLE CREATION
*/
SOURCE ./table_create.sql;


/*
	INPUT DATA
*/
SOURCE ./input_data.sql;


/*
	USERS CREATION
*/
SOURCE ./users_create.sql;

/*
	VIEWS CREATION
*/
# SOURCE ./view_create.sql;


/*
	TRIGGER CREATION
*/
# SOURCE ./tigger_create.sql;