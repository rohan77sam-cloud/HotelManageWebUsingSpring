<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<style>

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.box {
    background: white;
    width: 400px;
    padding: 44px 40px;
    border-radius: 16px;
    box-shadow: 0 24px 64px rgba(0,0,0,0.5);
    text-align: center;
}

.badge {
    display: inline-block;
    background: #0f3460;
    color: white;
    padding: 6px 18px;
    border-radius: 20px;
    font-size: 12px;
    letter-spacing: 2px;
    margin-bottom: 18px;
}

h1 { color: #0f3460; font-size: 24px; margin-bottom: 6px; }
.sub { color: #999; font-size: 13px; margin-bottom: 26px; }

.field { margin-bottom: 6px; text-align: left; }

input {
    width: 100%;
    padding: 12px 14px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 14px;
    transition: border 0.2s;
}
input:focus { border-color: #0f3460; outline: none; }
input.invalid { border-color: #e74c3c; }

.err {
    color: #e74c3c; font-size: 12px;
    margin-top: 3px; min-height: 16px; display: block;
}

.server-error {
    background: #ffe8e8; color: #c0392b;
    padding: 10px 14px; border-radius: 8px;
    margin-bottom: 18px; font-size: 13px;
    border-left: 4px solid #e74c3c;
    text-align: left;
}

button {
    width: 100%;
    padding: 13px;
    background: linear-gradient(to right, #0f3460, #e94560);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
    letter-spacing: 1px;
    margin-top: 12px;
}
button:hover { opacity: 0.9; }

.guest-link { margin-top: 22px; font-size: 13px; color: #aaa; }
.guest-link a { color: #0f3460; text-decoration: none; font-weight: bold; }

</style>
</head>
<body>

<div class="box">

    <div class="badge">STAFF ONLY</div>
    <h1>Admin Portal</h1>
    <p class="sub">Hotel Management System</p>

    <%-- Server-side wrong-credentials error --%>
    <c:if test="${not empty error}">
        <div class="server-error">&#10008; ${error}</div>
    </c:if>

    <form id="f"
          action="${pageContext.request.contextPath}/adminlogin"
          method="post"
          novalidate>

        <div class="field">
            <input type="text" id="u" name="username" placeholder="Admin Username" autocomplete="off">
            <span class="err" id="uErr"></span>
        </div>

        <div class="field">
            <input type="password" id="p" name="password" placeholder="Admin Password">
            <span class="err" id="pErr"></span>
        </div>

        <button type="submit">LOGIN</button>

    </form>

    <div class="guest-link">
        <a href="${pageContext.request.contextPath}/login">&#8592; Back to Guest Login</a>
    </div>

</div>

<script>
    function show(id, eid, msg) {
        document.getElementById(id).classList.add('invalid');
        document.getElementById(eid).textContent = msg;
    }
    function clear(id, eid) {
        document.getElementById(id).classList.remove('invalid');
        document.getElementById(eid).textContent = '';
    }

    document.getElementById('u').addEventListener('input', function(){ if(this.value.trim()) clear('u','uErr'); });
    document.getElementById('p').addEventListener('input', function(){ if(this.value)       clear('p','pErr'); });

    document.getElementById('f').addEventListener('submit', function(e){
        var ok = true;
        if(!document.getElementById('u').value.trim()){ show('u','uErr','Username is required.'); ok=false; }
        if(!document.getElementById('p').value)       { show('p','pErr','Password is required.'); ok=false; }
        if(!ok) e.preventDefault();
    });
</script>

</body>
</html>
