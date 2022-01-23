package com.kh.hana.group.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class GroupBoard extends GroupBoardEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String writerProfile;

	public GroupBoard(int no, String groupId, String writer, String content, Date regDate, int likeCount,
			String placeName, String placeAddress, double locationY, double locationX, String[] image,
			String[] tagMembers, String writerProfile) {
		super(no, groupId, writer, content, regDate, likeCount, placeName, placeAddress, locationY, locationX, image,
				tagMembers);
		this.writerProfile = writerProfile;
	}


	
	
	
}