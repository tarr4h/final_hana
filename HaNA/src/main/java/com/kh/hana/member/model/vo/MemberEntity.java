package com.kh.hana.member.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String name;
	private String password;
	private String picture;
	private String personalId;
	private int account_type;
	private String address_one;
	private String address_secound;
	private String address_third;
	private String introduce;
	private boolean enabled;
	

}
