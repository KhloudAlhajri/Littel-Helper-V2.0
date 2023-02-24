
CREATE TABLE TEACHER (EMAIL VARCHAR(70) NOT NULL  
, TFNAME CHAR(40) NOT NULL, TLNAME CHAR(40) NOT NULL
, USERNAME CHAR(40) NOT NULL
, PASSWORD CHAR(40) NOT NULL
, PRIMARY KEY (EMAIL));

CREATE TABLE COURSE (COURSE_CODE CHAR(10) PRIMARY KEY NOT NULL 
, CLASSDAY DATE
, CLASSTIME CHAR(5)
, TCH_ID VARCHAR(70) References Teacher(Email));



CREATE TABLE MEMBERSHIP (CARDNUMBER VARCHAR(50) PRIMARY KEY NOT NULL
, SAFETYCODE CHAR(3) NOT NULL
, CARDDATE DATE NOT NULL
, MEMBERSHIPTYPE VARCHAR(15));


CREATE TABLE STUDENT (EMAIL VARCHAR(70) PRIMARY KEY NOT NULL
, FNAME CHAR(40) NOT NULL
, LNAME CHAR(40) NOT NULL
, USERNAME CHAR(40) NOT NULL
, PASSWORD CHAR(40) NOT NULL
, MEMBERCHIPID VARCHAR(50) References Membership(CardNumber));


CREATE TABLE ENROLLEDCLASS (SORTNUMBER INTEGER PRIMARY KEY NOT NULL auto_increment,
STD_EMAIL VARCHAR(70)  References Student(Email)
, STDCOURSECODE CHAR(10) References Course(Course_Code)
, MARK VARCHAR(25));



CREATE TABLE QUESTIONBANK (SORTNUMBER INTEGER PRIMARY KEY NOT NULL auto_increment
, STUTEST VARCHAR(70) References Student(Email)
, TESTCOURSECODE CHAR(10) References Course(Course_Code)
, QUESTION VARCHAR(150) NOT NULL
, ANSWER VARCHAR(150) NOT NULL);



CREATE TABLE TEACHERNOTE (SORTNUMBER INTEGER PRIMARY KEY NOT NULL auto_increment
, TEACNOTE VARCHAR(70) References Teacher(Email)
, NOTECOURSECODE CHAR(10) References Course(Course_Code)
, NOTE VARCHAR(150) NOT NULL);



INSERT INTO MEMBERSHIP (CARDNUMBER, SAFETYCODE, CARDDATE, MEMBERSHIPTYPE) 
	VALUES ('78344346', '533', '2023-02-10', 'Monthly'),
    ('77504100', '321', '2023-05-01', 'Monthly'),
    ('23444522', '567', '2024-01-01', 'Yearly'),
    ('27473628', '943', '2023-02-03', 'Monthly'),
    ('23423252', '439', '2023-02-07', 'Yearly'); 


INSERT INTO STUDENT (EMAIL, FNAME, LNAME, USERNAME, PASSWORD, MEMBERCHIPID) 
	VALUES ('Kholud@gmail.com', 'Kholud', 'Khalid', 'Kholud', 'Kholud123', '78344346'),
    ('Jinan@gmail.com', 'Jinan', 'Jafer', 'Jinan', 'Jinan123', '77504100'),
    ('Danah@gmail.com', 'Danah', 'Khalid', 'Danah', 'Danah123', '23444522 '),
    ('Fouz@gmail.com', 'Fouz', 'Morshed', 'Fouz', 'Fouz123', '27473628'),
    ('Sara@gmail.com', 'Sara', 'Mobark', 'Sara', 'Sara123', '23423252');


INSERT INTO TEACHER (EMAIL, TFNAME, TLNAME, USERNAME, PASSWORD) 
	VALUES ('Thwiba@gmail.com', 'Thwiba', 'Aawad', 'Thwiba', 'Thwiba123'),
    ('Reem@gmail.com', 'Reem', 'Haji', 'Reem', 'Reem123'),
    ('Hessa@gmail.com', 'Hessa', 'Almutairi', 'Hessa', 'Hessa123'),
    ('Hind@gmail.com', 'Hind', 'Baaqeel', 'Hind', 'Hind123'),
    ('Raja@gmail.com', 'Raja', 'Husain', 'Raja', 'Raja123');




INSERT INTO COURSE (COURSE_CODE, CLASSDAY, CLASSTIME, TCH_ID) 
	VALUES ('CIS1', '2023-02-23', '13:00', 'Thwiba@gmail.com')
,('CS1', '2023-02-25', '16:00', 'Reem@gmail.com'),
('CS2', '2023-03-30', '16:00', 'Raja@gmail.com'),
('CIS2', '2023-04-01', '15:30', 'Thwiba@gmail.com');



INSERT INTO TEACHERNOTE (TEACNOTE, NOTECOURSECODE, NOTE) 
	VALUES ('Thwiba@gmail.com', 'CIS1', 'I will gave littel helper full mark'),
    ('Reem@gmail.com', 'CS1' , 'Discussion of the final project will be on Monday');





INSERT INTO QUESTIONBANK (STUTEST, TESTCOURSECODE, QUESTION, ANSWER) 
	VALUES ('Kholud@gmail.com', 'CIS1', 'What are the types of "entity type"?', 'weak and strong')
    ,('Kholud@gmail.com', 'CS1', 'what is the difference between Exception and error'
    , 'We can handel Exception but we can not handel Errors'),
    ('Jinan@gmail.com', 'CIS2', 'What are information systems'
    , 'An information system is a combination of software, 
hardware, and telecommunication networks to collect useful data
, especially in an organisation.'),
 ('Jinan@gmail.com', 'CS2', 'What is a method in java?'
    , 'A method in Java is a block of code that, 
    when called, performs specific actions mentioned in it.');



INSERT INTO ENROLLEDCLASS (STD_EMAIL, STDCOURSECODE, MARK) 
	VALUES ('Kholud@gmail.com', 'CIS1', '95'),
    ('Jinan@gmail.com', 'CIS2', '95'),
    ('Danah@gmail.com', 'CIS1', '95'),
    ('Fouz@gmail.com', 'CS2', '90'),
    ('Danah@gmail.com', 'CS2', '90'),
    ('Khloud@gmail.com', 'CS1', '88'),
    ('Jinan@gmail.com', 'CS2', '70'),
    ('Fouz@gmail.com', 'CS1', '88');
    
    select *
    from student ;
    
     select *
    from teacher ;
    
       
alter table Membership add check (MembershipType =' monthly' or MembershipType = 'yearly'); 
alter table EnrolledClass add check (Mark between 0 and 100 ); 
alter table course add check (classtime between '8:00' and '17:00');  
 
update COURSE set CLASSTIME = '15:00' where COURSE_CODE='CIS1'; 
alter table Teacher add unique (Username); 
alter table Student add unique (Username); 
select * from Course where ClassDay = '2023-02-25'; 
 
select * from enrolledclass order by Mark desc limit 3 ; 
 
select count(*)  from membership where MembershipType = 'Monthly'; 
 
//delimiter  
create trigger studPass before insert on student for each row  if NEW.Password like '_____'  
then signal sqlstate '45000'  
set message_text = 'Password canot be less then 5 digits'  ; 
end if ; 
 
//delimiter  
create trigger teachPass before insert on teacher for each row  if NEW.Password like '_____'  
then signal sqlstate '45000'  
set message_text = 'Password canot be less then 5 digits'  ; 
end if ; 
 
delimiter $$ 
create procedure getallstudents () 
begin  
select * from student ;  
end ; $$  
delimiter  
call getallstudents () ; 
 
 
select * from student inner join enrolledclass ; 
 
select *  
from QUESTIONBANK  
where StuTest='Kholud@gmail.com' and TESTCOURSECODE='CIS1'; 
 
select *  
from TeacherNote  
where TeacNote='Thwiba@gmail.com' and TESTCOURSECODE= 'CIS1';


