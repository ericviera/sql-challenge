-- ERD has been imported and cleaned up below
------------------------------------------------------------------
-- Create Departments Table
-- First CSV Import
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    PRIMARY KEY (dept_no)
);
--DROP TABLE departments; -- Delete Departments Table. Used for testing.
SELECT * FROM departments; -- Show Departments Table
------------------------------------------------------------------
-- Create the Titles table
-- Second CSV Import
CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);
--DROP TABLE titles; -- Delete titles Table. Used for testing.
SELECT * FROM titles; -- Show titles Table
------------------------------------------------------------------
-- Create Employees Table
-- Third CSV Import
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR NOT NULL,
    hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
--DROP TABLE employees; -- Delete employees Table. Used for testing.
SELECT * FROM employees; -- Show employees Table
------------------------------------------------------------------
-- Create the Department Employees Table
-- Fourth CSV Import
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments (dept_no)
);
--DROP TABLE dept_emp; -- Delete dept_emp Table. Used for testing.
SELECT * FROM dept_emp; -- Show dept_emp Table
------------------------------------------------------------------
-- Create the Department Manager Table
-- 5th CSV Import
CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT  NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);
--DROP TABLE dept_manager; -- Delete dept_manager Table. Used for testing.
SELECT * FROM dept_manager; -- Show dept_manager Table
------------------------------------------------------------------
-- Create the Salaries Table
-- Final CSV Import
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);
--DROP TABLE salaries; -- Delete salaries Table. Used for testing.
SELECT * FROM salaries; -- Show salaries Table
------------------------------------------------------------------