package com.kh.hana.member.model.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Member extends MemberEntity implements Serializable, UserDetails{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<SimpleGrantedAuthority> authorities;
	
	@Builder 
	public Member(String id, String name, String password, String picture, String personalId, int accountType,
			String address, int account_type, String address_one, String address_secound, String address_third,
			String introduce, boolean enabled, List<SimpleGrantedAuthority> authorities) {
		super(id, name, password, picture, personalId, accountType, address, account_type, address_one, address_secound,
				address_third, introduce, enabled);
		this.authorities = authorities;
	}
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return getId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}









}
