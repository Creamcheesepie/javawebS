package com.spring.javawebS.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String email;
	private String homePage;
	private String content;
	private int readNum;
	private String hostIp;
	private String openSw;
	private String WDate;
	private int good;
	private String goodMember;
	
	private int hour_diff; //시간 차이 계산 필드
	private int date_diff; //날짜 차이 계산 필드
	
	//이전글 / 다음글을 위한 변수 설정
	
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	private int replyCount; // 댓글의 갯수~~~

		
}
