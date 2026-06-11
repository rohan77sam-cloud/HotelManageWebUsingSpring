<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<style>

* { box-sizing: border-box; }

body {
    background: linear-gradient(to right, #ff9966, #ff5e62);
    font-family: Arial, sans-serif;
    text-align: center;
}

form {
    background: white;
    padding: 30px;
    width: 380px;
    margin: auto;
    margin-top: 80px;
    border-radius: 15px;
    box-shadow: 0px 0px 10px black;
}

h1 { color: #ff5e62; margin-bottom: 20px; }

.field {
    margin-bottom: 6px;
    text-align: left;
}

input {
    width: 100%;
    padding: 10px 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border 0.2s;
}

input:focus { outline: none; border-color: #ff5e62; }

/* red border when invalid */
input.invalid { border-color: #e74c3c; }

/* error message under each field */
.err {
    color: #e74c3c;
    font-size: 12px;
    margin-top: 3px;
    min-height: 16px;
    display: block;
}

/* live password strength bar */
#strengthBar {
    height: 6px;
    border-radius: 3px;
    margin-top: 5px;
    transition: width 0.3s, background 0.3s;
    width: 0%;
}

#strengthText {
    font-size: 11px;
    margin-top: 2px;
    display: block;
    text-align: left;
}

button {
    margin-top: 14px;
    width: 100%;
    background: #ff5e62;
    color: white;
    padding: 11px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}

button:hover { background: #e0393d; }

a { color: #ff5e62; font-size: 14px; }

</style>
</head>
<body>

<form id="registerForm"
      action="${pageContext.request.contextPath}/register"
      method="post"
      novalidate>

    <h1>Hotel Registration</h1>

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
        <div id="strengthBar"></div>
        <span id="strengthText"></span>
        <span class="err" id="passwordErr"></span>
    </div>

    <!-- CONFIRM PASSWORD -->
    <div class="field">
        <input type="password"
               id="confirmPassword"
               placeholder="Confirm Password">
        <span class="err" id="confirmErr"></span>
    </div>

    <button type="submit">Register</button>

    <br><br>
    <a href="${pageContext.request.contextPath}/login">
        Already Registered? Login
    </a>
    <br/>
    <a href="${pageContext.request.contextPath}/admin">
              Admin Login
        </a>
</form>

<script>

    // ── helpers ──────────────────────────────────────────────
    function showError(inputId, errId, msg) {
        document.getElementById(inputId).classList.add('invalid');
        document.getElementById(errId).textContent = msg;
    }

    function clearError(inputId, errId) {
        document.getElementById(inputId).classList.remove('invalid');
        document.getElementById(errId).textContent = '';
    }

    // ── live: username ────────────────────────────────────────
    document.getElementById('username').addEventListener('input', function () {
        var v = this.value.trim();
        if (v.length === 0) {
            showError('username', 'usernameErr', 'Username is required.');
        } else if (v.length < 3) {
            showError('username', 'usernameErr', 'Minimum 3 characters required.');
        } else if (!/^[a-zA-Z0-9_]+$/.test(v)) {
            showError('username', 'usernameErr', 'Only letters, numbers and _ allowed.');
        } else {
            clearError('username', 'usernameErr');
        }
    });

    // ── live: password strength bar ───────────────────────────
    document.getElementById('password').addEventListener('input', function () {
        var p = this.value;
        var bar = document.getElementById('strengthBar');
        var txt = document.getElementById('strengthText');

        if (p.length === 0) {
            bar.style.width = '0%';
            txt.textContent = '';
            clearError('password', 'passwordErr');
            return;
        }

        // score: 1 pt each for length>=8, uppercase, lowercase, digit, special char
        var score = 0;
        if (p.length >= 8)            score++;
        if (/[A-Z]/.test(p))          score++;
        if (/[a-z]/.test(p))          score++;
        if (/[0-9]/.test(p))          score++;
        if (/[^A-Za-z0-9]/.test(p))   score++;

        var labels  = ['', 'Very Weak', 'Weak', 'Fair', 'Strong', 'Very Strong'];
        var colours = ['', '#e74c3c',   '#e67e22', '#f1c40f', '#2ecc71', '#27ae60'];
        var widths  = ['', '20%', '40%', '60%', '80%', '100%'];

        bar.style.width      = widths[score];
        bar.style.background = colours[score];
        txt.style.color      = colours[score];
        txt.textContent      = labels[score];

        if (p.length < 6) {
            showError('password', 'passwordErr', 'Password must be at least 6 characters.');
        } else {
            clearError('password', 'passwordErr');
        }
    });

    // ── live: confirm password ────────────────────────────────
    document.getElementById('confirmPassword').addEventListener('input', function () {
        var p1 = document.getElementById('password').value;
        if (this.value !== p1) {
            showError('confirmPassword', 'confirmErr', 'Passwords do not match.');
        } else {
            clearError('confirmPassword', 'confirmErr');
        }
    });

    // ── submit: validate everything before sending ────────────
    document.getElementById('registerForm').addEventListener('submit', function (e) {

        var ok = true;

        // username
        var u = document.getElementById('username').value.trim();
        if (u.length === 0) {
            showError('username', 'usernameErr', 'Username is required.');
            ok = false;
        } else if (u.length < 3) {
            showError('username', 'usernameErr', 'Minimum 3 characters required.');
            ok = false;
        } else if (!/^[a-zA-Z0-9_]+$/.test(u)) {
            showError('username', 'usernameErr', 'Only letters, numbers and _ allowed.');
            ok = false;
        }

        // password
        var p = document.getElementById('password').value;
        if (p.length === 0) {
            showError('password', 'passwordErr', 'Password is required.');
            ok = false;
        } else if (p.length < 6) {
            showError('password', 'passwordErr', 'Password must be at least 6 characters.');
            ok = false;
        }

        // confirm
        var c = document.getElementById('confirmPassword').value;
        if (c.length === 0) {
            showError('confirmPassword', 'confirmErr', 'Please confirm your password.');
            ok = false;
        } else if (c !== p) {
            showError('confirmPassword', 'confirmErr', 'Passwords do not match.');
            ok = false;
        }

        if (!ok) e.preventDefault();
    });

</script>

</body>
</html>
