show databases;
create database if not exists first_example;
use first_example;
show tables;

-- Create the 'person' table if it does not exists.
CREATE table if not exists person(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	gender enum('M','F'),
	birthday_date date,
	street varchar(20),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);
desc person;

-- Create the 'favorite_food' table if it does not exists.
create table if not exists favorite_food (
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id)
		references person(person_id)
);
show tables;
desc favorite_food;
show databases;

-- View the constraints from 'first_example' database
-- Sobre constraints: https://www.w3schools.com/sql/sql_constraints.asp
select * from information_schema.table_constraints 
	where constraint_schema= 'first_example';

-- View the constraints from a specific table of 'first_example' database.
select * from information_schema.table_constraints 
	where table_name = 'favorite_food';
    
desc person;
-- Insert data in the table 'person'
insert into person values 	('1', 'Carolina', 'Silva', 'F', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26054-89');
insert into person values 	('2', 'Carolina', 'Silva', 'F', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26029-60'),
							('3', 'Carolina', 'Silva', 'F', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26054-89'),
                            ('4', 'Carolina', 'Silva', 'F', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26054-89'),
                            ('5', 'Roberta', 'Silva', 'F', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26054-89'),
                            ('6', 'Luiz', 'Silva', 'M', '1979-08-21', 'rua Tal',
							'Cidade J', 'RJ', 'Brasil', '26054-89');
select * from person;

delete from person where person_id = 2
					  or person_id = 3
                      or person_id = 4;

desc favorite_food;
-- Insert data in the table 'favorite_food'
insert into favorite_food values (1, 'lasanha'),
								 (5, 'carne assada'),
								 (6, 'fettuccine');
select * from favorite_food;