create database project;
use project;
create table Users (user_id int primary key,username varchar(50) unique,email varchar(100) unique,password_hash varchar(255) ,created_at timestamp default current_timestamp);
insert into Users(user_id,username,email,password_hash)values(1,'Uma','uma@gmail.com','pass1'),(2,'muthu','muthu@gmail.com','pass2'),(3,'paramu','paramu@gmail.com','pass3'),(4,'vicky','vicky@gmail.com','pass4'),(5,'sangee','sangee@gmail.com','pass5'),(6,'kaleel','kaleel@gmail.com','pass6'),(7,'vivegha','vivekha@gmail.com','pass7'),(8,'mukutha','mukt@gmail.com','pass8'),(9,'vijay','vijay@gmail.com','pass9'),(10,'swetha','swethu2gmail.com','pass10');
select * from Users;
create table Posts (user_id int primary key,content text,created_at timestamp default current_timestamp,foreign key (user_id) References Users(user_id) on delete cascade);
insert into Posts(user_id,content)values(1,'Hi,all Happy diwali'),(2,'this is my first post'),(3,'My usual day'),(4,'welcome to my post'),(5,'happy morning'),(6,'happy sunday'),(7,'good day all'),(8,'good vibes'),(9,'festival mood'),(10,'holiday vibes');
select * from posts;
create table Comments (user_id int,content text not null ,created_at timestamp default current_timestamp,foreign key (user_id) references Posts(user_id) on delete cascade);
insert into Comments(user_id,content)values(1,'super'),(2,'wow lovely'),(3,'great'),(4,'hello all'),(5,'superb'),(6,'enjoyyyy'),(7,'thank you'),(8,'vibesssss'),(9,'have fun'),(10,'enjoy the day');
select * from Comments;
create table Likes(user_id int,likes varchar(50) not null,created_at timestamp default current_timestamp,foreign key (user_id) references Posts(user_id) on delete cascade);
insert into likes(user_id,likes)values(1,'21k'),(2,'22k'),(3,'202k'),(4,'170k') ,(5,'10k'),(6,'20k'),(7,'30k'),(8,'25k'),(9,'43k'),(10,'28k');
select * from Likes;
create table User_Follows (follower_id int not null,followed_id int not null,created_at timestamp default current_timestamp,primary key (follower_id, followed_id),foreign key (follower_id) references Users(user_id) on delete cascade,foreign key (followed_id) references Users(user_id) on delete cascade);
insert into User_Follows(follower_id,followed_id)values(01,001),(02,002),(03,003),(04,004),(05,005),(06,006),(07,007),(08,008),(09,009),(10,010);
select * from User_Follows;
#Alter
alter table Users add gender varchar(25)not null;
#Update
update Users
set gender=case
when user_id=1 then'female'
when user_id=2 then'male'
when user_id=3 then'female'
when user_id=4 then'male'
when user_id=5 then'female'
when user_id=6 then'male'
when user_id=7 then'female'
when user_id=8 then'female'
when user_id=9 then'male'
when user_id=10 then'female'
else gender
end;
set sql_safe_updates=0;
#Rename
alter table Users rename as users;
select * from Users order by email asc;
#Orderby,Asc,Desc
select content from Posts order by content desc;
#and,or,not,isnull,is notnull,limit
select username,email from Users where username='uma' and email='uma@gmail.com';
select password_hash,username from Users where password_hash='pass2' or username='rasathi';
select * from Likes where not likes='20k';
select follower_id from User_Follows where follower_id is null;
select follower_id from User_Follows where follower_id is  not null;
select * from Users order by email desc limit 5;
#Aggregate fun
select min(likes) from Likes;
select max(likes) from Likes;
select count(content)from Comments order by content ;
select sum(likes) from Likes;
select avg(likes) from Likes;
#likes, notlike, underscore,Percentage
select * from Users where username like '%u';
select * from Users where username like 'u%';
select * from Users where username  not like 'u%';
select * from Users where username like '%a%';
select * from Users where username like 'v_%';
select * from Users where username  not like 'v_%';
select * from Users where email like 'paramu@gmail.com';
#In,Between,Not between
select content from Comments where content in ('super','wow lovely');
select likes from Likes where likes between '10k' and '202k';
select likes from Likes where likes not between '10k' and '202k';
#Join
select Users.username,Users.email,Users.gender,Posts.content from Users inner join Posts on Users.user_id =Posts.user_id;
select Posts.content ,Comments.content from Posts left join Comments on Posts.user_id=Comments.user_id;
select Comments.content,Likes.likes from Comments right join Likes on Comments.user_id=Likes.user_id;
select * from Users join Posts where Users.user_id=Posts.user_id;
#Roundof
select round(likes) from Likes;
#floor
select floor(345.667);
#truncate
select truncate(345.156,0);
#module
select 18 mod 4;
#date add/sub/difference/arithmetic
select date_add(created_at,interval 10 day) from Users;
select date_sub(created_at,interval 10 day) from Users;
select datediff("2002/03/18","2002/09/13") as difference;
select 2024/11/01 + 6;
select created_at - 6 as new_date from Posts;
select year(created_at) as year from Users;
#Union
select username from Users union select content from Posts;
#Union all
select * from Comments union all select * from Posts;
#group by
select follower_id from User_Follows group by follower_id order by follower_id desc;
#having
select user_id, count(likes) from Likes  group by user_id having count(likes) <5;
#Exists
select username,email from Users where exists (select likes from Likes where Likes.user_id=Users.user_id);
#any and all
select content from Posts where user_id =any(select user_id from Users where password_hash ='pass3');
select all likes from Likes where true;
#subqueries
select max(likes) from Likes where likes <(select max(likes) from Likes);
#grant and revole
create user 'uma'@'localhost' identified by 'password';
grant all privileges on project to 'uma'@'localhost' ;
grant  select on Users to 'uma'@'localhost' ;
revoke update on Users from'uma'@'localhost' ;
#views
create view email as select username,email from Users where email='muthu@gmail.com';
select * from email;
create  or replace view emailusers as select username,email from Users where email='muthu@gmail.com';
select * from emailusers;
#function based index
create index index_column on Users (username); 
select * from Users where UPPER(username)='uma';
select * from Users where lower(username)='uma';
select * from users where trim(username)='uma';
#commit
create table sm(id int, name varchar(25),location varchar(25));
insert into sm(id,name)values(1,'rasathi');
commit;
insert into sm(location) values('chennai');
select * from sm;
rollback;
#current date;
select now() as current_datetime;
#current timestamp
select current_timestamp();
# db time_zone 
select@@global.time_zone;
#session timezone
select@@session.time_zone;
#interval data
select * from Users where created_at>='2024-11-25'- interval 20 day;
#tz_offset
select@@global.time_zone as global_time_zone,@@session.time_zone as session_time_zone;
#from_tz
select convert_tz('2002-03-18 06:00:00','utc','america/india')as timestamp_with_timezone;
#regular expression fn
# reg exp like
select * from Users where regexp_like(username,'^u');
#reg exp substr
select regexp_substr(email,'[^@]+',1,1) as username from Users;
#regexp instr
select user_id,username,email,regexp_instr(email,'@')as symbol_position from Users;
#reg exp replace
#stored procedure
delimiter //
create procedure user_procedure() 
begin
select * from users;
end// 
delimiter ;
call user_procedure();