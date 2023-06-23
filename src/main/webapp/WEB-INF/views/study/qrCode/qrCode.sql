show tables;

create table qrCode(
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	name varchar(15) not null,
	email varchar(100) not null,
	movieName varchar(30) not null,
	movieDate varchar(25) not null,
	movieTime varchar(20) not null,
	movieAdult int not null,
	movieChild int default 0,
	publishNow varchar(30) not null,
	qrCodeName varchar(100) not null
);



drop table qrCode;