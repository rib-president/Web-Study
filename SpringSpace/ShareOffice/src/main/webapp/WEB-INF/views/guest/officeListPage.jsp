<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
	<div class="col">
			<%-- 내용작성 --%>
			<c:forEach items="${officelist}" var="office">
				<div class="card mb-3">
				<a href="./officeDetailPage?office_no=${office.officeVo.office_no }">
				    <%-- 임시 이미지 --%>
					<img src="https://via.placeholder.com/50" class="card-img-top" alt="...">
					<%-- 이미지 등록시
					<img src="/upload/${office.officeVo.office_thumbnail }" class="card-img-top" alt="..."> 
					--%>
					</a>
					<div class="card-body">
						<div class="row">
							<h5 class="card-title">${office.officeVo.office_name }</h5>
						</div>
						<div class="row">
							<div class="col">
								<p class="card-text">
									<small class="text-muted"> 
									    <i class="bi bi-geo-alt"></i>${office.officeVo.office_address }
										#${office.officeVo.office_tags }
									</small>
								</p>
							</div>
							<div class="col">
								<h6 class="card-text" style="text-align: right;"> ${office.businessDayVo.business_day_price }원/일
								</h6>
							
							</div>
						</div>

					</div>
				</div>

			</c:forEach>
		</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>