drop table Jobs;
drop table Jobs_Skills;
drop table Positions;
drop table Candidates;
drop table Candidates_Skills;

create table Jobs (
	job varchar(8) ,
	grade integer,
	primary key (job, grade)
);

insert into Jobs (job, grade) values ('QA', 1);
insert into Jobs (job, grade) values ('DEV', 1);
insert into Jobs (job, grade) values ('DEV', 2);
insert into Jobs (job, grade) values ('DEV', 3);

create table Jobs_Skills (
	job varchar(8),
	grade integer,
	skill varchar(32),
	years integer,
	primary key (job, grade, skill)
);

insert into Jobs_Skills (job, grade, skill, years) values ('QA', 1, 'Java', 2);
insert into Jobs_Skills (job, grade, skill, years) values ('QA', 1, 'DB', 1);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 1, 'Java', 3);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 1, 'DB', 1);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 2, 'Java', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 2, 'DB', 3);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'Java', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'C++', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'DB', 5);

create table Positions (
	job varchar(8),
	grade integer,
	company varchar(32),
	salary integer,
	primary key (job, grade, company)
);

insert into Positions (job, grade, company, salary) values ('QA', 1, 'IBM', 100);
insert into Positions (job, grade, company, salary) values ('DEV', 2, 'IBM', 125);
insert into Positions (job, grade, company, salary) values ('DEV', 3, 'IBM', 150);
insert into Positions (job, grade, company, salary) values ('QA', 1, 'SAP', 85);
insert into Positions (job, grade, company, salary) values ('DEV', 1, 'SAP', 95);
insert into Positions (job, grade, company, salary) values ('DEV', 2, 'SAP', 110);
insert into Positions (job, grade, company, salary) values ('DEV', 3, 'SAP', 135);


create table Candidates (
	candidate varchar(32) primary key,
	salary integer
);

insert into Candidates (candidate, salary) values ('Ann', 100);
insert into Candidates (candidate, salary) values ('Bob', 75);
insert into Candidates (candidate, salary) values ('Cathy', 130);
insert into Candidates (candidate, salary) values ('Debbie', 85);
insert into Candidates (candidate, salary) values ('Emma', 120);
insert into Candidates (candidate, salary) values ('Frank', 110);
insert into Candidates (candidate, salary) values ('Greg', 90);

create table Candidates_Skills (
	candidate varchar(32),
	skill varchar(32),
	years integer,
	primary key (candidate, skill)
);

insert into Candidates_Skills (candidate, skill, years) values ('Ann', 'Java', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Ann', 'DB', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Bob', 'Java', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'Java', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'C++', 4);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'DB', 8);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'Python', 4);
insert into Candidates_Skills (candidate, skill, years) values ('Debbie', 'Java', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Debbie', 'DB', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Emma', 'C++', 4);
insert into Candidates_Skills (candidate, skill, years) values ('Emma', 'Ruby', 5);

