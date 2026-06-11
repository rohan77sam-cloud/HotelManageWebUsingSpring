<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<style>

* { box-sizing: border-box; }

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #1d2671, #c33764);
    text-align: center;
}

.container {
    background: white;
    width: 500px;
    margin: auto;
    margin-top: 80px;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0px 0px 15px black;
}

h1 { color: #c33764; }

.bill-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 20px;
    font-size: 16px;
    border-bottom: 1px solid #f0f0f0;
}

.bill-row.total {
    font-weight: bold;
    font-size: 20px;
    color: #c33764;
    border-bottom: none;
    margin-top: 6px;
}

.field { margin-top: 24px; text-align: left; }

input[type="number"] {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 18px;
    transition: border 0.2s;
}

input[type="number"]:focus { outline: none; border-color: #c33764; }
input[type="number"].invalid { border-color: #e74c3c; }

.err {
    color: #e74c3c;
    font-size: 13px;
    margin-top: 4px;
    min-height: 18px;
    display: block;
}

/* live match indicator */
#matchMsg {
    font-size: 13px;
    margin-top: 4px;
    min-height: 18px;
    display: block;
}

button {
    margin-top: 20px;
    width: 100%;
    background: #c33764;
    color: white;
    padding: 13px;
    border: none;
    border-radius: 10px;
    font-size: 18px;
    cursor: pointer;
}

button:hover { background: #a12b52; }
button:disabled { background: #ccc; cursor: not-allowed; }

</style>
</head>
<body>

<div class="container">

    <h1>Payment Page</h1>

    <!-- Bill summary -->
    <div class="bill-row">
        <span>Room Price</span>
        <span>&#8377;${roomPrice}</span>
    </div>
    <div class="bill-row">
        <span>Food Price</span>
        <span>&#8377;${foodPrice}</span>
    </div>
    <div class="bill-row total">
        <span>Total Bill</span>
        <span>&#8377;${total}</span>
    </div>

    <form id="paymentForm"
          action="${pageContext.request.contextPath}/payment"
          method="post"
          novalidate>

        <div class="field">
            <input type="number"
                   id="amount"
                   name="amount"
                   placeholder="Enter Total Amount"
                   min="1"
                   step="any">
            <span class="err"    id="amountErr"></span>
            <span id="matchMsg"></span>
        </div>

        <button type="submit" id="payBtn">Pay Now</button>

    </form>

</div>

<script>

    // total from server — used for live match check
    var expectedTotal = parseFloat("${total}") || 0;

    var amountInput = document.getElementById('amount');
    var matchMsg    = document.getElementById('matchMsg');
    var payBtn      = document.getElementById('payBtn');

    function showError(msg) {
        amountInput.classList.add('invalid');
        document.getElementById('amountErr').textContent = msg;
        matchMsg.textContent = '';
        payBtn.disabled = true;
    }

    function clearError() {
        amountInput.classList.remove('invalid');
        document.getElementById('amountErr').textContent = '';
    }

    // live feedback as user types
    amountInput.addEventListener('input', function () {

        var val = parseFloat(this.value);

        if (this.value === '' || isNaN(val)) {
            clearError();
            matchMsg.textContent = '';
            payBtn.disabled = false;
            return;
        }

        if (val <= 0) {
            showError('Amount must be greater than 0.');
            return;
        }

        clearError();

        // live match check
        if (val === expectedTotal) {
            matchMsg.style.color = '#27ae60';
            matchMsg.textContent = '✓ Amount matches the total bill.';
            payBtn.disabled = false;
        } else if (val < expectedTotal) {
            matchMsg.style.color = '#e67e22';
            matchMsg.textContent = '⚠ Amount is less than total bill by ₹' +
                (expectedTotal - val).toFixed(2);
            payBtn.disabled = false; // let server reject it so user sees proper error
        } else {
            matchMsg.style.color = '#e74c3c';
            matchMsg.textContent = '✗ Amount exceeds total bill by ₹' +
                (val - expectedTotal).toFixed(2);
            payBtn.disabled = false;
        }
    });

    // submit validation
    document.getElementById('paymentForm').addEventListener('submit', function (e) {

        var val = parseFloat(amountInput.value);

        if (amountInput.value === '' || isNaN(val)) {
            showError('Please enter the payment amount.');
            e.preventDefault();
            return;
        }

        if (val <= 0) {
            showError('Amount must be greater than 0.');
            e.preventDefault();
            return;
        }

        // block obvious mismatches right here in browser
        if (val !== expectedTotal) {
            showError('Amount entered does not match total bill of ₹' + expectedTotal + '.');
            e.preventDefault();
        }
    });

</script>

</body>
</html>
