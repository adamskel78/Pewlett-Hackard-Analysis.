--Employee Retire Info
SELECT 
	e.emp_no
	,(e.first_name, e.last_name) as Name
	,t.title
	,t.from_date
	,s.salary
--INTO retire_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--GROUP BY(t.title)

--Employee Retire Info
SELECT 
	e.emp_no
	,(e.first_name, e.last_name) as Name
	,t.title
	,t.from_date
	,s.salary
--INTO retire_info
FROM titles as t
INNER JOIN employees as e
ON (e.emp_no = t.emp_no)
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
GROUP BY(t.title)
;


concat(FirstName,' ',LastName)
--Employee Retire Info
SELECT 
	e.emp_no
	,concat(e.first_name,' ',e.last_name) as Name
	,t.title
	,t.from_date
	,s.salary
INTO retire_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--GROUP BY(t.title)
;

select * from retire_info;

-- Partition the data to show only most recent title per employee
SELECT 
	emp_no
	,name
	,title
	,from_date
	,salary
INTO retire_title
FROM
(SELECT 
  	ri.emp_no
 	,ri.name
 	,ri.title
	,ri.from_date
 	,ri.salary 
 	,ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) AS rn
 FROM retire_info as ri) as dmp
WHERE rn = 1
ORDER BY emp_no
;

SELECT * FROM retire_title


SELECT COUNT(ri.emp_no), ri.title
INTO retire_total
FROM retire_title as ri
GROUP BY ri.title ;

SELECT * FROM retire_total;