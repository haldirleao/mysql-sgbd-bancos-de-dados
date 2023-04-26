create schema if not exists company_alter_table;
use company_alter_table;

create table if not exists employee(
	Fname varchar(15) NOT NULL,
    Minit char,
    Lname varchar(15) NOT NULL,
    -- ssn: Social Security Number
    Ssn char(9) not  null, -- char tem tamanho fixo
	Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    primary key (Ssn)
    );

create table if not exists department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    primary key (Dnumber),
    unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
    );
    
create table if not exists dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references department(Dnumber) 
    );

create table if not exists project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    unique (Pname),
    foreign key (Dnum) references department(Dnumber)
	);

create table if not exists works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    foreign key (Essn) references employee(Ssn),
    foreign key (Pno) references project(Pnumber)
    );
    
create table if not exists dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F or M
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    foreign key (Essn) references employee(Ssn)
    );
    
show tables;
desc works_on;

select * from information_schema.table_constraints
	where constraint_schema = 'company_alter_table';

select * from information_schema.referential_constraints
	where constraint_schema = 'company_alter_table';
    
-- Alter tables
alter table employee
	add constraint fk_employee_employee
    foreign key (Super_ssn)	references employee(Ssn) 
    on delete set null
    on update cascade;
    
-- Modify a constraint: drop & add
alter table department
	drop constraint department_ibfk_1;
alter table department
	add constraint fk_employee_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;
    

