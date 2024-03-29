<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to Fun Web</title>
<link href="../css/default.css" rel="stylesheet" type="text/css"
	media="all">
<link href="../css/subpage.css" rel="stylesheet" type="text/css"
	media="all">
<link href="../css/print.css" rel="stylesheet" type="text/css"
	media="print">
<link href="../css/iphone.css" rel="stylesheet" type="text/css"
	media="screen">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->


<!--[if IE 6]>
 <script src="../script/DD_belatedPNG.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#sub_img');   
   DD_belatedPNG.fix('#sub_img_center'); 
   DD_belatedPNG.fix('#sub_img_member'); 

 </script>
 <![endif]-->

</head>
<%
	//dao 객체 준비
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null) {
		strPageNum = "1";
	}

	//page number
	int pageNum = Integer.parseInt(strPageNum);

	//Dao 객체 준비
	BoardDao boardDao = BoardDao.getInstance();

	//한 페이지에 보여줄 글 개수
	int pageSize = 3;

	//시작행번호 구하기
	int startRow = (pageNum) * pageSize + 1;

	//board table 글 개수 가져오기 메소드 호출
	int count = boardDao.getBoardCount();

	//글목록 가져오기 메소드 호출
	List<BoardVO> boardList = boardDao.getBoards(startRow, pageSize);

	//날짜 포맷 준비 SimpleDate Format
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.mm.dd");
%>

<body>
<div id="wrap">
	<!-- 헤더 영역 -->
	<jsp:include page="../include/header.jsp" />

	<div class="clear"></div>
	<div id="sub_img_center"></div>

	<div class="clear"></div>
	<%-- nav 영역 --%>
	<jsp:include page="../include/nav_center.jsp" />
<article>

<h1>Notice</h1>

<table id="notice">
  <tr>
    <th scope="col" class="tno">no.</th>
    <th scope="col" class="ttitle">title</th>
    <th scope="col" class="twrite">writer</th>
    <th scope="col" class="tdate">date</th>
    <th scope="col" class="tread">read</th>
  </tr>
  <%
  if (count > 0) {
	  for (BoardVO boardVO : boardList) {
		  %>
		  <tr>
		  	<td><%=boardVO.getNum() %></td>
		  	<td class="left"><%=boardVO.getSubject() %></td>
		  	<td><%=boardVO.getUsername() %></td>
		  	<td><%=sdf.format(boardVO.getRegDate()) %></td>
		  	<td><%=boardVO.getReadcount() %></td>
		  </tr>
		  <%
	  }
  } else { // count == 0
	  %>
	  <tr>
	  	<td colspan="5">게시판 글이 없습니다.</td>
	  </tr>
	  <%
  }
  %>
</table>

<div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp';">
</div>

<div id="table_search">
	<input name="" type="text" class="input_box"> <input type="button" value="Search" class="btn">
</div>

<div class="clear"></div>

<div id="page_control">
<%
if(count >0){
	//page number count
	//전체 글 개수 / 한 페이지 당 글 개수 (+1 : 나머지 있을때)
	int pageCount= count / pageSize +(count % pageSize == 0 ? 1 : 0);
	
	//page block
	int pageBlock = 5;
	
	//시작페이지 번호 구하기 
	//pageNum 값이 1~5 사이면 => 시작페이지는 항상 1이 나와
	//(1 - 5) * 5 + 1 -> 1
	//(2 - 5) * 5 + 1 -> 1
	//(3 - 5) * 5 + 1 -> 1
	//(4 - 5) * 5 + 1 -> 1
	//(5 - 5) * 5 + 1 -> 1
	
	//(6 - 5) * 5 + 1 -> 6
	//(7 - 5) * 5 + 1 -> 6
	//(8 - 5) * 5 + 1 -> 6
	//(9 - 5) * 5 + 1 -> 6
	//(10 - 5)* 5 + 1 -> 6
	int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
	// 끝페이지번호 endPage 구하기
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		//[이전]
		if (startPage > pageBlock){
			%>
			<a href="notice.jsp?pageNum=<%=startPage-pageBlock %>">[pre]</a>
			<% 
		}
		// 페이지블록 페이지5개 출력
		for (int i=startPage; i<=endPage; i++) {
			%>
			<a href="notice.jsp?pageNum=<%=i %>"><%=i %></a>
			<%	
		}//for
		
		//[다음]
		if (endPage<pageCount){
			%>
			<a href="notice.jsp?pageNum=<%=startPage+pageBlock %> "> [next]</a>
		<% 
		
		}
}//if
%>
	<a href="#">Prev</a> 


	<a href="#">Prev</a> <a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="3">6</a> <a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">10</a>  <a href="#">Next</a>
</div>

</article>



	<div class="clear"></div>

    <!-- 푸터 영역 -->
	<jsp:include page="../include/footer.jsp" />
</div>

</body>
</html>


