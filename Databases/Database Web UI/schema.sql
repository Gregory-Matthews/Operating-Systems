-- CS 500: Project Part 2
-- Authors: Georgi Simeonov, Gregory Matthews
-- Date: 2/23/18

Drop table Commissions;
Drop table Trades;
Drop table Transactions;
Drop table Statements;
Drop table Broker_Account_Bridge;
Drop table Accounts;
Drop table Brokers;
Drop table Clients;

Create table Clients(
  SSN varchar(9) primary key,
  first_name varchar(128),
  last_name varchar(128),
  address varchar(128),
  phone varchar(12),
  dob date
);

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('001695114', 'Carley', 'Richelle', '212 Main St.', '2159917640', '1985-02-22');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('001695840', 'Tatiana', 'Ima', '421 Arch St.', '2679923450', '1995-10-05');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('001694041', 'Edgar', 'Rosy', '294 Chestnut St.', '2154506423', '1988-06-13');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('911692042', 'Ron', 'Jones', '11 Locust St.', '5552206981', '1958-08-01');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('221395062', 'Peter', 'Griffin', '105 Spooner St.', '5512206981', '1958-08-01');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('019326490', 'Stephanie', 'Winthorp', '565 Pine St.', '2154409814', '1984-12-02');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('112855738', 'Hubert', 'Jackson', '329 Maple Dr.', '3419904676', '1985-11-28');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('993124645', 'Francis', 'Walsh', '81 Spruce St.', '2673473454', '1994-05-21');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('432667891', 'Peter', 'White', '43 Elbow Lane', '3379845564', '1995-07-25');

insert into Clients (SSN,first_name,last_name,address,phone,dob) values ('192345502', 'Scott', 'Anderson', '345 Ivy Lane', '2675436474', '1987-03-01');
Create table Brokers(
  bid integer primary key,  
  first_name varchar(100),
  last_name varchar(100),
  dob date,
  type varchar(32)
);

insert into Brokers(bid, first_name, last_name, dob, type)
values( 12312, 'Gordon', 'Gecko', '1962-02-12', 'large clients');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 29512, 'Sam', 'Malone', '1952-05-20', 'pensions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 99601, 'Meg', 'Griffin', '1972-10-12', 'small clients');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 73010, 'Brian', 'Griffin', '1982-09-10', 'large clients');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 12340, 'Mark', 'Twaine', '1972-04-12', 'pensions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 24340, 'Bruce', 'Wayne', '1975-08-02', 'institutions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 84740, 'Susan', 'Butler', '1985-06-24', 'pensions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 79740, 'Barbara', 'Staisand', '1965-08-21', 'institutions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 87012, 'Glen', 'Queck', '1985-01-01', 'small clients');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 53740, 'Cliveland', 'Ohio', '1981-03-29', 'pensions');

insert into Brokers(bid, first_name, last_name, dob, type)
values( 82710, 'Nancy', 'Anderson', '1967-08-05', 'large clients');

Create table Accounts(
  aid integer primary key,
  type varchar(32),
  IRS_Status varchar(128),
  date_created date, 
  ssn_owner varchar(9) not null,
  foreign key (ssn_owner) references Clients(SSN)
);

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (34589, 'Checking', '404', '2005-03-12', '001695114');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (34563, 'Savings', '400', '2012-09-22', '001695840');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (98634, 'Checkings', '400', '2016-11-07', '001694041');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (89423, 'Savings', '403', '2013-07-12', '911692042');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (12335, 'Savings', '404', '2013-01-22', '221395062');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (23498, 'Checkings', '405', '2014-06-30', '019326490');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (45643, 'Savings', '400', '2015-11-11', '112855738');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (34526, 'Savings', '404', '2016-10-30', '993124645');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (76834, 'Savings', '404', '2016-09-21', '432667891');

insert into Accounts (aid,type, IRS_Status, date_created, ssn_owner) values (90873, 'Checkings', '403', '2017-05-03', '192345502');


Create table Broker_Account_Bridge(
  baid integer primary key,
  bid integer,
  aid integer
);


insert into Broker_Account_Bridge(baid, bid, aid) values (1, 12312, 34589);

insert into Broker_Account_Bridge(baid, bid, aid) values (2, 29512, 34563);

insert into Broker_Account_Bridge(baid, bid, aid) values (3, 99601,98634);

insert into Broker_Account_Bridge(baid, bid, aid) values (4, 73010,89423);

insert into Broker_Account_Bridge(baid, bid, aid) values (5, 12340, 12335);

insert into Broker_Account_Bridge(baid, bid, aid) values (6, 84740,23498);

insert into Broker_Account_Bridge(baid, bid, aid) values (7, 79740, 45643);

insert into Broker_Account_Bridge(baid, bid, aid) values (8, 87012, 34526);

insert into Broker_Account_Bridge(baid, bid, aid) values (9, 53740, 76834);

insert into Broker_Account_Bridge(baid, bid, aid) values (10, 82710, 90873); 


Create table Statements(
  sid integer primary key,
  type varchar(32),
  statement_date date,
  aid integer not null,
  foreign key (aid) references Accounts(aid)
);

insert into Statements (sid, type, statement_date, aid) values (87324, 'account', '2015-06-01', 34589);

insert into Statements (sid, type, statement_date, aid) values (98700, 'balance', '2015-06-01', 34563);

insert into Statements (sid, type, statement_date, aid) values (98345, 'bank', '2016-06-01', 98634);

insert into Statements (sid, type, statement_date, aid) values (34875, 'account', '2015-06-01', 89423);

insert into Statements (sid, type, statement_date, aid) values (37452, 'balance', '2016-06-01', 12335);

insert into Statements (sid, type, statement_date, aid) values (87452, 'account', '2015-06-01', 23498);

insert into Statements (sid, type, statement_date, aid) values (34521, 'balance', '2016-06-01', 45643);

insert into Statements (sid, type, statement_date, aid) values (56745, 'account', '2016-06-01', 34526);

insert into Statements (sid, type, statement_date, aid) values (56235, 'account', '2014-06-01', 76834);

insert into Statements (sid, type, statement_date, aid) values (36673, 'account', '2014-06-01', 90873);

Create table Transactions(
  tid integer primary key,
  type varchar(32),
  amount float,
  transaction_date date, 
  aid integer not null,
  foreign key(aid) references Accounts(aid)
);

insert into Transactions(tid, type, amount, transaction_date, aid) values (43256, 'Deposit', 312.00, '2015-04-22', 34589);

insert into Transactions(tid, type, amount, transaction_date, aid) values (34563, 'Deposit', 2000000.00, '2016-12-25', 34589);

insert into Transactions(tid, type, amount, transaction_date, aid) values (68532, 'Withdrawal', 1230.00, '2015-08-08', 76834);

insert into Transactions(tid, type, amount, transaction_date, aid) values (66514, 'Deposit', 54300.00, '2015-08-08', 76834);

insert into Transactions(tid, type, amount, transaction_date, aid) values (19752, 'Withdrawal', 890.00, '2016-08-08', 90873);

insert into Transactions(tid, type, amount, transaction_date, aid) values (98324, 'Withdrawal', 34000.00, '2016-12-19', 12335);

insert into Transactions(tid, type, amount, transaction_date, aid) values (23424, 'Deposit', 500.00, '2016-12-19', 12335);

insert into Transactions(tid, type, amount, transaction_date, aid) values (12556, 'Deposit', 32000.00, '2013-06-20', 34526);

insert into Transactions(tid, type, amount, transaction_date, aid) values (54523, 'Deposit', 14500.00, '2016-04-08', 45643);

insert into Transactions(tid, type, amount, transaction_date, aid) values (57423, 'Deposit', 14500.00, '2015-09-16', 90873);

insert into Transactions(tid, type, amount, transaction_date, aid) values (66342, 'Withdrawal', 8600.00, '2016-11-15', 90873);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40001, 'Deposit', 12000, '2017-12-20', 34589);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40002, 'Withdraw', 2000, '2018-02-20', 34589);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40003, 'Deposit', 25021, '2017-04-24', 98634);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40004, 'Withdraw', 15021, '2017-05-04', 98634);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40005, 'Deposit', 505, '2017-06-04', 89423);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40006, 'Deposit', 10505, '2017-07-09', 12335);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40007, 'Withdraw', 500, '2017-09-09', 12335);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40008, 'Deposit', 23500, '2017-10-19', 23498);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40009, 'Deposit', 43602, '2018-01-12', 45643);

insert into Transactions(tid, type, amount, transaction_date, aid) values (40010, 'Deposit', 6102, '2018-01-12', 90873);

Create table Trades(
  trid integer primary key,
  type varchar(12),
  action integer, --maybe a type 0- sell, 1- buy, 2-limit
  shares float,
  price float,
  bid integer not null,
  foreign key (bid) references Brokers(bid)
);

insert into Trades(trid, type, action, shares, price, bid) values (10001, 'market', 1, 12.21, 23.12, 12312);

insert into Trades(trid, type, action, shares, price, bid) values (10002, 'limit',  2, 12.21, 25.12, 12312);

insert into Trades(trid, type, action, shares, price, bid) values (10003, 'market', 1, 50, 15, 29512);

insert into Trades(trid, type, action, shares, price, bid) values (10004, 'market',  2, 50, 25, 29512);

insert into Trades(trid, type, action, shares, price, bid) values (10005, 'market', 1, 100, 10, 99601);

insert into Trades(trid, type, action, shares, price, bid) values (10006, 'market',  2, 100, 35, 99601);

insert into Trades(trid, type, action, shares, price, bid) values (10007, 'market', 1, 150, 7.82, 73010);

insert into Trades(trid, type, action, shares, price, bid) values (10008, 'market',  2, 150, 35, 73010);

insert into Trades(trid, type, action, shares, price, bid) values (10009, 'market', 1, 250, 9.82, 12340);

insert into Trades(trid, type, action, shares, price, bid) values (10010, 'market',  2, 250, 10.12, 12340);

insert into Trades(trid, type, action, shares, price, bid) values (10011, 'market', 1, 123, 0.82, 24340);

insert into Trades(trid, type, action, shares, price, bid) values (10012, 'market',  2, 123, 1.12, 24340);

insert into Trades(trid, type, action, shares, price, bid) values (10013, 'market',  1, 215, 4.12, 84740);

insert into Trades(trid, type, action, shares, price, bid) values (10014, 'market',  1, 295, 12.12, 79740);

insert into Trades(trid, type, action, shares, price, bid) values (10015, 'market',  1, 395, 29.12, 87012);

insert into Trades(trid, type, action, shares, price, bid) values (10016, 'market',  1, 395, 9.52, 53740);

insert into Trades(trid, type, action, shares, price, bid) values (10017, 'market',  1, 130, 23.01, 82710);

Create table Commissions(
  cid integer primary key,
  type varchar(32),
  amount float,
  commission_date date,
  bid integer unique not null,
  foreign key (bid) references Brokers(bid)
);

insert into commissions(cid, type, amount, commission_date, bid) values (81231, 'mvp', 123000.12, '2017-12-22', 12312);

insert into commissions(cid, type, amount, commission_date, bid) values (81232, 'quarterly', 53000.74, '2017-12-22', 29512);

insert into commissions(cid, type, amount, commission_date, bid) values (81233, 'quarterly', 10000.31, '2017-12-22', 99601);

insert into commissions(cid, type, amount, commission_date, bid) values (81234, 'quarterly', 12012.51, '2017-12-22', 73010);

insert into commissions(cid, type, amount, commission_date, bid) values (81235, 'quarterly', 7021.13, '2017-12-22', 12340);

insert into commissions(cid, type, amount, commission_date, bid) values (81236, 'quarterly', 8052.73, '2017-12-22', 24340);

insert into commissions(cid, type, amount, commission_date, bid) values (81237, 'quarterly', 6251.28, '2017-12-22', 84740);

insert into commissions(cid, type, amount, commission_date, bid) values (81238, 'quarterly', 1217.28, '2017-12-22', 79740);

insert into commissions(cid, type, amount, commission_date, bid) values (81239, 'quarterly', 2991.72, '2017-12-22', 87012);

insert into commissions(cid, type, amount, commission_date, bid) values (81240, 'quarterly', 1891.72, '2017-12-22', 53740);

insert into commissions(cid, type, amount, commission_date, bid) values (81241, 'quarterly', 2993.82, '2017-12-22', 82710);
