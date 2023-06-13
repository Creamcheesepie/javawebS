show tables;
create table guest2(
	idx int not null auto_increment primary key,/*방명록 고유번호*/
	name varchar(20) not null,
	content text not null,
	email varchar(60),
	homePage varchar(60),
	visitDate datetime default now(),
	hostIP varchar(30) not null
);

desc guest2;
insert into guest2 values (default,'관리자','방명록서비스를 시작합니다.','glndbs1004@naver.com','gnldbs1004.naver.com',default,'192.168.50.88');

select * from guest2;