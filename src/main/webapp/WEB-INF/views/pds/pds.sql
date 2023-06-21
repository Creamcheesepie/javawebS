show tables;

create table pds2(
	idx 			int not null auto_increment, 		/* 인덱스 설정 대신 하여 사용하는 방법 자료실 고유번호*/
	
	mid 			varchar(20) not null, 					/*글쓴이 아이디*/
	nickName 	varchar(20) not null,						/*글쓴이 닉네임*/
	fName 		varchar(200) not null,					/*업로드시 올라간 파일명 > 여러개일 경우 /로 구분*/
	fSName 		varchar(200) not null,					/*실제 파일 서버에 저장된 파일명 */
	fSize 		int not null,										/*파일의 총 크기*/
	
	title 		varchar(100) not null,					/*업로드시 제목*/
	part 			varchar(20) not null,						/*파일 분류*/
	pwd				varchar(100) not null,					/*비밀번호(bCryptPasswordEncoder 암호화)*/
	
	fDate 		datetime default now(),					/*파일 업로드 날짜*/
	downNum		int default 0,									/*다운로드 횟수*/
	openSw 		char(6) default '공개',						/*파일 공개/비공개 여부*/
	content 	text,														/*업로드 파일의 상세설명*/
	hostIp		varchar(50) not null,						/*업로드시 클라이언트 IP 주소*/
	
	primary key(idx)													/*기본키 : 자료실 고유 번호*/
);

desc pds;

