package com.kh.hana.group.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class GroupBoard {
	
	private int no;
	private String groupId;
	private String writer;
	private String content;
	private Date regDate;
	private int likeCount;
	private String placeName;
	private String placeAddress;
	private String[] image;
	
}
