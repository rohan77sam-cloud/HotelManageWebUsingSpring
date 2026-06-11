<%@ page session="true" %>

<html>

<head>

<title>Thank You</title>

<style>

body{
font-family:Arial;
background:linear-gradient(to right,#11998e,#38ef7d);
text-align:center;
}

.container{
background:white;
width:600px;
margin:auto;
margin-top:100px;
padding:40px;
border-radius:20px;
box-shadow:0px 0px 15px black;
}

a{
display:inline-block;
margin:20px;
padding:15px 25px;
background:#11998e;
color:white;
text-decoration:none;
border-radius:10px;
font-size:20px;
}

h1{
color:#11998e;
}

</style>

</head>

<body>

<div class="container">

<h1>
We are happy to serve you.
Hope we see you again soon.
</h1>

<a href="${pageContext.request.contextPath}/profilePage">
Profile Page
</a>

<a href="${pageContext.request.contextPath}/logout">
Logout
</a>

</div>

</body>

</html>