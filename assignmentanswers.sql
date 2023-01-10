1)Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

 #bajaj auto 

SET SQL_SAFE_UPDATES = 0;
alter table `bajaj auto` add formatted_date date;
update `bajaj auto` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table bajaj1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from `bajaj auto`);
select *from bajaj1;


 #eicher motors

alter table `eicher motors` add formatted_date date;
update  `eicher motors` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table eicher1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from  `eicher motors`);
select *from eicher1;


#Hero Motocorp

alter table `Hero Motocorp` add formatted_date date;
update  `Hero Motocorp` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table hero1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from  `Hero Motocorp`);
select *from hero1;

#infosys

alter table `infosys` add formatted_date date;
update  `infosys` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table infosys1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from  `infosys`);
select *from infosys1;


#TCS

alter table `tcs` add formatted_date date;
update  `tcs` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table tcs1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from  `tcs`);
select *from tcs1;


#TVS Motors

alter table `TVS Motors` add formatted_date date;
update  `TVS Motors` set formatted_date = str_to_date(date, '%d-%M-%Y') ;
create table tvs1  as (select formatted_date as'Date',`Close price`as 'Close Price' ,
avg(`Close Price`) over (order by formatted_date asc rows 19 preceding) as `20 Day MA` ,
avg(`Close Price`) over (order by formatted_date  asc rows 49 preceding) as `50 Day MA`from  `TVS Motors`);
select *from tvs1;




2)Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)


create table master
select baj.formatted_date as Date , baj.`Close Price` as Bajaj , tcs.`Close Price` as TCS , 
tvs.`Close Price` as TVS , inf.`Close Price` as Infosys , eic.`Close Price` as Eicher , hero.`Close Price` as Hero
from `bajaj auto` baj
inner join `tcs` tcs on tcs.formatted_date = baj.formatted_date
inner join `tvs motors` tvs on tvs.formatted_date = baj.formatted_date
inner join `infosys` inf on inf.formatted_date = baj.formatted_date
inner join `eicher motors` eic on eic.formatted_date = baj.formatted_date
inner join `hero motocorp` hero on hero.formatted_date = baj.formatted_date ;
select * from master


3)Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.

#bajaj motors
create table bajaj2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from bajaj1;

select * from bajaj2;

#eicher2
create table eicher2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from eicher1;

select * from eicher2;

#hero2
create table hero2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from hero1;

select * from hero2;

#infosys

create table infosys2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from infosys1;

select * from infosys2;

#tcs

create table tvs2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from tvs1;

select * from tvs2;

#tcs
create table tcs2 as
select `Date`, `Close Price`,
(case	
	when row_number() over() <=50 then 'Hold'
	when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` = 0 and lag(`20 Day MA` - `50 Day MA`) over() = 0 ) then 'Hold'
    when (`20 Day MA` - `50 Day MA` > 0 and lag(`20 Day MA` - `50 Day MA`) over() < 0 ) then 'Buy'
    when (`20 Day MA` - `50 Day MA` < 0 and lag(`20 Day MA` - `50 Day MA`) over() > 0 ) then 'Sell'
end) as `Signal`
from tcs1;

select * from tcs2;

#4)Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock. (Hint: The signal of sell and buy for that particular day is generated by subtracting the previous day's flag value. Flag value is generated using short-term and long-term moving averages.)

DELIMITER $$

CREATE FUNCTION bajaj_signal(trade_date Date)
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
	DECLARE trade_signal VARCHAR(10);
    SELECT `Signal` 
    FROM bajaj2 
    WHERE Date = trade_date 
    INTO trade_signal; 
	RETURN trade_signal;
END $$

DELIMITER ;


 SELECT bajaj_signal('2018-1-1') AS `Signal`;




