package com.spring.javawebS.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import lombok.Data;

@SuppressWarnings("deprecation")
@Data
public class UserVO {
 private int idx;
 
 @NotEmpty(message = "아이디가 공백입니다.")
 @Size(min=3, max=20)
 private String mid;
 
 @NotEmpty(message="성명이 공백입니다.")
 @Size(min=3, max=20)
 private String name;
 
 @Range(min=18,max=135,message="나이의 범위를 벗어났습니다.")
 private int age;
 private String address;
}
