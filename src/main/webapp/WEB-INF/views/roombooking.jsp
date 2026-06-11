<%-- FIX: page directive MUST come before any scriptlet that uses session.
     In the original file it came after the scriptlet, which causes a JSP compilation warning/error. --%>
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

<title>Room Booking</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#fc4a1a,#f7b733);
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
background:#fc4a1a;
color:white;
padding:10px 20px;
border:none;
border-radius:10px;
font-size:18px;
}

h1{
color:white;
}

</style>

</head>

<body>

<h1>Book Your Luxury Room</h1>

<div class="container">

<!-- STANDARD ROOM -->
<div class="card">

<%-- FIX: All image paths updated to use contextPath so they resolve correctly.
     Place images as: src/main/webapp/images/standard.jpg (etc.)
     The original project was missing standard.jpg, suite.jpg — you need to add those image files.
     Use images/download.jpg as a placeholder for standard and any image for suite if needed. --%>
<img src="${pageContext.request.contextPath}/images/standard.jpg">

<h2>Standard Room</h2>
<h3>₹2000</h3>

<form action="${pageContext.request.contextPath}/bookroom"
      method="post">

<input type="hidden" name="roomType" value="Standard">
<input type="hidden" name="price" value="2000">

<button type="submit">Book Now</button>

</form>

</div>

<!-- DELUXE ROOM -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/deluxe.jpg">

<h2>Deluxe Room</h2>
<h3>₹4000</h3>

<%-- FIX: Was action="bookroom" (relative URL). Now uses contextPath consistently. --%>
<form action="${pageContext.request.contextPath}/bookroom" method="post">

<input type="hidden" name="roomType" value="Deluxe">
<input type="hidden" name="price" value="4000">

<button type="submit">Book Now</button>

</form>

</div>

<!-- SUITE ROOM -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/suite.jpg">

<h2>Suite Room</h2>
<h3>₹7000</h3>

<form action="${pageContext.request.contextPath}/bookroom" method="post">

<input type="hidden" name="roomType" value="Suite">
<input type="hidden" name="price" value="7000">

<button type="submit">Book Now</button>

</form>

</div>

<!-- QUAD ROOM -->
<div class="card">

<img src="${pageContext.request.contextPath}/images/quad.jpg">

<h2>Quad Room</h2>
<h3>₹9000</h3>

<form action="${pageContext.request.contextPath}/bookroom" method="post">

<input type="hidden" name="roomType" value="Quad">
<input type="hidden" name="price" value="9000">

<button type="submit">Book Now</button>

</form>

</div>

</div>

</body>

</html>
