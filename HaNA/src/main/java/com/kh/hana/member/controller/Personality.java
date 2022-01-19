package com.kh.hana.member.controller;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Personality implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String memberId;
	private String personality;
}
