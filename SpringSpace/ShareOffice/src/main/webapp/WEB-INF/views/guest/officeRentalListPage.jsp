<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/commons.css">
<link rel="stylesheet" href="../resources/css/style.css">

<script>

</script>

</head>
<body>
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top: 70px;">
	
		<div class="col"></div> <!-- 왼쪽 여백 -->
		
		<div class="col-10">
			
			<div class="row mt-5">
				<div class="col fs-2 center">오피스 예약 내역</div>
			</div>
			
			<div class="row mt-5"> <!-- 오피스 예약정보 -->
				<div class="col">
					
					<c:forEach items="${rentalList }" var="rentalList" varStatus="status">
					
					<div class="row"> <!-- 예약한날짜 -->
						<div class="col"> 
							<p class="fw-bold fs-6" style="margin-bottom: 0px;">
								<fmt:formatDate value="${rentalList.orderVo.order_date }" pattern="yyyy년MM월dd일 (E)"/>
							</p> 
						</div>
					</div>
					
					<div class="row"><div class="col"><hr></div></div> <!-- 구분선 -->
					
					<div class="row mt-2"> <!-- 예약 오피스 정보 -->
						<div class="col-3"> <!-- 오피스 썸네일 -->
							<%--<img src="../resources/img/testImage.jpg" width="80em" height="84em"> --%>
							<img src="/soUpload/officeImage/${rentalList.officeInfoVo.office_thumbnail }" width="80em" height="84em">
						</div>
						
						<div class="col"> <!-- 오피스 정보 -->
							<div class="row"> <!-- 오피스 이름 -->
								<div class="col">
									<a style="color:#808080" href="../guest/officeDetailPage?office_no=${rentalList.officeInfoVo.office_no }">${rentalList.officeInfoVo.office_name }</a>
								</div>
							</div>
							
							
							<div class="row"> <!-- 빌린 기간 -->
								<div class="col grayColor" style="font-size: 14px;">
									<c:forEach items="${rentalList.rentalVoList}" var="rvl">
										<p><fmt:formatDate value="${rvl.rental_date}" pattern="yyyy년MM월dd일 (E)"/></p>
								    </c:forEach>
								</div>
							</div>
							
							<div class="row"> <!-- 대여 가격 -->
								<div class="col grayColor" style="font-size: 14px;">
									<%-- <fmt:parseNumber value="${rentalList.totalPaymentList.parseTotalPayment}" type="number"/> --%>
									<fmt:formatNumber value="${rentalList.totalPayment }"/>원</span>
									
								</div>
							</div>
							
							<div class="row mt-3"> <!-- 예약 인원 -->
								<div class="col grayColor" style="font-size: 14px;">
									${rentalList.orderVo.order_personnel }명
								</div>
							</div>
							
						</div>
						
						<div class="col-3"> <!-- 리뷰작성페이지 이동버튼(리뷰 존재여부에 따라 출력 or 미출력) -->
							<c:choose>
								<c:when test="${rentalList.reviewExist <= 0}">
									<a id="reviewWriteButton" href="./writeReviewPage?order_no=${rentalList.orderVo.order_no }
									&office_no=${rentalList.officeInfoVo.office_no }">리뷰작성</a>
								</c:when>
								<c:otherwise>
									<a id="reviewWriteButton" href="./officeReviewPage?office_no=${rentalList.officeInfoVo.office_no }">리뷰목록</a>
								</c:otherwise>
							</c:choose> 
						</div>
						
					</div>
					
					<div class="row" style="padding:1em;"></div>
					
					</c:forEach>
					
				</div>
			</div>
		
		</div>
		
		<div class="col"></div> <!-- 오른쪽 여백 -->
			
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>