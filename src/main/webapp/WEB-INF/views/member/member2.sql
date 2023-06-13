show tables;


create table member2(
	idx 			int not null auto_increment, /*회원 고유번호*/
	
	mid 			varchar(20) not null,   /*회원 아이디 수정 불가능 중복불가능*/
	pwd 			varchar(100) not null,  /*sha256 암호화 활용*/
	nickName 	varchar(20) not null,   /*회원 별명 중복 불허, 수정가능*/
	name 			varchar(20) not null,   /*회원 이름*/
	gender 		varchar(5) default '여성',  /*회원 성별*/
	
	birthday 	datetime default now(), /*회원 생일*/
	tell 			varchar(20),            /*전화번호(국제번호 포함)*/
	address 	varchar (100), 					/*주소 (다음 API 활용)*/
	email 		varchar(60) not null, 	/*이메일은 아이디/비밀번호 찾기 위해서 not null로 설정함-정규식 형식 체크 필수, 어디에서 하지???????*/
	homePage	varchar(50),						/*홈페이지*/
	
	job 			varchar(20), 						/*직업*/
	hobby			varchar(100), 					/*취미 복수선택 가능(구분자는 /로 한다.)*/
	photo		 	varchar(100) default 'noimage.jpg', /*회원 사진*/
	content 	text, 									/*자기소개*/
	userInfoSw char(6) default '공개', /*회원정보 공개여부 공개 비공개 */
	
	userDel 	char(2) default 'no', 	/*회원 탈퇴신청여부(no/ok) *** 오타 수정 완료. ***/ 
	point 		int default 100, 				/*회원 포인트 100이 기본, 1회 방문시 10 포인트 증가 누적 50까지 가능*/
	level 		int default 1, 					/*회원등급 || 0 관리자 || 1 우수회원 || 2 정회원 || 3 준회원 */
	visitCnt 	int default 0, 					/*총 방문횟수*/
 	signinDate datetime default now(),/*최초 가입일*/
 	
 	lastDate 	datetime default now(), /*마지막 접속일*/
 	todayCnt 	int default 0, 					/*오늘 접속횟수*/			
	
	primary key (idx,mid)
);

desc member2
select * from member;
show tables;

drop table member;


select *,(select count(*) from guest where name='김피피' ) as guestCnt from member m where mid='ppman1234';

/* 회원 실시간 대화를 위한 테이블*/
create table memberChat (
	idx					int not null auto_increment primary key,
	nickName 		varchar(20) not null,
	chat				varchar(100) not null
	
);

desc memberchat;

select * from memberChat order by idx desc limit 50;

select chat.* from (select * from memberChat order by idx desc limit 50) as chat order by idx asc;

select mid, nickName, email from member2




