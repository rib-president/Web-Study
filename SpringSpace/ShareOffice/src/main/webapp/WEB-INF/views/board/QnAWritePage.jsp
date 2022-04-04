<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 70px;">
	<div class="col m-3">
		<%-- 내용작성 --%>
			<div class="row">
				<form action="./QnAWriteProcess" method="get">
				<div class="col">
					<h4 class="text-center">글쓰기페이지</h4>
				</div>
				<div class="row">
					<div class="col">
						 <input type="radio" name="qna_screct" value="Y" class="radio" checked /><span>공개</span>&nbsp;&nbsp;&nbsp;&nbsp;
   						 <input type="radio" name="qna_screct" value="N" class="radio" /><span>비공개</span>&nbsp;
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						작성자 : <span>${sessionUser.member_nick }</span>
					</div>
				</div>
				  
				<div class="row">
					<div class="col">
						제목  <input type="text" class="form-control" name="qna_title">
					</div>	
				</div>	
				 
				<hr>			
				<div class="row">
					<div class="col">
						내용  <textarea class="form-control" rows="5" name="qna_content"></textarea>
					</div>
				</div>
				
				<div class="row">
					<div class="col mt-2">
						<input type="submit" style="background-color: rgb(58,208,171);" class="float-end btn btn-light" value="글작성">						
						</div>
					</div>
				</form>
			</div>
		</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>