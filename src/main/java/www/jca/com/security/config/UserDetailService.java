package www.jca.com.security.config;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import www.jca.com.dao.UserDAO;
import www.jca.com.vo.UserVO;

@Service
public class UserDetailService implements UserDetailsService { 
	Logger logger = LoggerFactory.getLogger(UserDetailsService.class);
	
	@Autowired
	private UserDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO user = new UserVO();
		user.setKakaoId(username);
		user = dao.selectOne(user);
		
		GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole_name());
		UserDetails userDetails = (UserDetails)new User(user.getKakaoId()
				,""/*PASSWORD*/, Arrays.asList(authority));
				
		return userDetails;
	}
	
	/**
	 * 지금 로그인하는 User의 로그인 로그를 저장한다
	 * 
	 * @param username
	 */
	public void updateUserLoginLog(String username) {
//		if(dao.selectUserLoginLog(username) == null) {
//			dao.insertLoginLog(username);
//		}
//		dao.updateUserLoginLog(username);
	}
}
