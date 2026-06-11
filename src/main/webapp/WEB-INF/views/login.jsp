<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>

* { box-sizing: border-box; }

body {
    background: linear-gradient(to right, #36d1dc, #5b86e5);
    font-family: Arial, sans-serif;
    text-align: center;
}

form {
    background: white;
    width: 380px;
    margin: auto;
    margin-top: 100px;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0px 0px 10px black;
}

h1 { color: #5b86e5; margin-bottom: 20px; }

.field { margin-bottom: 6px; text-align: left; }

input {
    width: 100%;
    padding: 10px 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border 0.2s;
}

input:focus { outline: none; border-color: #5b86e5; }
input.invalid { border-color: #e74c3c; }

.err {
    color: #e74c3c;
    font-size: 12px;
    margin-top: 3px;
    min-height: 16px;
    display: block;
}

button {
    margin-top: 14px;
    width: 100%;
    background: #5b86e5;
    color: white;
    padding: 11px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}

button:hover { background: #3a6bd4; }

a { color: #5b86e5; font-size: 14px; }

</style>
</head>
<body>

<form id="loginForm"
      action="${pageContext.request.contextPath}/login"
      method="post"
      novalidate>

    <h1>Hotel Login</h1>

    <!-- USERNAME -->
    <div class="field">
        <input type="text"
               id="username"
               name="username"
               placeholder="Enter Username"
               autocomplete="off">
        <span class="err" id="usernameErr"></span>
    </div>

    <!-- PASSWORD -->
    <div class="field">
        <input type="password"
               id="password"
               name="password"
               placeholder="Enter Password">
        <span class="err" id="passwordErr"></span>
    </div>

    <button type="submit">Login</button>

    <br><br>
    <a href="${pageContext.request.contextPath}/register">
        New User? Register Here
    </a>

</form>

<script>

    function showError(inputId, errId, msg) {
        document.getElementById(inputId).classList.add('invalid');
        document.getElementById(errId).textContent = msg;
    }

    function clearError(inputId, errId) {
        document.getElementById(inputId).classList.remove('invalid');
        document.getElementById(errId).textContent = '';
    }

    // live: clear error as user types
    document.getElementById('username').addEventListener('input', function () {
        if (this.value.trim().length > 0) clearError('username', 'usernameErr');
    });

    document.getElementById('password').addEventListener('input', function () {
        if (this.value.length > 0) clearError('password', 'passwordErr');
    });

    // submit validation
    document.getElementById('loginForm').addEventListener('submit', function (e) {

        var ok = true;

        var u = document.getElementById('username').value.trim();
        if (u.length === 0) {
            showError('username', 'usernameErr', 'Username is required.');
            ok = false;
        }

        var p = document.getElementById('password').value;
        if (p.length === 0) {
            showError('password', 'passwordErr', 'Password is required.');
            ok = false;
        }

        if (!ok) e.preventDefault();
    });

</script>

</body>
</html>
