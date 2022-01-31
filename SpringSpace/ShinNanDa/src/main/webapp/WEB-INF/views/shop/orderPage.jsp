<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="../resources/css/commons.css" rel="stylesheet">

<script>
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
			
			// 도로명 주소 변수
			var roadAddr = data.roadAddress;
			// 지번 주소 변수
			var jibunAddr = data.jibunAddress;
			
            if(roadAddr !== ''){
                document.getElementById("addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("addr").value = jibunAddr;
            }
        }
    }).open();
}


function order() {
	var addr = document.getElementById("addr");
	var detail_addr = document.getElementById("detail_addr");
	
	if(detail_addr.value != null) {
		addr.value = addr.value + " " + detail_addr.value;
	}
	
	var frm = document.getElementById("frm");
	
	
	<c:forEach var="totalVo" items="${totalVoList }" varStatus="status">
		var hidden1 = document.createElement("input");
		hidden1.setAttribute("type", "hidden");
		hidden1.setAttribute("name", "product_detail_no");
		hidden1.setAttribute("value", "${totalVo.product_DetailVo.product_detail_no}");
		
		var hidden2 = document.createElement("input");
		hidden2.setAttribute("type", "hidden");
		hidden2.setAttribute("name", "productCount");
		hidden2.setAttribute("value", "${totalVo.productCount}");	
		
		frm.appendChild(hidden1);
		frm.appendChild(hidden2);
	</c:forEach>
	
	frm.submit();
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<div style="margin: 0 auto;">
 <div class="container-fluid">
	<div class="row">
		<div class="col"><!-- 글로벌 nav -->
			<jsp:include page="../commons/global_nav.jsp"></jsp:include>
		</div>
	</div>

	<c:set var="seq" value="1" />
	<c:set var="totalPrice" value="0" />
 	<div class="row">
		<jsp:include page="../commons/menu_bar.jsp"></jsp:include>
		<div class="col">	  
			<div class="row">
				<div class="col"><h1>cart</h1><hr></div>
			</div>
			<div class="row">
				<div class="col">
					<h1>01 cart > 02 order > 03 pay > 04 delivery</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<table class="table table-striped">
					  <thead>
					    <tr>
					      <th scope="col">No</th>
					      <th scope="col">이미지</th>
					      <th scope="col">상품 정보</th>
					      <th scope="col">판매가</th>
					      <th scope="col">수량</th>
					      <th scope="col">배송비</th>
					      <th scope="col">합계</th>
					    </tr>
					  </thead>
					  <tbody>
					  <c:forEach items="${totalVoList }" var="totalVo">
					    <tr>
					      <th scope="row">${seq }</th>
					      <td><img class="img-fluid" src="/upload/product/${totalVo.productVo.product_image }" style="width:300px;"></td>
					      <td>
					      	<div class="row">
					      		<div class="col"><h3>${totalVo.productVo.product_title }</h3></div>
					      	</div>
					      	<div class="row">
					      		<div class="col">${totalVo.product_DetailVo.product_detail_option }</div>
					      	</div>
					      </td>
					      <td>${totalVo.productVo.product_price }</td>
					      <td>${totalVo.productCount }</td>
					      <td>무료</td>
					      <td>${totalVo.productVo.product_price * totalVo.productCount }</td>
					    </tr>
					    <c:set var="seq" value="${seq + 1 }" />
					    <c:set var="totalPrice" value="${totalVo.productVo.product_price * totalVo.productCount + totalPrice }" />
					  </c:forEach>
					  </tbody>
					  <tfoot>
					    <tr>
					      <td></td>
					      <td>
					        <div class="row">
					          <div class="col">상품 구매 금액 합계(배송비 무료) :</div>
					          <div class="col">${totalPrice } 원</div>
					        </div>
					      </td>
					      <td></td>
					      <td></td>
					      <td></td>
					      <td></td>
					      <td></td>
					    </tr>
					  </tfoot>					  
					</table>				
				</div>
			</div>
			
			<div class="row mt-5">
			  <div class="col">
			  	<h2>배송정보</h2>
			  	<hr>
			  	<form id="frm" action="../shop/orderProcess" method="post">
				  	<div class="row mt-3">
				  		<div class="col-1">받는 분 : </div>
				  		<div class="col"><input class="form-control" type="text" name="orders_name" value="${sessionUser.member_name }"></div>
				  	</div>
				  	<div class="row mt-3">
				  		<div class="col">주소 : </div>
				  		<div class="row mt-2">
					  		<div class="col"><input class="form-control" type="text" id="addr" name="orders_address" value="${sessionUser.member_address }" readonly></div>
					  		<div class="col"><button type="button" onclick="findAddr()">주소 찾기</button></div>
				  		</div>
				  		<div class="row mt-2">
				  			<div class="col"><input class="form-control" id="detail_addr" type="text"></div>
				  		</div>
				  	</div>
				  	<div class="row mt-3">
				  		<div class="col-1">핸드폰 번호 : </div>
				  		<div class="col"><input class="form-control" type="text" name="orders_phone" value="${sessionUser.member_phone }"></div>
				  	</div>
				  	<div class="row mt-3">
				  		<div class="col-1">이메일 : </div>
				  		<div class="col">${sessionUser.member_email }</div>
				  	</div>			  					  					  	
			  	</form>
			  </div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<h2>결제 예정 금액</h2>
					<div class="row mt-3">
						<div class="col">
							<table class="table table-striped">
							  <thead>
							    <tr>
							      <th scope="col">총 주문 금액</th>
							      <th scope="col">배송비</th>
							      <th scope="col">총 결제 예정 금액</th>
							    </tr>
							  </thead>
							  <tbody>
							    <tr>
							      <td>${totalPrice }</td>
							      <td>0 (무료)</td>
							      <td>= ${totalPrice } 원</td>
							    </tr>
							  </tbody>
							</table>							
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<h2>결제</h2>
					<hr>
					<div class="row mt-5">
						<div class="col">
							<h5>무통장 입금</h5>
							<div class="row mt-5">
								<div class="col">
									<table class="table">
									  <tbody>
									    <tr>
									      <th scope="col">입금자명</th>
									      <th scope="col"> ${sessionUser.member_name } </th>
									    </tr>
									    <tr>
									      <th scope="row">입금은행</th>
									      <td>
									      	<select>
									      		<option>국민</option>
									      		<option>신한</option>
									      		<option>기업</option>
									      		<option>농협</option>
									      		<option>카카오뱅크</option>
									      	</select>									  
									      </td>
									    </tr>
									    <tr>
									      <th scope="row">계좌번호</th>
									      <td>000000-0000000000-00000</td>
									    </tr>
									  </tbody>
									</table>							
								</div>
							</div>
						</div>
						<div class="col">
							<div class="row mt-3">
								<div class="col"><h3>최종 결제 금액</h3></div>
							</div>
							<div class="row mt-3">${totalPrice } 원</div>
							<div class="row mt-3"><input type="button" value="결제하기" onclick="order()"></div>
						</div>
					</div>
				</div>
			</div>
			  
		  								
		</div>
 	</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>