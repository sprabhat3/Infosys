create database Infosys
use Infosys

alter table tblreg
add user_skills int

create table tblreg
(
user_id int primary key identity,
user_name varchar(50),
user_salary int,
user_gender int,
user_country int,
user_state int
)

create table tblgender(
gender_id int primary key identity,
gender_name varchar(20)
)

create table tblcountry(
country_id int primary key identity,
country_name varchar(20)
)

create table tblstate(
state_id int primary key identity,
country_id int,
state_name varchar(20)
)

create table tblskills(
skills_id int primary key identity,
skills_name varchar(20)
)
--inserting
insert into tblgender(gender_name)values('Male')
insert into tblgender(gender_name)values('Female')
insert into tblgender(gender_name)values('Other')

insert into tblcountry(country_name)values('--Select--')
insert into tblcountry(country_name)values('India')
insert into tblcountry(country_name)values('Pakistan')
insert into tblcountry(country_name)values('Bangladesh')
insert into tblcountry(country_name)values('Nepal')
insert into tblcountry(country_name)values('Sri Lanka')
insert into tblcountry(country_name)values('USA')
insert into tblcountry(country_name)values('Russia')

insert into tblstate(country_id,state_name)values(7,'Alabama')
insert into tblstate(country_id,state_name)values(7,'Alaska')
insert into tblstate(country_id,state_name)values(7,'Connecticut ')
insert into tblstate(country_id,state_name)values(7,'Florida')
insert into tblstate(country_id,state_name)values(8,'Amur Region')
insert into tblstate(country_id,state_name)values(8,'Astrakhan Region')
insert into tblstate(country_id,state_name)values(8,'Chechen Republic')

insert into tblskills(skills_name)values('Java')
insert into tblskills(skills_name)values('C#')
insert into tblskills(skills_name)values('Python')
insert into tblskills(skills_name)values('Spring')
insert into tblskills(skills_name)values('.Net')
insert into tblskills(skills_name)values('HTML/CSS')




select * from tblreg
join tblgender on user_gender=gender_id
join tblcountry on user_country=country_id
join tblstate on user_state=state_id  order by user_name

--Single Procedure
alter proc InfosysProc
@action varchar(50)=null,
@user_id int=0,
@user_name varchar(50)=null,
@user_salary int=0,
@user_gender int=0,
@user_country int=0,
@user_state int=0,
@gender_id int=0,
@gender_name varchar(20)=null,
@country_id int=0,
@country_name varchar(50)=null,
@state_id int=0,
@state_name varchar(50)=null,
@user_email varchar(50)=null,
@user_dob date=null,
@user_skills varchar(150)=null
as
begin
if(@action='INSERT')
begin
insert into tblreg(user_name,user_salary,user_gender,user_country,user_state,user_email,user_dob,user_skills)
values(@user_name,@user_salary,@user_gender,@user_country,@user_state,@user_email,@user_dob,@user_skills)
end
else if(@action='SHOW')
begin
select * from tblreg
join tblgender on user_gender=gender_id
join tblcountry on user_country=country_id
join tblstate on user_state=state_id 
end
else if(@action='GENDER')
begin
select * from tblgender
end
else if(@action='COUNTRY')
begin
select * from tblcountry
end
else if(@action='STATE')
begin
select * from tblstate where country_id=@country_id
end
else if(@action='UPDATE')
begin
update tblreg set user_name=@user_name,user_dob=@user_dob,user_email=@user_email,user_salary=@user_salary,user_gender=@user_gender,user_country=@user_country,user_state=@user_state,user_skills=@user_skills where user_id=@user_id
end
else if(@action='DELETE')
begin
delete from tblreg where user_id=@user_id
end
else if(@action='EDIT')
begin
select * from tblreg where user_id=@user_id
end
end


truncate table tblreg