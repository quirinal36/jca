<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
					<strong>게시판이름</strong>
					<p>명언</p>
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
								<div class="title"><a href="<c:url value="/class/data/detail?id=${board.id }"/>">${board.title }</a></div>
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
					<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo}" step="1" varStatus="status">
						<c:choose>
							<c:when test="${status.first }">
								<a href="javascript:pageGo('${paging.boardType }','${paging.firstPageNo }')" class="num">
								&lt; ${status.current}
								</a>		
							</c:when>
							<c:when test="${status.last }">
								<a href="javascript:pageGo('${paging.boardType }','${paging.endPageNo }')" class="num">
								${status.current} &gt;
								</a>						
							</c:when>
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
				</div>
				<div class="bt_wrap">
					<a href="<c:url value="/board/${menu.id }/write"/>" class="bt1">글쓰기</a>
				</div>
			</div>
		</div>
		<c:import url="/inc/footer"></c:import>
	</div>
</body>
</html>
