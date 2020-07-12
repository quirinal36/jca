<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
function logout(){
	var url = "/member/logout";
	
	$.ajax({
		url : url,
		type: "POST",
		dataType: "json",
		contentType: 'application/json; charset=utf-8'
	}).done(function(json){
		if(json.id > 0){
			window.location.replace("/j_spring_security_logout");
		}
	});
}
</script>
<div id="footerWrap">
	<div class="top">
		<div>
			<a href="/member/signup">사용자 등록</a>
			<sec:authorize access="isAnonymous()">
				<a href="/member/login">로그인</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="javascript:logout();">로그아웃</a>
			</sec:authorize>
		</div>
	</div>
	<div id="footer">
		<div class="text">
			<ul>
				<li><b>전주코딩학원</b></li>
				<li>원장 : 이형구</li>
				<li>사업자등록번호 : 293-94-00881</li>
			</ul>
			<ul>
				<li>주소 : [54859] 전북 전주시 덕진구 만성중앙로 53-39</li>
				<li>전화번호 : 063-714-2536</li>
				<li>팩스번호 : 063-714-2537</li>
			</ul>
			<p>ⓒ 전주코딩학원.</p>
		</div>
		<div id="fixedMenu">
			<a href="tel:0637142536" class="bt_call">전화</a>
			<a href="https://pf.kakao.com/_ipZxeT" target="_blank" class="bt_kakao">카카오톡</a>
			<a href="https://www.youtube.com/channel/UCV7_TGuZcnCKJ4TaM2JjSZw" target="_blank" class="bt_youtube">유튜브</a>
			<a href="https://www.instagram.com/jcoding.academy" target="_blank" class="bt_insta">인스타그램</a>
		</div>
	</div>
</div>