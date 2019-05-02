/*
  starter.sql - updated 4/17/2014
  
*/


SET foreign_key_checks = 0; #turn off constraints temporarily

#since constraints cause problems, drop tables first, working backward
DROP TABLE IF EXISTS srv_surveys;
DROP TABLE IF EXISTS srv_questions;
DROP TABLE IF EXISTS srv_users;


  #all tables must be of type InnoDB to do transactions, foreign key constraints
CREATE TABLE srv_surveys(
SurveyID INT UNSIGNED NOT NULL AUTO_INCREMENT,
AdminID INT UNSIGNED DEFAULT 0,
Title VARCHAR(255) DEFAULT '',
Description TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (SurveyID)
)ENGINE=INNODB; 

#assigning first survey to AdminID == 1
INSERT INTO srv_surveys VALUES (NULL,1,'Our First Survey','Description of Survey',NOW(),NOW()); 

#foreign key field must match size and type, hence SurveyID is INT UNSIGNED
CREATE TABLE srv_questions(
QuestionID INT UNSIGNED NOT NULL AUTO_INCREMENT,
SurveyID INT UNSIGNED DEFAULT 0,
Question TEXT DEFAULT '',
Description TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (QuestionID),
INDEX SurveyID_index(SurveyID),
FOREIGN KEY (SurveyID) REFERENCES srv_surveys(SurveyID) ON DELETE CASCADE
)ENGINE=INNODB;

INSERT INTO srv_questions VALUES (NULL,1,'Do You Like Our Website?','We really want to know!',NOW(),NOW());
INSERT INTO srv_questions VALUES (NULL,1,'Do You Like Cookies?','We like cookies!',NOW(),NOW());
INSERT INTO srv_questions VALUES (NULL,1,'Favorite Toppings?','We like chocolate!',NOW(),NOW());

/*
Add additional tables here
*/

CREATE TABLE srv_users(
UserID INT UNSIGNED NOT NULL AUTO_INCREMENT,
QuestionID INT UNSIGNED DEFAULT 0,
Username VARCHAR(255) DEFAULT '',
Email VARCHAR(255) DEFAULT '',
PRIMARY KEY (UserID),
INDEX QuestionID_index(QuestionID),
FOREIGN KEY (QuestionID) REFERENCES srv_questions(QuestionID) ON DELETE CASCADE
)ENGINE=INNODB;

INSERT INTO srv_users VALUES (1, 2,'firstusername','firstuser@email.com');


SET foreign_key_checks = 1; #turn foreign key check back on