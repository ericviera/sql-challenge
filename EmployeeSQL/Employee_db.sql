------------------------------------------------------------------
-- Create Departments Table
-- First CSV Import
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    PRIMARY KEY (dept_no)
);
DROP TABLE departments; -- Delete Departments Table. Used for testing.
SELECT * FROM departments; -- Show Departments Table
------------------------------------------------------------------
-- Create the Titles table
-- Second CSV Import
CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);
DROP TABLE titles; -- Delete titles Table. Used for testing.
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
DROP TABLE employees; -- Delete employees Table. Used for testing.
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
DROP TABLE dept_emp; -- Delete dept_emp Table. Used for testing.
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
DROP TABLE dept_manager; -- Delete dept_manager Table. Used for testing.
SELECT * FROM dept_manager; -- Show dept_manager Table
------------------------------------------------------------------
-- Create the Salaries Table
-- Final CSV Import
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);
DROP TABLE salaries; -- Delete salaries Table. Used for testing.
SELECT * FROM salaries; -- Show salaries Table
------------------------------------------------------------------
--Data Analysis
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
-- https://www.postgresqltutorial.com/postgresql-date_part/
SELECT first_name, last_name, hire_date FROM employees WHERE DATE_PART('year', hire_date) = 1986; 


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager JOIN departments ON dept_manager.dept_no = departments.dept_no JOIN employees ON dept_manager.emp_no = employees.emp_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no INNER JOIN departments ON departments.dept_no=dept_emp.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex 
FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name='Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name='Sales' OR departments.dept_name='Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name ORDER BY COUNT(last_name) DESC;
