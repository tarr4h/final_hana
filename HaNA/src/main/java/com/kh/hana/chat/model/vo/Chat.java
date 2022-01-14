package com.kh.hana.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class Chat extends ChatRoom implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String message;
	private Date messageRegDate;
	private int unReadCount;
	
	public Chat(int roomNo, String memberId, String message, Date messageRegDate, int unReadCount) {
		super(roomNo, memberId);
		this.message = message;
		this.messageRegDate = messageRegDate;
		this.unReadCount = unReadCount;
	}
	
	

}
