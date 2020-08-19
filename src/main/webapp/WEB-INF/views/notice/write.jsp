<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	<script type="text/javascript">
		function insertBoard(){
			var url = $("form").attr("action");
			var param = $("form").serialize();
			var files = [];
			
			$("#file_ul").find(".bt_del_file").each(function(i, item){
				files.push($(item).val());
			});
			param += "&files="+files.join(",");
			
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			
			// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
			var content = document.getElementById("ir1").value;
			
			param += "&content=" +content;
			
			if(confirm("작성하시겠습니까?")){
				$.ajax({
					url : url,
					data: param,
					type: "POST",
					dataType: "json"
				}).done(function(json){
					if(json.result > 0){
						alert("작성 완료!");
						window.location.replace("/board/type/");
					}
				});
			}
		}
		function delFileClick(button){
			var id = $(button).val();
			$(".bt_del_file").each(function(index, item){
				if(id == $(item).val()){
					$(item).parent().remove();
					return;
				}
			});
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
                    <p>
                        "위대한 일을 해낼 수 없다면 작은 일을 위대하게 행하라."
                        <span>- 마틴 루터 킹</span>
                    </p>
                </div>
            </div>
			<div class="board_write_wrap">
                <div class="board_write">
                    <form action="<c:url value="/board/write"/>" method="post">
                        <dl>
                            <dt>카테고리</dt>
                            <dd>
                                <select name="boardType">
                                	<c:forEach items="${boardTypes }" var="item">
                                		<option value="${item.id }" <c:if test="${item.id eq boardType }">selected</c:if>>${item.title }</option>
                                	</c:forEach>
                                </select>
                            </dd>
                        </dl>
                        <dl class="title">
                            <dt>제목</dt>
                            <dd><input type="text" placeholder="제목 입력" name="title"></dd>
                        </dl>
                        <dl class="content">
                            <dd>
                            	<textarea id="ir1" name="content" rows="10" cols="100" style="width:766px; height:412px; display:none;"></textarea>
                            </dd>
                        </dl>
                        <dl>
                        	<dt>참고링크</dt>
                        	<dd>
                        		<input type="text" placeholder="http://" name="refLink">
                        	</dd>
                        </dl>
                        <dl class="image" id="dropzone-img">
                            <dt>사진</dt>
                            <dd>
                                <ul id="picture_ul">
                                </ul>
                                <!-- 첨부하기 버튼 -->
								<input id="imageupload" type="file" name="thumbnail" 
									accept="image/*" data-url="<c:url value="/upload/image"/>">
							    <div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
							        <div class="progress-bar" style="width: 0%;" ></div>
							    </div>
                            </dd>
                        </dl>
                        <dl class="file" id="dropzone-file">
                            <dt>첨부파일</dt>
                            <dd>
                                <input id="fileupload" type="file" 
										data-url="<c:url value="/upload/file"/>" multiple>
								<div id="progress_file">
							        <div class="progress-bar" style="width: 0%;"></div>
							    </div>
                                <ul id="file_ul">
                                	
                                </ul>
                            </dd>
                        </dl>
                    </form>
                </div>
				<div class="bt_wrap">
					<input type="hidden" name="boardType" value="${boardType }"/>
					<a href="javascript:submitContents(this);" class="bt1 on">글쓰기</a>
					<a href="#" class="bt1">취소</a>
				</div>
			</div>
		</div>
		<c:import url="/inc/footer"></c:import>
	</div>
<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/seSkin",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["ir1"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var files = [];
	$("#file_ul").find(".bt_del_file").each(function(i, item){
		files.push($(item).val());
	});
	$("form").append(
			$("<input>").attr("type","hidden").attr("name","files").val(files.join(",")));
	
	var imgs = [];
	$("#picture_ul").find(".bt_del_img").each(function(i, item){
		imgs.push($(item).val());
	});
	$("form").append(
			$("<input>").attr("type","hidden").attr("name","images").val(imgs.join(",")));
	
	try {
		$("form").submit();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}

$(document).ready(function(){
	$('#fileupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	console.log(data);
        	
        	var file = data.result.file;
            
           	$("#file_ul").append(
           		$("<li>").append(
           			$("<span>").text(file.name)
           		).append(
           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
           				.attr("name","files")
           				.attr("onclick", "delFileClick(this);").val(file.id)
           		)
           	);
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_file .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_file .progress-bar').css('width','0%');
            }
        },
 
        dropZone: $('#dropzone-file')
    });
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
</body>
</html>
