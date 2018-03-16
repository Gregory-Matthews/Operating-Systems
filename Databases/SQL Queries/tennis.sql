drop table Tennis_Players;
drop table Years_Ranked_First;
drop table Countries;

create table Tennis_Players (
	name varchar(32) primary key,
	country varchar(32),
	ATP_rank integer,
	age integer,
	points integer
);

insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Djokovic', 'Serbia', 1, 29, 15040);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Murray', 'UK', 2, 29, 10195);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Federer', 'Switzerland', 3, 34, 5945);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Nadal', 'Spain', 4, 30, 5290);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Wawrinka', 'Switzerland', 5, 31, 4720);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Nishikori', 'Japan', 6, 26, 4290);
insert into Tennis_Players(name, country, ATP_rank, age, points) values ('Raonic', 'Serbia', 7, 25, 4285);

create table Years_Ranked_First (
	name varchar(32),
	year integer,
	primary key (name, year)
);

insert into Years_Ranked_First(name, year) values ('Djokovic', 2015);
insert into Years_Ranked_First(name, year) values ('Djokovic', 2014);
insert into Years_Ranked_First(name, year) values ('Nadal', 2013);
insert into Years_Ranked_First(name, year) values ('Djokovic', 2012);
insert into Years_Ranked_First(name, year) values ('Djokovic', 2011);
insert into Years_Ranked_First(name, year) values ('Nadal', 2010);
insert into Years_Ranked_First(name, year) values ('Federer', 2009);
insert into Years_Ranked_First(name, year) values ('Nadal', 2008);
insert into Years_Ranked_First(name, year) values ('Federer', 2007);
insert into Years_Ranked_First(name, year) values ('Federer', 2006);
insert into Years_Ranked_First(name, year) values ('Federer', 2005);
insert into Years_Ranked_First(name, year) values ('Federer', 2004);

create table Countries (
	name varchar(32) primary key,
	GDP integer,
	population integer
);

insert into Countries(name, GDP, population) values ('USA', 18558, 325);
insert into Countries(name, GDP, population) values ('China', 11383, 1383);
insert into Countries(name, GDP, population) values ('Japan', 4412, 126);
insert into Countries(name, GDP, population) values ('Germany', 3467, 80);
insert into Countries(name, GDP, population) values ('UK', 2853, 65);
insert into Countries(name, GDP, population) values ('Spain', 1242, 46);
insert into Countries(name, GDP, population) values ('Switzerland', 651, 8);
insert into Countries(name, GDP, population) values ('Serbia', 37, 9);




