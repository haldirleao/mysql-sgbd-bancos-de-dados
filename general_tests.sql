-- SQL FUNCTIONS
-- https://www.w3schools.com/sql/sql_ref_mysql.asp

-- The NOW() function returns the current date and time.
-- https://www.w3schools.com/sql/func_mysql_now.asp
select now();
select now() from dual;

-- Return the current version of the MySQL database:
select version();

show character set;

show databases;

use sys;
show tables;

use company;
select * from employee;
select * from dependent;
select * from department;
select * from dept_locations;
select * from project;
select * from works_on;

select e.Fname 'E fname', e.Lname as 'E lname', s.Fname as 'S fname', s.Lname as 'S fname'
	from employee e, employee s
		where e.Super_ssn = s.Ssn;
        
-- testando auto-incremento
-- https://dev.mysql.com/doc/refman/8.0/en/example-auto-increment.html
create database temp1;
show databases;
use temp1;
drop table emocoes;
create table emocoes (
	id mediumint not null auto_increment,
    emocao varchar(30) not null, 
    constraint unique_emocao unique(emocao), 
    primary key (id)
);
show tables;
-- inserindo com definicao da coluna
insert into emocoes (emocao) values ('alegre'), ('triste'), ('extasiado'), ('sorridente'), ('duvidoso'); 

-- inserindo sem definição da coluna
-- ATENÇÃO: não funciona se NO_AUTO_VALUE_ON_ZERO estiver habilitado.
insert into emocoes values (0, 'feliz'), (0, 'choroso');
-- Se a coluna é NOT NULL também pode ser assim:
insert into emocoes values (null, 'explendoroso'), (null, 'envergonhado');

update emocoes 
	set emocao = 'esplendoroso'
	where emocao = 'explendoroso';

select * from emocoes order by id;

-- Expressões regulares
-- https://dev.mysql.com/doc/refman/8.0/en/regexp.html
-- https://www.tutorialspoint.com/mysql/mysql-regexps.htm
SELECT 'Michael!' REGEXP '.*';
SELECT * FROM emocoes WHERE emocao REGEXP '^a';
SELECT * FROM emocoes WHERE emocao REGEXP 'oso';

-- STR_TO_DATE(string, format)
-- https://www.w3schools.com/mysql/func_mysql_str_to_date.asp
-- Return a date based on a string and a format
-- format deve reproduzir a string dada. Atente-se aos exemplos abaixo.
SELECT STR_TO_DATE("August 10 2017", "%M %d %Y");
SELECT STR_TO_DATE("DEC-21-2023", "%b-%d-%Y");
SELECT STR_TO_DATE("August,5,2017", "%M,%e,%Y");
SELECT STR_TO_DATE("Monday, August 14, 2017", "%W, %M %e, %Y");