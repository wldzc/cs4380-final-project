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
#	1)	Location Table
#	2)	Custom Timestamp Table
#	3)	Story Table
#	4)	Person Table
#	5)	User Table
#	6)	User Authentication Table
#	7)	User Preferences Table
#	8)	Repository Table
#	9)	Family Repository Table
#	10)	Community Repository Table
#	11)	Location Repository Table
#	12)	Photograph Table
#	13)	Photograph Tag Table
#	14)	Photograph Upload Table
#	15)	User Belongs to Repository Table



#
#	1 - Location Table
#
CREATE TABLE location 
( 
	l_id            SERIAL, 
	address         VARCHAR(50), 
	zip             INT, 
	state           VARCHAR(256), 
	country         VARCHAR(256), 
	gps_lat			REAL,
	gps_long		REAL,
	loc_type        VARCHAR(30), 
	location_conf   BOOL, 
	PRIMARY KEY (l_id) 
); 


#
#	2 - Custom Timestamp Table
#
CREATE TABLE custom_timestamp 
( 
	ct_id   SERIAL, 
	century SMALLINT,
	decade  SMALLINT,
	year    SMALLINT, 
	month   SMALLINT,
	day     SMALLINT,
	hour    SMALLINT, 
	PRIMARY KEY (ct_id) 
); 


#
#	3 - Story Table
#
CREATE TABLE story 
( 
	s_id        SERIAL, 
	p_id        BIGINT UNSIGNED, 
	title       VARCHAR(50), 
	description VARCHAR(256), 
	link_url    VARCHAR(50), 
	text        VARCHAR(1024), 
	PRIMARY KEY (s_id), 
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) ON DELETE CASCADE 
); 

#
#	4 - Person Table
#
CREATE TABLE person 
( 
	ps_id      SERIAL, 
	fname     VARCHAR(256), 
	lname     VARCHAR(256), 
	gender    VARCHAR(40), 
	birthdate DATE, 
	deathdate DATE 
	PRIMARY KEY (ps_id) 
);


#
#	5 - User Table
#	
CREATE TABLE user 
( 
	u_id             SERIAL, 
	p_id             BIGINT UNSIGNED, 
	permission_level SMALLINT NOT NULL DEFAULT 1, 
	username         VARCHAR(256) NOT NULL, 
	email            VARCHAR(256), 
	date_joined      TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	PRIMARY KEY (u_id), 
	FOREIGN KEY (p_id) REFERENCES person(p_id), 
	CONSTRAINT chk_permission_lvl CHECK (permission_level >= 0 AND 
	permission_level <= 10) 
); 


#
#	6 - User Authentication Table
#
CREATE TABLE user_authentication 
( 
	u_id          BIGINT UNSIGNED, 
	password_hash CHAR(40) NOT NULL, 
	salt          CHAR(40) NOT NULL, 
	PRIMARY KEY (u_id), 
	FOREIGN KEY (u_id) REFERENCES user(u_id) ON DELETE CASCADE 
);


#
#	7 - User Preferences
#
CREATE TABLE user_preferences 
( 
	u_id             BIGINT UNSIGNED, 
	text_size        SMALLINT NOT NULL, 
	hearing_impaired BOOL DEFAULT 0, 
	prefered_name    VARCHAR(256), 
	PRIMARY KEY (u_id), 
	FOREIGN KEY (u_id) REFERENCES user(u_id) 
); 


#
#	8 - Repository Table
#
create table repository
(
	r_id	serial,
	name	varchar(256),
	PRIMARY key (r_id)
);


#
#	9 - Family Repository Table
#
CREATE TABLE family_repository 
( 
	r_id        BIGINT UNSIGNED, 
	family_name VARCHAR(256), 
	PRIMARY KEY (r_id), 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) 
); 


#
#	10 - Community Repository Table
#
CREATE TABLE community_repository 
( 
	r_id           BIGINT UNSIGNED, 
	community_name VARCHAR(256), 
	PRIMARY KEY (r_id), 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) 
); 


#
#	11 - Location Repository Table
#
CREATE TABLE location_repository 
( 
	r_id          BIGINT UNSIGNED, 
	location_name VARCHAR(256), 
	PRIMARY KEY (r_id), 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) 
); 


#
#	12 - Photograph Table
#
CREATE TABLE photograph 
( 
	p_id        SERIAL, 
	ct_id       BIGINT UNSIGNED, 
	l_id        BIGINT UNSIGNED, 
	s_id        BIGINT UNSIGNED, 
	u_id        BIGINT UNSIGNED, 
	r_id        BIGINT UNSIGNED, 
	title       VARCHAR(40), 
	description VARCHAR(256), 
	thumb_url   VARCHAR(50), 
	large_url   VARCHAR(50), 
	PRIMARY KEY (p_id), 
	FOREIGN KEY (ct_id) REFERENCES custom_timestamp(ct_id), 
	FOREIGN KEY (l_id) REFERENCES location(l_id), 
	FOREIGN KEY (s_id) REFERENCES story(s_id), 
	FOREIGN KEY (u_id) REFERENCES user(u_id) ON DELETE CASCADE, 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE CASCADE 
); 


#
#	13 - Photograph Tag Table
#
CREATE TABLE photograph_tag 
( 
	p_id  BIGINT UNSIGNED, 
	ps_id BIGINT UNSIGNED, 
	time_tagged	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (p_id, ps_id), 
	FOREIGN KEY (ps_id) REFERENCES person(ps_id), 
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) 
); 


#
#	14 - Photograph Upload Table
#
CREATE TABLE photograph_upload 
( 
	p_id	BIGINT UNSIGNED, 
	u_id	BIGINT UNSIGNED, 
	r_id	BIGINT UNSIGNED, 
	PRIMARY KEY (p_id, u_id, r_id), 
	FOREIGN KEY (p_id) REFERENCES photograph(p_id), 
	FOREIGN KEY (u_id) REFERENCES user(u_id), 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) 
); 


#
#	15 - User Belongs to Repository Table
#
CREATE TABLE user_repository 
( 
	u_id             BIGINT UNSIGNED, 
	r_id             BIGINT UNSIGNED, 
	date_joined      TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	permission_level TINYINT UNSIGNED, 
	PRIMARY KEY (u_id, r_id), 
	FOREIGN KEY (u_id) REFERENCES user(u_id), 
	FOREIGN KEY (r_id) REFERENCES repository(r_id) 
);