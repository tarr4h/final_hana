package com.kh.hana.member.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.hana.group.model.vo.GroupBoard;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class memberBoard extends Board implements Serializable {

	/**
	 * writerProfile도 쓰려고 만듬
	 */
	private static final long serialVersionUID = 1L;
	private String writerProfile;
	public memberBoard(int no, String writer, String content, Date regDate, String boardType, String[] picture,
			String writerProfile) {
		super(no, writer, content, regDate, boardType, picture);
		this.writerProfile = writerProfile;
	}

	
	
	

}
