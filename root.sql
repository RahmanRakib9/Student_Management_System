/* Create the database */
CREATE DATABASE University;
USE University;

/* Create the student_info table */
CREATE TABLE student_info(
    roll INT NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    parents_contact_number CHAR(11) NOT NULL,
    email VARCHAR(30) NOT NULL
);

/* Create tables for exams */
CREATE TABLE DS_exam(
    roll INT NOT NULL UNIQUE PRIMARY KEY,
    obtained_number INT NOT NULL
);

CREATE TABLE ALGO_exam(
    roll INT NOT NULL UNIQUE PRIMARY KEY,
    obtained_number INT NOT NULL
);

CREATE TABLE OOP_exam(
    roll INT NOT NULL UNIQUE PRIMARY KEY,
    obtained_number INT NOT NULL
);

/* Populate the database*/
INSERT INTO student_info (roll, name, parents_contact_number, email) VALUES
(1, 'John Doe', '12345678901', 'john.doe@example.com'),
(2, 'Jane Smith', '23456789012', 'jane.smith@example.com'),
(3, 'Michael Johnson', '34567890123', 'michael.johnson@example.com');

INSERT INTO DS_exam(roll, obtained_number)
SELECT roll, FLOOR(RAND()*101) FROM student_info;

INSERT INTO ALGO_exam(roll, obtained_number)
SELECT roll, FLOOR(RAND()*101) FROM student_info;

INSERT INTO OOP_exam(roll, obtained_number)
SELECT roll, FLOOR(RAND()*101) FROM student_info;

/*  Add a New Student*/
INSERT INTO student_info (roll, name, parents_contact_number, email)
VALUES (4, 'Emily Davis', '45678901234', 'emily.davis@example.com');

/*Automatically Assign Exam Scores:*/
INSERT INTO DS_exam (roll, obtained_number) VALUES (4, FLOOR(RAND()*101));
INSERT INTO ALGO_exam (roll, obtained_number) VALUES (4, FLOOR(RAND()*101));
INSERT INTO OOP_exam (roll, obtained_number) VALUES (4, FLOOR(RAND()*101));

/*Update an Existing Student*/
UPDATE student_info
SET parents_contact_number = '56789012345', email = 'emily.new@example.com'
WHERE roll = 4;

/*Update Exam Scores:*/
UPDATE DS_exam
SET obtained_number = 90
WHERE roll = 4;

/*Delete a Student*/
DELETE FROM student_info WHERE roll = 4;
DELETE FROM DS_exam WHERE roll = 4;
DELETE FROM ALGO_exam WHERE roll = 4;
DELETE FROM OOP_exam WHERE roll = 4;


/* Retrieve all students with scores*/
SELECT student_info.roll, student_info.name, student_info.parents_contact_number,
       DS_exam.obtained_number AS DS_Score,
       ALGO_exam.obtained_number AS ALGO_Score,
       OOP_exam.obtained_number AS OOP_Score
FROM student_info
LEFT JOIN DS_exam ON student_info.roll = DS_exam.roll
LEFT JOIN ALGO_exam ON student_info.roll = ALGO_exam.roll
LEFT JOIN OOP_exam ON student_info.roll = OOP_exam.roll;

/*Automatically deletes related exam records when a student is deleted*/
DELIMITER //

CREATE TRIGGER after_student_delete
AFTER DELETE ON student_info
FOR EACH ROW
BEGIN
    DELETE FROM DS_exam WHERE roll = OLD.roll;
    DELETE FROM ALGO_exam WHERE roll = OLD.roll;
    DELETE FROM OOP_exam WHERE roll = OLD.roll;
END;
//

DELIMITER ;

/* Create View fr generating summary*/
CREATE VIEW student_summary AS
SELECT student_info.roll, student_info.name,
       DS_exam.obtained_number AS DS_Score,
       ALGO_exam.obtained_number AS ALGO_Score,
       OOP_exam.obtained_number AS OOP_Score,
       (DS_exam.obtained_number + ALGO_exam.obtained_number + OOP_exam.obtained_number) AS Total_Marks
FROM student_info
LEFT JOIN DS_exam ON student_info.roll = DS_exam.roll
LEFT JOIN ALGO_exam ON student_info.roll = ALGO_exam.roll
LEFT JOIN OOP_exam ON student_info.roll = OOP_exam.roll;




