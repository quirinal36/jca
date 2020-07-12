package www.jca.com.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.jca.com.service.UserService;
import www.jca.com.util.RestUtil;
import www.jca.com.vo.KakaoLogin;
import www.jca.com.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	UserService userService;
	@Autowired
	AuthenticationManager authenticationManager;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/member/login")
	public ModelAndView getLoginView(ModelAndView mv) {
		mv.addObject("apiKey", "237d4dc58d093c4cd4a38d833023ec69");
		mv.setViewName("/member/login");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/member/signup", method = RequestMethod.POST)
	public String getSignupView(HttpServletRequest request, HttpSession session,
			@RequestBody KakaoLogin kakao) {
		JSONObject result = new JSONObject();

		session.setAttribute("access_token", kakao.getAccess_token());

		RestUtil util = new RestUtil();

		UserVO user = new UserVO();
		JSONObject response = util.post("v2/user/me", kakao.getAccess_token());	// REST API 통한 USER 정보
		logger.info(response.toString());
		if(response != null) {
			user.setKakaoId(String.valueOf(response.getInt("id")));
			JSONObject accountObj = response.getJSONObject("kakao_account");
			logger.info(accountObj.toString());
			JSONObject profileObj = accountObj.getJSONObject("profile");
			
			if(accountObj.getBoolean("has_email")) {
				if(accountObj.has("email")) {
					user.setEmail(accountObj.getString("email"));
				}
				user.setNickname(profileObj.getString("nickname"));

				UserVO selectUser = userService.selectOne(user);

				if(selectUser != null && selectUser.getId() > 0) {
					result.put("user", new JSONObject(selectUser.toString()));
					login(selectUser.getKakaoId(), "", request);
				}else {
					int insertResult = userService.insert(user);
					result.put("user", new JSONObject(user.toString()));
					if(insertResult > 0) {
						login(user.getKakaoId(), "", request);
					}
				}
			}
		}
		return result.toString();
	}
	
	private void login(String login, String inputPwd, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(login, inputPwd);
		authToken.setDetails(new WebAuthenticationDetails(request));
		Authentication authentication = authenticationManager.authenticate(authToken);
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
	@RequestMapping(value="/member/findId")
	public ModelAndView getFindIdView(ModelAndView mv) {
		mv.setViewName("/member/findId");
		return mv;
	}
	@RequestMapping(value="/member/findPwd")
	public ModelAndView getfindPwdView(ModelAndView mv) {
		mv.setViewName("/member/findPwd");
		return mv;
	}
	@RequestMapping(value="/member/newPwd")
	public ModelAndView getnewPwdView(ModelAndView mv) {
		mv.setViewName("/member/newPwd");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/member/logout", method = RequestMethod.POST, produces = "application/json;charset=utf8")
	public String postLogout(HttpSession session) {
		String accessToken = (String)session.getAttribute("access_token");
		RestUtil restUtil = new RestUtil();
		
		JSONObject response = restUtil.post("/v1/user/logout", accessToken);
		if(response.getInt("id") >0) {
			session.removeAttribute("access_token");
		}
		return response.toString();
	}
}
