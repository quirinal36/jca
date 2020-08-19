<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<script type="text/javascript">
	function pageGo(boardType, pageNo){
		$("#search-form input[name='pageNo']").val(pageNo);
		$("#search-form").submit();
	}
	</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/inc/header"></c:import>
		<div id="containerWrap">
			<div class="contTitle">
				<div>
					<strong>${menu.title }</strong>
					<p>${menu.pageComment }</p>
				</div>
			</div>
			<div class="board_list_wrap">
				<form id="search-form" action="<c:url value="${listUrl }"/>"> 
					<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
					<input type="hidden" name="boardType" value="${paging.boardType }"/>
					<input type="text" name="query" value="${paging.query }"/>
					<input type="submit" value="검색" />
				</form>
				<div class="board_list_type2">
					<c:forEach items="${list }" var="board">
						<!-- 예시글 1번 -->
						<div class="item">
							<div class="image">
								<a href="<c:url value="/board/notice/view?id=0"/>">
									<img src="<c:url value="/resources/img/temp/1.jpeg"/>" alt="사진">
								</a>
							</div>
							<div class="cont">
								<div class="category">${board.boardName }</div>
								<div class="title"><a href="<c:url value="/board/view?id=${board.id }"/>">${board.title }</a></div>
								<div class="etc">
									<span>${board.writerName }</span>
								</div>
								<div class="date">
									<span><fmt:formatDate value="${board.wdate}" pattern="yyyy-MM-dd" /></span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="page_wrap">
					<a href="javascript:pageGo('${paging.boardType }','${paging.firstPageNo}')" class="bt first">맨 처음 페이지로 가기</a>
					<a href="javascript:pageGo('${paging.boardType }','${paging.prevPageNo}')" class="bt prev">이전 페이지로 가기</a>
					<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo}" step="1" varStatus="status">
						<c:choose>
							<c:when test="${status.current == paging.pageNo }">
								<a href="javascript:pageGo('${paging.boardType }','${status.current }')" class="num on">
								${status.current}
								</a>						
							</c:when>
							<c:otherwise>
								<a href="javascript:pageGo('${paging.boardType }','${status.current }')" class="num">
								${status.current}
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
						<a href="javascript:pageGo('${paging.boardType }','${paging.nextPageNo}')" class="bt next">다음 페이지로 가기</a>
						<a href="javascript:pageGo('${paging.boardType }','${paging.finalPageNo}')" class="bt last">마지막 페이지로 가기</a>
					</div>
				<div class="bt_wrap">
					<a href="#" class="bt1 on">목록</a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="<c:url value="/board/${menu.id }/write"/>" class="bt1">글쓰기</a>
					</sec:authorize>
				</div>
			</div>
		</div>
		<c:import url="/inc/footer"></c:import>
	</div>
</body>
</html>
