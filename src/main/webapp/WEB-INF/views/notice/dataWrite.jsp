<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성</title>
<script src="<c:url value="/resources/js/jquery-1.12.1.min.js"/>"></script>
<script type="text/javascript">
function insertBoard(){
	var url = $("form").attr("action");
	var param = $("form").serialize();
	console.log(param);
	
	if(confirm("작성하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			console.log(json);
			
			if(json.id > 0){
				alert("작성 완료!");
				window.location.replace("/class/data/list?boardType="+json.boardType);
			}
		});
	}
}
function addLine(){
	$("#list").append("<li>추가됨!!</li>");
}
</script>
</head>
<body>
	<c:set var="actionUrl" value="/class/data/write"/>
	<c:if test="${board.id gt 0 }">
		<c:set var="actionUrl" value="/class/data/edit"/>
	</c:if>
	<form action="<c:url value="${actionUrl }"/>" method="post">
		<table>
			<tr>
				<td>
					게시판종류
				</td>
				<td>
					<select name="boardType">
                    	<c:forEach items="${boardTypes }" var="item">
                    		<option value="${item.id }" <c:if test="${item.id eq board.boardType }">selected</c:if>>${item.title }</option>
                    	</c:forEach>
                    </select>
				</td>
			</tr>
			<tr>
				<td>
					제목
				</td>
				<td>
					<input type="text" placeholder="제목 입력" name="title" value="${board.title }">
				</td>
			</tr>
			<tr>
				<td>
					내용
				</td>
				<td>
					<input type="text" placeholder="내용 입력" name="content" value="${board.content }">
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" value="추가" onclick="javascript:addLine();"/>
				</td>
				<td>
					<ul id="list">
					</ul>
				</td>
			</tr>
			<tr>
				<td id="dropzone-img">
					<input id="imageupload" type="file" accept="image/*" data-url="<c:url value="/upload/image/rest"/>">
					<div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
				        <div class="progress-bar" style="width: 0%;" ></div>
				    </div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="id" value="${board.id }"/>
		<input type="button" value="전송" onclick="insertBoard();"/>
	</form>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#imageupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	console.log(data);
        	
        	var file = data.result.file;
        	$("#picture_ul").append(
       			$("<li>").attr("style", "background-image: url(" + file.thumbnailUrl + ");")
       				.append(
       						$("<input>").attr("type","button").attr("title","삭제").addClass("bt_del_img")
       						.attr("onclick", "delButtonClick(this);").val(file.id)
       				)
       			);

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_img .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_img .progress-bar').css('width','0%');
            }
        },
 
        dropZone: $('#dropzone-img')
    });
});
</script>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</html>