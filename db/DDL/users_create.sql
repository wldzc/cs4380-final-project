#
#	Group #:			9
#
#	Group Members:		Anthony Forsythe, Songjie Wang, Weijin Li, Anjana Ramnath
#
#	Class:				CS4380 (Spring 2016)
#
#	Assignment:			Final Project
#
#	File Description:	This is the SQL file that will create all the users that will
#						access the database.


/*
	First make sure that team member users have access to the entire database
*/

#	Anthony
GRANT INSERT, UPDATE, DELETE, SELECT ON photoarchiving.* TO forsythetony WITH GRANT OPTION;

#	Songjie
GRANT INSERT, UPDATE, DELETE, SELECT ON photoarchiving.* TO songjie WITH GRANT OPTION;

