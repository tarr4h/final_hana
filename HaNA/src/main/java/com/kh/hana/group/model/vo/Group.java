package com.kh.hana.group.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper=true)
public class Group {
	
	private String groupId;
	private String groupName;
	private String leaderId;
	private int memberCount;
	private int boardCount;
	private String[] hashtag;
	private String image;
}
