package com.kh.hana.mbti.model.vo;

import java.io.Serializable;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString


public class MbtiData implements Serializable {
	

	private static final long serialVersionUID = 1L;

	private int[] no;
	private int[] memberResult;
	private String memberId;
}