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
#	1)	Era 				( era )
#	2)	Life Period 			( life_period )
#	3)	Person				( person )
#	4)	Non-User			( non_user )
#	5)	User				( user )
#	6)	User Authentication		( user_auth )
#	7)	User Preferences		( user_pref )
#	8)	Repository			( repository )
#	9)	Family Repository		( family_repository )
#	10)	Location Repository		( location_repository )
#	11)	Community Repository		( user_repo )
#	12)	Person Relation			( person_relation )
#	13)	Location			( location )
#	14)	Photograph 			( photograph )
#	15)	Photograph Tag			( photo_tag )
#	16)	Story				( story )
#	17)	Photo Story			( photo_story )
#	18)	User Activity			( user_activity )
#	19)	Log				( log )
#	20)	Session Log			( session_log )
#	21)	Activity Log			( activity_log )
#	22) 	Photo repository 		( photo_repo)

#
#	1)	Era ( era )
#
DROP TABLE IF EXISTS era;
CREATE TABLE era
(
	era_id			SERIAL,
	name			VARCHAR(100) NOT NULL,
	start_date		DATE,
	end_date		DATE,
	PRIMARY KEY (era_id)
);


#
#	2)	Life Period ( life_period )
#
DROP TABLE IF EXISTS life_period;
CREATE TABLE life_period
(
	period_id		SERIAL,
	name			VARCHAR(100) NOT NULL,
	start_year		SMALLINT UNSIGNED,
	end_year		SMALLINT UNSIGNED,
	PRIMARY KEY (period_id)
);


#
#	3)	Person ( person )
#
DROP TABLE IF EXISTS person;
CREATE TABLE person
(
	ps_id		SERIAL,
	fname		VARCHAR(100) NOT NULL,
	mname		VARCHAR(100),
	lname		VARCHAR(100),
	gender		VARCHAR(50),
	birthdate	DATE,
	PRIMARY KEY (ps_id)
);


#
#	4)	Non User	( non_user )
#
DROP TABLE IF EXISTS non_user;
CREATE TABLE non_user
(
	ps_id		BIGINT UNSIGNED,
	death_date	DATE,
	FOREIGN KEY (ps_id) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY (ps_id)
);


#
#	5)	User	( user )
#
DROP TABLE IF EXISTS user;
CREATE TABLE user
(
	ps_id			BIGINT UNSIGNED,
	username		VARCHAR(250) NOT NULL,
	email			VARCHAR(500),
	date_joined		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY 	(ps_id) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY 	(ps_id)	
);


#
#	6)	User Authentication ( user_auth )
#
DROP TABLE IF EXISTS user_auth;
CREATE TABLE user_auth
(
	ps_id			BIGINT UNSIGNED,
	pass_hash		CHAR(40) NOT NULL,
	pass_salt		CHAR(40) NOT NULL,
	FOREIGN KEY (ps_id) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY (ps_id)
);


#
#	7)	User Preferences	( user_pref )
#
DROP TABLE IF EXISTS user_pref;
CREATE TABLE user_pref
(
	ps_id			BIGINT UNSIGNED,
	text_size		SMALLINT UNSIGNED,
	hearing_impaired	BOOLEAN NOT NULL DEFAULT FALSE,
	preferred_name		VARCHAR(200),
	FOREIGN KEY (ps_id) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY (ps_id)
);


#
#	8)	Repository	( repository )
#
DROP TABLE IF EXISTS repository;
CREATE TABLE repository
(
	r_id				SERIAL,
	name				VARCHAR(300) NOT NULL,
	description			TEXT,
	date_created		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (r_id)
);


#
#	9)	Family Repository	( family_repository )
#
DROP TABLE IF EXISTS family_repository;
CREATE TABLE family_repository
(
	r_id				BIGINT UNSIGNED,
	family_name			VARCHAR(500) NOT NULL,
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE CASCADE,
	PRIMARY KEY (r_id)
);


#
#	10)	Location Repository	( location_repository )
#
DROP TABLE IF EXISTS location_repository;
CREATE TABLE location_repository
(
	r_id				BIGINT UNSIGNED,
	location_name		VARCHAR(500) NOT NULL,
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE CASCADE,
	PRIMARY KEY (r_id)	
);


#
#	11)	Community Repository	( community_repository )
#
DROP TABLE IF EXISTS community_repository;
CREATE TABLE community_repository
(
	r_id			BIGINT UNSIGNED,
	community_name		VARCHAR(500) NOT NULL,
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE CASCADE,
	PRIMARY KEY (r_id)	
);


#
#	12)	Person Relation	( person_relation )
#
DROP TABLE IF EXISTS person_relation;
CREATE TABLE person_relation
(
	re_id			SERIAL,
	related_from		BIGINT UNSIGNED NOT NULL,
	related_to		BIGINT UNSIGNED NOT NULL,
	relation		VARCHAR(200) NOT NULL,
	FOREIGN KEY (related_from) REFERENCES person(ps_id) ON DELETE CASCADE,
	FOREIGN KEY (related_to) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY (re_id)	
);


#
#	13) Location	( location )
#
DROP TABLE IF EXISTS location;
CREATE TABLE location
(
	l_id				SERIAL,
	coord_lat			DECIMAL(18,12),
	coord_long			DECIMAL(18,12),
	country				VARCHAR(300),
	state				VARCHAR(150),
	loc_type			VARCHAR(100),
	zip				VARCHAR(6),
	street_address			VARCHAR(300),
	loc_conf			BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY (l_id)
);


#
#	14)	Photograph	( photograph )
#
DROP TABLE IF EXISTS photograph;
CREATE TABLE photograph
(
	p_id				SERIAL,
	title				VARCHAR(200),
	description			TEXT,
	large_url			VARCHAR(2083),
	thumb_url			VARCHAR(2083),
	date_taken			DATE,
	date_conf			BOOLEAN NOT NULL DEFAULT FALSE,
	l_id				BIGINT UNSIGNED,
	FOREIGN KEY (l_id) REFERENCES location(l_id) ON DELETE NO ACTION,
	PRIMARY KEY (p_id)	
);


#
#	15)	Photograph Tag	( photo_tag )
#
DROP TABLE IF EXISTS photo_tag;
CREATE TABLE photo_tag
(
	p_id				BIGINT UNSIGNED,
	ps_id				BIGINT UNSIGNED,
	time_tagged			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) ON DELETE CASCADE,
	FOREIGN KEY (ps_id) REFERENCES person(ps_id) ON DELETE CASCADE,
	PRIMARY KEY (p_id, ps_id)
);


#
#	16)	Story	( story )
#
DROP TABLE IF EXISTS story;
CREATE TABLE story
(
	s_id				SERIAL,
	title				VARCHAR(200),
	description			TEXT,
	recording_url			VARCHAR(2083),
	recording_text			TEXT,
	PRIMARY KEY (s_id)
);


#
#	17)	Photo Story	( photo_story )
#
DROP TABLE IF EXISTS photo_story;
CREATE TABLE photo_story
(
	p_id				BIGINT UNSIGNED,
	s_id				BIGINT UNSIGNED,
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) ON DELETE CASCADE,
	FOREIGN KEY (s_id) REFERENCES story(s_id) ON DELETE CASCADE,
	PRIMARY KEY (p_id, s_id)
);


#
#	18) User Activity	( user_activity )
#
DROP TABLE IF EXISTS user_activity;
CREATE TABLE user_activity
(
	ac_id				SERIAL,
	ac_type				VARCHAR(200) NOT NULL,
	PRIMARY KEY (ac_id)	
);



#
#	19) Log	( log )
#
DROP TABLE IF EXISTS log;
CREATE TABLE log
(
	lo_id				SERIAL,
	ps_id				BIGINT UNSIGNED,
	time_logged			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (ps_id) REFERENCES person(ps_id) ON DELETE NO ACTION,
	PRIMARY KEY (lo_id)	
);


#
#	20) Session Log	( session_log )
#
DROP TABLE IF EXISTS session_log;
CREATE TABLE session_log
(
	lo_id				BIGINT UNSIGNED,
	login_time			TIMESTAMP,
	logout_time			TIMESTAMP,
	FOREIGN KEY (lo_id) REFERENCES log(lo_id) ON DELETE CASCADE,
	PRIMARY KEY (lo_id)	
);


#
#	21) Activity Log	( activity_log )
#
DROP TABLE IF EXISTS activity_log;
CREATE TABLE activity_log
(
	lo_id				BIGINT UNSIGNED,
	ac_type				BIGINT UNSIGNED,
	s_id				BIGINT UNSIGNED,
	p_id				BIGINT UNSIGNED,
	r_id				BIGINT UNSIGNED,
	FOREIGN KEY (lo_id) REFERENCES log(lo_id) ON DELETE CASCADE,
	FOREIGN KEY (ac_type) REFERENCES user_activity(ac_id) ON DELETE NO ACTION,
	FOREIGN KEY (s_id) REFERENCES story(s_id) ON DELETE NO ACTION,
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) ON DELETE NO ACTION,
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE NO ACTION,
	PRIMARY KEY (lo_id)	
);

#
#	22) Photo Repository	( photo_repo)
#
DROP TABLE IF EXISTS photo_repo;
CREATE TABLE photo_repo
(
	p_id 				BIGINT UNSIGNED,
	r_id 				BIGINT UNSIGNED,
	FOREIGN KEY (p_id) REFERENCES photograph(p_id) ON DELETE CASCADE,
	FOREIGN KEY (r_id) REFERENCES repository(r_id) ON DELETE CASCADE,
	PRIMARY KEY (p_id, r_id)
);
