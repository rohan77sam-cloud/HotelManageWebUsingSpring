<%-- FIX: page directive must come FIRST, before any scriptlet that uses session --%>
<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%
if(session.getAttribute("username") == null) {
    // FIX: Was response.sendRedirect("login.jsp") which tries to access the JSP directly.
    // JSPs are inside WEB-INF and are not publicly accessible.
    // Redirect to the Spring MVC /login route instead.
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}
%>

<html>

<head>

<title>Food Ordering</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#ff512f,#dd2476);
text-align:center;
}

.container{
display:flex;
flex-wrap:wrap;
justify-content:center;
}

.card{
background:white;
width:300px;
margin:20px;
padding:20px;
border-radius:20px;
box-shadow:0px 0px 10px black;
}

img{
width:100%;
height:200px;
border-radius:10px;
}

button{
background:#dd2476;
color:white;
padding:10px 20px;
border:none;
border-radius:10px;
font-size:18px;
}

h1{
color:white;
}

.billing{
margin-top:30px;
}

.billing a{
background:white;
padding:15px 25px;
text-decoration:none;
color:#dd2476;
border-radius:10px;
font-size:20px;
}

</style>

</head>

<body>

<h1>Order Delicious Food</h1>

<div class="container">

<!-- BIRYANI -->
<div class="card">

<%-- FIX: Image src changed from "images/biryani.jpg" (relative, broken) to
     the correct webapp-relative path using contextPath.
     Make sure you have placed biryani.jpg inside src/main/webapp/images/ --%>
<img src="${pageContext.request.contextPath}/images/biryani.jpg">

<h2>Indian - Biryani</h2>
<h3>₹250</h3>

<form action="${pageContext.request.contextPath}/foodorder"
      method="post">

<input type="hidden" name="cuisine" value="Indian">
<input type="hidden" name="foodName" value="Biryani">
<input type="hidden" name="price" value="250">

<button type="submit">Order</button>

</form>

</div>

<!-- PANEER -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/paneer.jpg">

<h2>Indian - Paneer Butter Masala</h2>
<h3>₹300</h3>

<%-- FIX: Was action="foodorder" (relative URL, breaks on context path changes).
     All forms now use the full contextPath-based URL. --%>
<form action="${pageContext.request.contextPath}/foodorder" method="post">

<input type="hidden" name="cuisine" value="Indian">
<input type="hidden" name="foodName" value="Paneer Butter Masala">
<input type="hidden" name="price" value="300">

<button type="submit">Order</button>

</form>

</div>

<!-- NOODLES -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/noodles.jpg">

<h2>Chinese - Hakka Noodles</h2>
<h3>₹220</h3>

<form action="${pageContext.request.contextPath}/foodorder" method="post">

<input type="hidden" name="cuisine" value="Chinese">
<input type="hidden" name="foodName" value="Hakka Noodles">
<input type="hidden" name="price" value="220">

<button type="submit">Order</button>

</form>

</div>

<!-- FRIED RICE -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/friedrice.jpg">

<h2>Chinese - Fried Rice</h2>
<h3>₹260</h3>

<form action="${pageContext.request.contextPath}/foodorder" method="post">

<input type="hidden" name="cuisine" value="Chinese">
<input type="hidden" name="foodName" value="Fried Rice">
<input type="hidden" name="price" value="260">

<button type="submit">Order</button>

</form>

</div>

</div>

<div class="billing">

<a href="${pageContext.request.contextPath}/paymentPage">
Proceed To Billing
</a>

</div>

</body>

</html>
