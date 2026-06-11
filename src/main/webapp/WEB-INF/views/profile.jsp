<%@ page session="true" %>

<html>

<head>
<meta charset="UTF-8">

<title>Profile</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#00b09b,#96c93d);
text-align:center;
}

.container{
background:white;
width:600px;
margin:auto;
margin-top:50px;
padding:40px;
border-radius:20px;
box-shadow:0px 0px 15px black;
}

a{
display:block;
margin:20px;
padding:15px;
background:#00b09b;
color:white;
text-decoration:none;
border-radius:10px;
font-size:20px;
}

h1{
color:#00b09b;
}

</style>

</head>

<body>

<div class="container">

<h1>
Welcome ${sessionScope.username}
</h1>

<h2>
We are lucky to have you.
Please let us know how we may serve you.
</h2>

<a href="${pageContext.request.contextPath}/roomBookingPage">
1. Room Booking
</a>

<a href="${pageContext.request.contextPath}/foodPage">
2. Order Food
</a>

<a href="${pageContext.request.contextPath}/paymentPage">
3. Payment
</a>

<!-- FIX: /logout now points to a real GET mapping added in PageController.
     Before this fix, clicking Logout caused a 404 because no controller
     handled /logout. The new mapping clears the session and redirects to /login -->
<a href="${pageContext.request.contextPath}/logout">
4. Exit / Logout
</a>

</div>

</body>

</html>
