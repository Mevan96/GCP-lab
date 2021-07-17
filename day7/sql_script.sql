create table USERS(
   ID int,
   Name varchar(100),
   Email varchar(100),
   Position varchar(100),
   Department_ID int
);

insert into USERS values (1, "First_user", "First_user@email", "First_position", 1);
insert into USERS values (2, "Second_user", "Second_user@email", "Second_position", 2);
insert into USERS values (3, "Third_user", "Third_user@email", "Third_position", 3);
insert into USERS values (4, "Fourth_user", "Fourth_user@email", "Fourth_position", 4);
insert into USERS values (5, "Fifth_user", "Fith_user@email", "Fith_position", 5);


create table DEPARTMENTS
   ID int,
   Department_Name varchar(100)
);

insert into DEPARTMENTS values (1, "First_Department");
insert into DEPARTMENTS values (2, "Second_Department");
insert into DEPARTMENTS values (3, "Third_Department");
insert into DEPARTMENTS values (4, "Fourth_Department");
insert into DEPARTMENTS values (5, "Fifth_Department");    