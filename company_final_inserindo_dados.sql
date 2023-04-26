-- Data insertion in the company database
-- source: mysql_sql_database_specialist/Módulo 3/curso2/insercao_de_dados_e_queries_sql.sql

-- Queries revisadas por haldirleao em 25/04/2023.
-- Agora todas funcionam
-- NOTA: exceto os 'insert', caso as tabelas já tenham sido carredadas com os registros. 

use company;
 
insert into employee values ('John', 'B', 'Smith', 123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, null, 5),
							('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 123456789, 5),
                            ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 333445555, 4),
                            ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, 999887777, 4),
                            ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, 333445555, 5),
                            ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, 666884444, 5),
                            ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 987654321, 4),
                            ('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, 987987987, 1);

-- Estudar: Ssn é a primary key, mesmo assim lança o erro:
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
--   Cannot use range access on index 'PRIMARY' due to type or collation conversion on field 'Ssn' To disable safe mode, 
--   toggle the option in Preferences -> SQL Editor and reconnect.
-- Solução paliativa. Desabilitar safe update mode: 'SET sql_safe_updates=0;'
SET sql_safe_updates=0;
UPDATE employee
	SET Super_ssn = 453453453
	WHERE Ssn = 123456789;
SET sql_safe_updates=1;

insert into dependent values (333445555, 'Alice', 'F', '1986-04-05', 'Daughter', 21),
							 (333445555, 'Theodore', 'M', '1983-10-25', 'Son', 7),
                             (333445555, 'Joy', 'F', '1958-05-03', 'Spouse', 10),
                             (987654321, 'Abner', 'M', '1942-02-28', 'Spouse', 15),
                             (123456789, 'Michael', 'M', '1988-01-04', 'Son', 18),
                             (123456789, 'Alice', 'F', '1988-12-30', 'Daughter', 20),
                             (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse', 1);

-- Error Code: 3819. Check constraint 'chk_age_dependent' is violated.
-- Idade >= 22, logo gera erro devido: 'constraint chk_age_dependent check (Age < 22)' da tabela
/*
UPDATE dependent
	SET Age = 25
	WHERE Essn = 333445555 and Dependent_name = 'Alice';
SET sql_safe_updates=1;
*/

insert into department values ('Research', 5, 333445555, '1988-05-22','1986-05-22'),
							   ('Administration', 4, 987654321, '1995-01-01','1994-01-01'),
                               ('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');

insert into dept_locations values (1, 'Houston'),
								 (4, 'Stafford'),
                                 (5, 'Bellaire'),
                                 (5, 'Sugarland'),
                                 (5, 'Houston');

insert into project values ('ProductX', 1, 'Bellaire', 5),
						   ('ProductY', 2, 'Sugarland', 5),
						   ('ProductZ', 3, 'Houston', 5),
                           ('Computerization', 10, 'Stafford', 4),
                           ('Reorganization', 20, 'Houston', 1),
                           ('Newbenefits', 30, 'Stafford', 4);

insert into works_on values (123456789, 1, 32.5),
							(123456789, 2, 7.5),
                            (666884444, 3, 40.0),
                            (453453453, 1, 20.0),
                            (453453453, 2, 20.0),
                            (333445555, 2, 10.0),
                            (333445555, 3, 10.0),
                            (333445555, 10, 10.0),
                            (333445555, 20, 10.0),
                            (999887777, 30, 30.0),
                            (999887777, 10, 10.0),
                            (987987987, 10, 35.0),
                            (987987987, 30, 5.0),
                            (987654321, 30, 20.0),
                            (987654321, 20, 15.0),
                            (888665555, 20, 0.0);

-- Consultas SQL

select * from employee;
select * from dependent;
select * from department;
select * from dept_locations;
select * from project;
select * from works_on;

select Ssn, count(Essn) from employee e, dependent d where (e.Ssn = d.Essn) group by Ssn;
select * from dependent;

SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

select * from department where Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee, department
WHERE Dname = 'Research' AND Dnumber = Dno;

select * from project;
--
--
--
-- Expressões e concatenação de strings
--
--
-- recuperando informações dos departmentos presentes em Stafford
select Dname as Department, Mgr_ssn as Manager from department d, dept_locations l
where d.Dnumber = l.Dnumber;

-- padrão sql -> || no MySQL usa a função concat()
select Dname as Department, concat(Fname, ' ', Lname) from department d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando info dos projetos em Stafford
select * from project, department where Dnum = Dnumber and Plocation = 'Stafford';

-- recuperando info sobre os departmentos e projetos localizados em Stafford
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project, department, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND
Plocation = 'Stafford';

SELECT * FROM employee WHERE Dno IN (3,6,9);

--
--
-- Operadores lógicos
--
--

SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = 'Research' AND Dnumber = Dno;

--
--
-- Expressões e alias
--
--

-- recolhendo o valor do INSS-*
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao ProdutoX
select e.Fname, e.Lname, 1.1*e.Salary as increased_sal from employee as e,
works_on as w, project as p where e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX';

-- concatenando e fornecendo alias
select Dname as Department, concat(Fname, ' ', Lname) as Manager from department d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando dados dos empregados que trabalham para o departmento de pesquisa
select Fname, Lname, Address from employee, department
	where Dname = 'Research' and Dnumber = Dno;

-- definindo alias para legibilidade da consulta
select e.Fname, e.Lname, e.Address from employee e, department d
	where d.Dname = 'Research' and d.Dnumber = e.Dno;
