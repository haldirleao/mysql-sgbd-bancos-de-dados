create schema if not exists company_constraints_alter;
use company_constraints_alter;

-- Constraint assigned to a Domain
-- create domain D_num as int check(D_num > 0 and D_num < 21); 

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
	constraint chk_salary_employee
		check (Salary > 2000.0), -- minimum salary accepted in the company
    primary key (Ssn)
    );
    
desc employee;

create table if not exists department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    primary key (Dnumber),
	constraint unique_name_dept unique (Dname),
    constraint fk_employee foreign key (Mgr_ssn) references employee(Ssn)
    );
    
-- Modify a constraint: drop & add
alter table department
	drop constraint fk_employee;
alter table department
	add constraint fk_employee_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;
    
desc department;
    
create table if not exists dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    constraint fk_dept foreign key (Dnumber) references department(Dnumber) 
    );

-- Modify a constraint: drop & add
alter table dept_locations
	drop constraint fk_dept;
alter table dept_locations
	add constraint fk_dept_locations foreign key(Dnumber) references department(Dnumber)
    on delete cascade
    on update cascade;

create table if not exists project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project_name unique (Pname),
    constraint fk_dept_project foreign key (Dnum) references department(Dnumber)
    );

create table if not exists works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project foreign key (Pno) references project(Pnumber)
    );
    
-- Modify a constraint: drop & add
alter table works_on
	drop constraint fk_project;
alter table works_on
	add constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
    on delete cascade
    on update cascade;
    
create table if not exists dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F or M
    Bdate date,
    Relationship varchar(8),
    Age int not null,
    constraint chk_age_dependent check (Age < 22),
    primary key (Essn, Dependent_name),
    constraint fk_employee_dependent foreign key (Essn) references employee(Ssn)
    );
    
show tables;
    
select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints_alter';

select * from information_schema.referential_constraints
	where constraint_schema = 'company_constraints_alter';
    
-- Alter tables
alter table employee
	add constraint fk_employee_employee
    foreign key (Super_ssn)	references employee(Ssn) 
    on delete set null
    on update cascade;
    

    

