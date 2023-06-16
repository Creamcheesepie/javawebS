show tables;

create table board2 (
	idx int not null auto_increment, /*게시글 고유번호*/
	mid varchar(20) not null, /*게시글 작정자 아이디*/
	nickName varchar(20) not null, /*게시글 작성자 닉네임 */
	title varchar(200) not null, /*게시글 제목*/
	email varchar(50), /*이메일 주소*/
	homePage varchar(50), /*홈페이지 주소*/
	content text not null,	/*게시글 내용*/
	readNum int default 0,	/*글 조회수*/
	hostIp varchar(30) not null, /*작성자 ip*/
	openSw char(2) default 'ok', /*게시글 공개여부*/
	wDate dateTime default now(),   /*오늘의 신문*/
	good int default 0, /*추천 수 누적*/
	
	primary key(idx)
);

create table goodCnt2(
	sector varchar(20) not null, /*무슨 게시판인지 기록*/
	idx int	not null, /*게시글 idx 기록*/
	mid varchar(20) not null, /*좋아요 누른 사람의 mid*/
	wDate datetime default now()
);

desc goodCnt;
select * from goodCnt;
desc board2;
                            idx      mid     닉      제목                  이메일  									홈페이지												내용					조회수    	아이피				공개여부    날짜    추천수
insert into board2 values (default,"admin","관리맨","게시판 서비스 시작합니다.","gnldbs1004@gmail.com","gnldbs1004@naver.com","이곳은 게시판 입니다.",default,"192.168.50.88",default,default,default);

select * from board2;

/*게시판에 댓글 달기*/

create table board2Reply(
	idx 			int not null auto_increment,			 /*댓글의 고유번호*/
	boardIdx	int not null,											 /*원본 글의 고유 번호(외래키로 지정)*/ 
	mid 			varchar(20) not null,							 /*댓글 작성자 아이디*/
	nickName	varchar(20) not null,							 /*댓글 작성자 닉네임*/
	wDate			datetime default now(),						 /*댓글 작성일자*/
	postIp		varchar(50) not null,							 /*댓글 올린 PC의 고유 ip*/
	content		text not null,										 /*댓글 내용*/
	primary key(idx),														 /*기본키 : 고유번호 */
	foreign key(boardIdx) references board2(idx) /*외래키 설정 상대방이 가진 값 중에 고유한 것이여야 한다.(primary key나 unique key로 가능하다. >> 둘 다 중복을 허용하지 않음)*/
	on update cascade 					/*원본키에 대한 내용을 수정하면 같이 수정하겠다.*/
	on delete restrict 					/*조인된 테이블이 있으면 원본 글을 삭제하지 못하게 한다.*/
);

desc boardReply;
/*sql문을 쓸때에는 항상 미리 sql 연습을 하고 적용하기!*/
/*날짜함수 처리연습*/
select now();

select year(now());
select month(now());
select day(now());

select concat(year(now()),'년',month(now()),'월',day(now()),'일') as nalja;

select date(now()); /*날짜를 년 월 일로 출력*/

select weekday(now()); /*0=월, 1=화, 2=수, 3=목, 4=금, 5=토,6=일*/

select dayofweek(now()); /* 1=일, 2=월, 3=화 ,4=수, 5=목, 6=금, 7=토*/

select year('2023-5-3');

select idx,year(wDate) from board2;

/*날짜연산*/
/*date_add(date, interval 값 type)*/
select date_add(now(), interval 1 day); /*오늘 날짜보다 +1 = 내일날짜 출력*/
select date_add(now(), interval -1 day); /*오늘 날짜보다 -1 = 어제날짜 출력*/
select now(), date_add(now(), interval 10 day_hour)	/*오늘 날짜보다 +10시간 이후의 날짜/시간 출력*/
select now(), date_add(now(), interval -10 day_hour)	/*오늘 날짜보다 -10시간 이전의 날짜/시간 출력*/


/*board테이블에 적용하기*/
/*게시글 중에서 하루 전에 올라온 글만 보여주시귀*/
select wDate, date_add(wDate,interval -1 day) from board2;
select idx, wDate, date_add(wDate,interval -1 day) from board2 where substring(wDate,1,10) = substring(date_add(now(),interval -1 day),1,10);
/*24시간 전부터 올라온 게시을을 보여주긔*/
select idx, wDate from board2 where wDate >= date_add(now(),interval -24 hour);
select * from board2 where wDate >= date_add(now(),interval -24 hour);



/*date_sub(date, interval 값 type)*/
select date_sub(now(), interval 1 day); /*오늘 날짜보다 -1 = 어제날짜 출력*/
select date_sub(now(), interval -1 day); /*오늘 날짜보다 +1 = 오늘날짜 출력*/

/*입력한 데이터는 전부 출력, 24시간이 경과했는지 여부와 얼마나 남았는지 체크?*/
/*날짜자이 계산 : DATEDIFF(시작날짜,마지막날짜)*/
select datediff('2023-05-04','2023-05-01');
select datediff(now(),'2023-05-01');
select idx, datediff(now(),wDate) as day_diff from board2;

select timestampdiff(hour, '2023-05-04',now());
select timestampdiff(hour, wDate,now()) as hour_diff from board2;
select *,timestampdiff(hour, wDate,now()) as hour_diff from board2 order by idx desc;
select *,datediff(now(),wDate) as date_diff,timestampdiff(hour, wDate,now()) as hour_diff from board2 order by idx desc limit 0,5;
select *,timestampdiff(hour, wDate,now()) as hour_diff from board2 order by idx desc limit 0,5;
select timestampdiff(day, '2023-05-04',now());

/*날짜 양식(date_formt()) : 4자년도(%Y)/2자리년도(%y),월(%m),일(%d)*/
select date_format(wDate,'%Y-%m-%d %H:%i') from board2;


/*이전글 & 다음글 꺼내오기*/
select * from board2;
select * from board2 where idx = 6;
select idx,title from board2 where idx < 5 or idx > 5  limit 2; /*이전글*/
select idx,title from board2 where idx > ? limit 1; /*다음글*/

select 
	idx, 
	title 
from 
	board2 
where 
	idx

/*게시판 리스트의 글 제목 옆에 해당 글의 댓글 수를 출력합시다.*/
select * from board2;
select from board2 b, boardreply r (select count(idx) from boardreply where boardIdx = 28) as replyCnt ;

-- 앞의 예에서 원본글의 고유 번호와 함께 총 댓글의 갯수는 replyCnt로 출력?
select boardIdx, count(*) as replyCnt from boardreply where boardIdx=28;

select boardIdx, count(*) as replyCnt,
(select nickName from board2 where idx = 28) 
from boardreply 
where boardIdx=28;

-- 앞의 내용들을 부모관점(게시판)에서 추출하기
select idx,(select count(*) from boardreply where boardIdx=28)as replyCnt, nickname 
from board2
where idx = 28;

select *,(select count(*) from boardreply where boardIdx=28)as replyCnt 
from board2
where idx = ?;
-- 부모테이블을 기준으로 처리하고 board2 테이블의 1페이 5건을 출력하되, board2 테이플의 모든 내용과 현재 출력된 게시글에 달려있는 댓글의 개수를 출력
-- 단 , 최신글을 먼저 출려시켜주세용. 
select * ,
(select count(*)from boardReply where boardIdx=b.idx) as replyCnt
from
board2 b
order by idx desc
limit 5;

select *, datediff(now(),wDate) as date_diff, timestampdiff(hour, wDate,now()) as hour_diff,(select count(*) from boardReply where boardIdx=b.idx) as replyCount from board2 b order by idx desc limit 0,5; 






