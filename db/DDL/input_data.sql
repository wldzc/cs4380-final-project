#	Make sure that you're using the right database
USE photoarchiving;



#	Load data for the eras table
LOAD DATA LOCAL INFILE '../input_data/era.csv' INTO TABLE era
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(name, @start_date, @end_date)
SET 
	start_date 	= STR_TO_DATE(@start_date, '%c-%e-%Y'),
	end_date	= STR_TO_DATE(@end_date, '%c-%e-%Y')
;


#	Load data for the life_period table
LOAD DATA LOCAL INFILE '../input_data/life_period.csv' INTO TABLE life_period
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
( name , start_year , end_year );

