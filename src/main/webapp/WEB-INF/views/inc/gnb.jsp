<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
// m_gnbWrap 2차메뉴 열기
$(".m_gnb > ul > li").click(function(){
    $(".m_gnb > ul > li").removeClass("on");
    $(this).addClass("on");
});
</script>

<c:forEach items="${menus }" var="item">
	<li>
		<c:choose>
			<c:when test="${fn:length(item.children) eq 0}">
				<a href="<c:url value="/board/type/${item.id }"/>">${item.title }</a>			
			</c:when>
			<c:otherwise>
				<a href="#" onclick="javascript:return false;">${item.title }</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${fn:length(item.children) gt 0}">
			<ul>
				<c:forEach items="${item.children }" var="menu">
					<li>
						<a href="<c:url value="/board/type/${menu.id }"/>">${menu.title }</a>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</li>
</c:forEach>