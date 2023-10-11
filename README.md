# University-Database-System
The dataset is a relational database containing information about classrooms, departments, courses, instructors, students, sections, time slots, prerequisites, and advisors. It includes details like course titles, instructor names, department budgets, and more.  SQL queries are used to query and retrieve specific information from this database.

The files contain- 
- DDL: DDL with drop table
- Small relations Insert File: SQL code for creating small relations
  The file contains SQL insert statements to load data into all the tables, after first deleting any data that the tables currently contain.
The data include students taking courses outside their department, and instructors teaching courses outside their department; this helps detect errors in natural join specifications that accidentally equate department names of students or instructors with department names of courses.
- Large Relations Insert File: SQL code for creating large relations
  The file largeRelationsInsertFile.sql contains SQL insert statements for larger, randomly created relations for a truly strange university (since course titles and department names are chosen randomly).
- Queries.sql: SQL code for querying the data

##The sizes of the relations are as follows:
department	20
instructor	50
student	2000
course	200
prereq	100
section	100
time_slot	20
teaches	100
takes	30000
advisor	2000



