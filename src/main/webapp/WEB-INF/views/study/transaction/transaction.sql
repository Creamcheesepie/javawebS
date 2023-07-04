/* TRANSACTION.sql */

desc user;
/* user 테이블 구조(idx,mid,name,age,address) */
create table user2(
	mid varchar(4) not null,
	nickName varchar(20) not null,
	jab varchar(10) not null
);

desc user2
select * from user;
select * from user2;

insert into user values(default,'ppppp','피맨2',27,'서울2');
insert into user2 values('ppppp','피피맨','학생2');
