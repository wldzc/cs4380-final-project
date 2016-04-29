#
#	Group #:			9
#
#	Group Members:		Anthony Forsythe, Songjie Wang, Weijin Li, Anjana Ramnath
#
#	Class:				CS4380 (Spring 2016)
#
#	Assignment:			Final Project
#
#	File Description:	This is the SQL file that will create all the tables for our final project database.
#

#	TABLES LIST
#	
#	1)	Era ( era )
#	2)	Life Period ( life_period )
#
#
#
#

#
#	1)	Era 
#
CREATE TABLE era
(
	era_id			SERIAL,
	name			VARCHAR(100),
	start_date		DATE,
	end_date		DATE,
	PRIMARY KEY (era_id)
);


#
#	2)	Life Period
#
CREATE TABLE life_period
(
	period_id		SERIAL,
	name			VARCHAR(100),
	start_year		SMALLINT UNSIGNED,
	end_year		SMALLINT UNSIGNED,
	PRIMARY KEY (period_id)
);


#
#	3)	Person
#
CREATE TABLE person
(
	p_id		SERIAL,
	fname		VARCHAR(100),
	mname		VARCHAR(100),
	lname		VARCHAR(100),
	gender		VARCHAR(50),
	birthdate	DATE,
	PRIMARY KEY (p_id)
);


#
#	4)	non_user
#
CREATE TABLE non_user
(
	p_id		BIGINT UNSIGNED,
	death_date	DATE,
	FOREIGN KEY (p_id) REFERENCES person(p_id),
	PRIMARY KEY (p_id)
);


#
#	