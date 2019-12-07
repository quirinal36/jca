<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<!doctype html>
<html>
<head>
	<title>전주코딩학원</title>
	<link rel="icon" href="<c:url value="resources/img/comm/favicon.ico"/>">
	<link rel=" shortcut icon" href="<c:url value="resources/img/comm/favicon.ico"/>">
	<link rel="stylesheet" href="<c:url value="resources/css/css.css"/>">
	<script src="<c:url value="resources/js/jquery-1.12.1.min.js"/>"></script>
	<script>$(function(){ $( "#headerWrap" ).load( "/inc/head" ); });</script>
</head>
<body>
	<div id="wrap">
		<div id="headerWrap"></div>
		<div id="containerWrap">
			<div class="idx_slider_wrap">
				<div class="idx_slider">
					<div class="item item1">
						<div>
							<img src="<c:url value="resources/img/index/slider1_txt.png"/>" alt="2020 정보처리기사 실기대비반">
							<a href="#">자세히 보기</a>
							<a href="#">수강신청</a>
						</div>
					</div>
					<div class="item item2">
						<div>
							<img src="<c:url value="resources/img/index/slider2_txt.png"/>" alt="자바 프로그래밍">
							<a href="#">자세히 보기</a>
							<a href="#">수강신청</a>
						</div>
					</div>
					<div class="item item3">
						<div>
							<img src="<c:url value="resources/img/index/slider3_txt.png"/>" alt="코딩앤플레이 주니어">
							<a href="#">자세히 보기</a>
							<a href="#">수강신청</a>
						</div>
					</div>
				</div>
			</div>
			<div class="board_list_wrap">
				
				<div class="board_list_type1">
					<div class="item">
						<div class="image"><a href="<c:url value="/board/view"/>"></a><img src="<c:url value="resources/img/temp/1.jpeg"/>" alt="사진"></a></div>
						<div class="cont">
							<div class="category">학원소식</div>
							<div class="title"><a href="#">충주 대미초등학교에 다녀왔어요. 충주 대미초등학교에 다녀왔어요.</a></div>
							<div class="etc">
								<span>부원장</span>
								<span>2019.11.12</span>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="image"><a href="#"><img src="<c:url value="resources/img/temp/1.jpeg"/>" alt="사진"></a></div>
						<div class="cont">
							<div class="category">학원소식</div>
							<div class="title"><a href="#">충주 대미초등학교에 다녀왔어요.</a></div>
							<div class="etc">
								<span>부원장</span>
								<span>2019.11.12</span>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="image"><a href="#"><img src="<c:url value="resources/img/comm/noImg.gif"/>" alt="사진"></a></div>
						<div class="cont">
							<div class="category">학원소식</div>
							<div class="title"><a href="#">충주 대미초등학교에 다녀왔어요.</a></div>
							<div class="etc">
								<span>부원장</span>
								<span>2019.11.12</span>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="image"><a href="#"><img src="<c:url value="resources/img/temp/1.jpeg"/>" alt="사진"></a></div>
						<div class="cont">
							<div class="category">학원소식</div>
							<div class="title"><a href="#">충주 대미초등학교에 다녀왔어요.</a></div>
							<div class="etc">
								<span>부원장</span>
								<span>2019.11.12</span>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="image"><a href="#"><img src="<c:url value="resources/img/temp/1.jpeg"/>" alt="사진"></a></div>
						<div class="cont">
							<div class="category">학원소식</div>
							<div class="title"><a href="#">충주 대미초등학교에 다녀왔어요.</a></div>
							<div class="etc">
								<span>부원장</span>
								<span>2019.11.12</span>
							</div>
						</div>
					</div>
				</div>
				<!--
				<div class="page_wrap">
					<a href="javascript:pageGo(1)" class="bt first">맨 처음 페이지로 가기</a>
					<a href="javascript:pageGo(1)" class="bt prev">이전 페이지로 가기</a>
					<a href="javascript:pageGo(1)" class="num on">1</a>
					<a href="javascript:pageGo(1)" class="num">2</a>
					<a href="javascript:pageGo(1)" class="num">3</a>
					<a href="javascript:pageGo(1)" class="bt next">다음 페이지로 가기</a>
					<a href="javascript:pageGo(1)" class="bt last">마지막 페이지로 가기</a>
				</div>
				-->
				<div class="bt_wrap">
					<a href="#" class="bt1">더 보기</a>
				</div>
			</div>
		</div>
		<div id="footerWrap"></div>
	</div>
</body>
</html>