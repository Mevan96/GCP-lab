create table USERS(
   ID INT NOT NULL AUTO_INCREMENT,
   Name VARCHAR(100) NOT NULL,
   Email VARCHAR(100) NOT NULL,
   Position VARCHAR(100) NOT NULL,
   Department_ID INT NOT NULL
   PRIMARY KEY ( ID )
);

insert into USERS ( ID, Name, Email, Position, Department_ID)
    values
    (1, "First_user", "First_user@email", "First_position", 1);

insert into USERS ( ID, Name, Email, Position, Department_ID)
    values
    (2, "Second_user", "Second_user@email", "Second_position", 2);

insert into USERS ( ID, Name, Email, Position, Department_ID)
    values
    (3, "Third_user", "Third_user@email", "Third_position", 3);

insert into USERS ( ID, Name, Email, Position, Department_ID)
    values
    (4, "Fourth_user", "Fourth_user@email", "Fourth_position", 4);

insert into USERS ( ID, Name, Email, Position, Department_ID)
    values
    (5, "Fifth_user", "Fith_user@email", "Fith_position", 5);


create table DEPARTMENTS
   ID INT NOT NULL AUTO_INCREMENT,
   Department_Name VARCHAR(100) NOT NULL
   PRIMARY KEY ( ID )
);

insert into DEPARTMENTS ( ID, Department_Name )
    values
    (1, "First_Department");

insert into DEPARTMENTS ( ID, Department_Name )
    values
    (2, "Second_Department");

insert into DEPARTMENTS ( ID, Department_Name )
    values
    (3, "Third_Department");

insert into DEPARTMENTS ( ID, Department_Name )
    values
    (4, "Fourth_Department");

insert into DEPARTMENTS ( ID, Department_Name )
    values
    (5, "Fifth_Department");    