# Student Management System
This project, developed for the CSE311 Database Management Systems course, is a fully functional Student Management System built using SQL. It demonstrates the fundamental concepts of database creation, manipulation, and advanced features like triggers and views. The system manages students' information, their exam scores, and provides tools for adding, updating, and deleting student records.

## Features
### 1. Database Creation
* A database named University stores student and exam data.
* Tables include:
  * `student_info` for storing student details.
  * `DS_exam`, `ALGO_exam`, and `OOP_exam` for storing scores of three subjects.

### 2. Basic Operations
* Add a new student with automatically assigned random scores for exams.
* Update an existing student's details and their exam scores.
* Delete a student and their corresponding exam records.

### 3. Advanced Features
* Trigger: Automatically deletes related exam scores when a student is removed.
* View: Generates a summarized report of all students with their total marks across all subjects.
