<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>

/* ── RESET & BASE ─────────────────────────────────────── */
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #f0f2f5; min-height: 100vh; }

/* ── TOP NAVBAR ───────────────────────────────────────── */
.navbar {
    background: linear-gradient(to right, #0f3460, #e94560);
    padding: 0 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 60px;
    color: white;
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 2px 8px rgba(0,0,0,0.3);
}
.navbar h2 { font-size: 18px; letter-spacing: 0.5px; }
.nav-right { display: flex; align-items: center; gap: 16px; font-size: 14px; }
.nav-right span { opacity: 0.85; }
.btn-logout {
    background: rgba(255,255,255,0.15);
    border: 1px solid rgba(255,255,255,0.4);
    color: white;
    padding: 7px 18px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 13px;
    transition: background 0.2s;
}
.btn-logout:hover { background: rgba(255,255,255,0.3); }

/* ── SUMMARY STAT CARDS ───────────────────────────────── */
.stats {
    display: flex;
    gap: 16px;
    padding: 24px 30px 10px;
    flex-wrap: wrap;
}
.stat {
    flex: 1;
    min-width: 150px;
    background: white;
    border-radius: 12px;
    padding: 20px 24px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    border-top: 4px solid #ddd;
}
.stat.s1 { border-top-color: #e74c3c; }
.stat.s2 { border-top-color: #27ae60; }
.stat.s3 { border-top-color: #3498db; }
.stat.s4 { border-top-color: #f39c12; }
.stat.s5 { border-top-color: #9b59b6; }
.stat .num { font-size: 36px; font-weight: bold; margin-bottom: 4px; }
.stat.s1 .num { color: #e74c3c; }
.stat.s2 .num { color: #27ae60; }
.stat.s3 .num { color: #3498db; }
.stat.s4 .num { color: #f39c12; }
.stat.s5 .num { color: #9b59b6; }
.stat .lbl { color: #777; font-size: 13px; }

/* ── TAB BAR ──────────────────────────────────────────── */
.tabs {
    display: flex;
    gap: 0;
    padding: 20px 30px 0;
    border-bottom: 2px solid #ddd;
    margin: 0 0 0 0;
}
.tab {
    padding: 10px 22px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    color: #666;
    border-bottom: 3px solid transparent;
    margin-bottom: -2px;
    transition: all 0.2s;
    user-select: none;
}
.tab:hover { color: #0f3460; }
.tab.active { color: #0f3460; border-bottom-color: #e94560; }

/* ── TAB PANELS ───────────────────────────────────────── */
.panel { display: none; padding: 24px 30px; }
.panel.active { display: block; }

/* ── CARD WRAPPER ─────────────────────────────────────── */
.card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    overflow: hidden;
    margin-bottom: 20px;
}
.card-header {
    padding: 14px 20px;
    font-size: 14px;
    font-weight: bold;
    color: white;
    display: flex;
    align-items: center;
    gap: 8px;
}
.card-header.red   { background: #e74c3c; }
.card-header.green { background: #27ae60; }
.card-header.blue  { background: #3498db; }
.card-header.gold  { background: #f39c12; }
.card-header.purple{ background: #9b59b6; }

/* ── TABLE ────────────────────────────────────────────── */
table { width: 100%; border-collapse: collapse; }
th {
    background: #f8f9fa;
    padding: 11px 18px;
    text-align: left;
    font-size: 12px;
    color: #555;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 1px solid #eee;
}
td {
    padding: 13px 18px;
    border-bottom: 1px solid #f4f4f4;
    font-size: 14px;
    color: #333;
}
tr:last-child td { border-bottom: none; }
tr:hover td { background: #fafcff; }
.empty { padding: 24px; text-align: center; color: #bbb; font-size: 14px; }

/* ── BADGES ───────────────────────────────────────────── */
.badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 10px;
    font-size: 12px;
    font-weight: bold;
}
.badge-pending  { background: #ffe0e0; color: #c0392b; }
.badge-paid     { background: #d4efdf; color: #1e8449; }
.badge-booked   { background: #d6eaf8; color: #1a5276; }
.badge-available{ background: #e8f8f5; color: #1e8449; }

/* ── BUTTONS ──────────────────────────────────────────── */
.btn-checkout {
    background: #e94560;
    color: white;
    border: none;
    padding: 6px 14px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 12px;
}
.btn-checkout:hover { background: #c0392b; }
.btn-detail {
    background: #0f3460;
    color: white;
    padding: 5px 12px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 12px;
    display: inline-block;
}
.btn-detail:hover { background: #1a4a7a; }

</style>
</head>
<body>

<!-- ── NAVBAR ─────────────────────────────────────────────────── -->
<div class="navbar">
    <h2>&#127968; Hotel Admin Portal</h2>
    <div class="nav-right">
        <span>Welcome, <strong>${sessionScope.admin}</strong></span>
        <a class="btn-logout"
           href="${pageContext.request.contextPath}/admin/logout">
            Logout
        </a>
    </div>
</div>

<!-- ── SUMMARY CARDS ──────────────────────────────────────────── -->
<div class="stats">

    <div class="stat s1">
        <div class="num">${totalRooms}</div>
        <div class="lbl">Total Rooms</div>
    </div>

    <div class="stat s2">
        <div class="num">${bookedRooms}</div>
        <div class="lbl">Booked Rooms</div>
    </div>

    <div class="stat s3">
        <div class="num">${availableCount}</div>
        <div class="lbl">Available Rooms</div>
    </div>

    <div class="stat s4">
        <div class="num">₹${revenue}</div>
        <div class="lbl">Total Revenue</div>
    </div>

    <div class="stat s5">
        <div class="num">${occupancy}%</div>
        <div class="lbl">Occupancy Rate</div>
    </div>

</div>
<!-- ── TAB BAR ────────────────────────────────────────────────── -->
<div class="tabs">
    <div class="tab active" onclick="switchTab('pending')">&#128994; Pending Payment</div>
    <div class="tab"        onclick="switchTab('paid')">&#9989; Paid — Ready to Checkout</div>
    <div class="tab"        onclick="switchTab('available')">&#127995; Checked Out / Available</div>
    <div class="tab"        onclick="switchTab('food')">&#127829; Food Orders</div>
    <div class="tab"        onclick="switchTab('payments')">&#128181; Payments</div>
    <div class="tab"
         onclick="switchTab('customers')">
         👥 Customers
    </div>
</div>

<!-- ════════════════════════════════════════════════════════════
     TAB 1 — PENDING PAYMENT
     Guests who have booked a room but NOT yet paid
════════════════════════════════════════════════════════════ -->
<div class="panel active" id="tab-pending">
<div class="card">
    <div class="card-header red">&#128308; Rooms — Payment Pending (Guest is staying, not yet paid)</div>
    <c:choose>
        <c:when test="${empty pendingRooms}">
            <div class="empty">No rooms with pending payment.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Room ID</th><th>Guest</th><th>Room Type</th>
                    <th>Price (&#8377;)</th><th>Status</th><th>Payment</th><th>Details</th>
                </tr>
                <c:forEach var="r" items="${pendingRooms}">
                <tr>
                    <td>#${r.roomId}</td>
                    <td><strong>${r.username}</strong></td>
                    <td>${r.roomType}</td>
                    <td>&#8377;${r.price}</td>
                    <td><span class="badge badge-booked">BOOKED</span></td>
                    <td><span class="badge badge-pending">PENDING</span></td>
                    <td>
                        <a class="btn-detail"
                           href="${pageContext.request.contextPath}/admin/guest?username=${r.username}">
                           View Guest
                        </a>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- ════════════════════════════════════════════════════════════
     TAB 2 — PAID, READY TO CHECKOUT
     Guests who paid — admin clicks Checkout to free the room
════════════════════════════════════════════════════════════ -->
<div class="panel" id="tab-paid">
<div class="card">
    <div class="card-header green">&#9989; Rooms — Paid. Click Checkout to free the room for next guest.</div>
    <c:choose>
        <c:when test="${empty paidRooms}">
            <div class="empty">No guests awaiting checkout.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Room ID</th><th>Guest</th><th>Room Type</th>
                    <th>Price (&#8377;)</th><th>Status</th><th>Payment</th>
                    <th>Details</th><th>Action</th>
                </tr>
                <c:forEach var="r" items="${paidRooms}">
                <tr>
                    <td>#${r.roomId}</td>
                    <td><strong>${r.username}</strong></td>
                    <td>${r.roomType}</td>
                    <td>&#8377;${r.price}</td>
                    <td><span class="badge badge-booked">BOOKED</span></td>
                    <td><span class="badge badge-paid">PAID &#10003;</span></td>
                    <td>
                        <a class="btn-detail"
                           href="${pageContext.request.contextPath}/admin/guest?username=${r.username}">
                           View Guest
                        </a>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/checkout"
                              method="post"
                              onsubmit="return confirmCheckout('${r.username}', '${r.roomType}')">
                            <input type="hidden" name="roomId" value="${r.roomId}">
                            <button class="btn-checkout" type="submit">
                                &#10003; Checkout
                            </button>
                        </form>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- ════════════════════════════════════════════════════════════
     TAB 3 — CHECKED OUT / AVAILABLE
     Past guests who were checked out. Room is now free.
════════════════════════════════════════════════════════════ -->
<div class="panel" id="tab-available">
<div class="card">
    <div class="card-header blue">&#127995; Rooms — Checked Out (Now Available for New Bookings)</div>
    <c:choose>
        <c:when test="${empty availableRooms}">
            <div class="empty">No checkout history yet.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Room ID</th><th>Last Guest</th><th>Room Type</th>
                    <th>Price (&#8377;)</th><th>Status</th><th>Payment</th>
                </tr>
                <c:forEach var="r" items="${availableRooms}">
                <tr>
                    <td>#${r.roomId}</td>
                    <td>${r.username != null ? r.username : '—'}</td>
                    <td>${r.roomType}</td>
                    <td>&#8377;${r.price}</td>
                    <td><span class="badge badge-available">AVAILABLE</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${r.paymentDone}">
                                <span class="badge badge-paid">PAID &#10003;</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-pending">UNPAID</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- ════════════════════════════════════════════════════════════
     TAB 4 — FOOD ORDERS
     All food orders from all guests
════════════════════════════════════════════════════════════ -->
<div class="panel" id="tab-food">
<div class="card">
    <div class="card-header gold">&#127829; All Food Orders</div>
    <c:choose>
        <c:when test="${empty allFoodOrders}">
            <div class="empty">No food orders placed yet.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Order ID</th><th>Guest</th><th>Cuisine</th>
                    <th>Food Item</th><th>Price (&#8377;)</th><th>Guest Detail</th>
                </tr>
                <c:forEach var="f" items="${allFoodOrders}">
                <tr>
                    <td>#${f.orderId}</td>
                    <td><strong>${f.username}</strong></td>
                    <td>${f.cuisine}</td>
                    <td>${f.foodName}</td>
                    <td>&#8377;${f.price}</td>
                    <td>
                        <a class="btn-detail"
                           href="${pageContext.request.contextPath}/admin/guest?username=${f.username}">
                           View Guest
                        </a>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- ════════════════════════════════════════════════════════════
     TAB 5 — PAYMENTS
     All payment records
════════════════════════════════════════════════════════════ -->
<div class="panel" id="tab-payments">
<div class="card">
    <div class="card-header purple">&#128181; All Payment Records</div>
    <c:choose>
        <c:when test="${empty allPayments}">
            <div class="empty">No payments recorded yet.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Payment ID</th><th>Guest</th>
                    <th>Amount Paid (&#8377;)</th><th>Guest Detail</th>
                </tr>
                <c:forEach var="p" items="${allPayments}">
                <tr>
                    <td>#${p.paymentId}</td>
                    <td><strong>${p.username}</strong></td>
                    <td>&#8377;${p.totalAmount}</td>
                    <td>
                        <a class="btn-detail"
                           href="${pageContext.request.contextPath}/admin/guest?username=${p.username}">
                           View Guest
                        </a>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</div>

<div class="panel" id="tab-customers">

<div class="card">

<div class="card-header blue">
👥 Current Customers
</div>

<c:choose>

<c:when test="${empty customers}">
    <div class="empty">
        No customers found.
    </div>
</c:when>

<c:otherwise>

<table>

<tr>
    <th>Room</th>
    <th>Customer</th>
    <th>Room Type</th>
    <th>Price</th>
    <th>Payment</th>
    <th>Details</th>
</tr>

<c:forEach items="${customers}" var="c">

<tr>

<td>#${c.roomId}</td>

<td>${c.username}</td>

<td>${c.roomType}</td>

<td>₹${c.price}</td>

<td>

<c:choose>

<c:when test="${c.paymentDone}">
    <span class="badge badge-paid">
        PAID
    </span>
</c:when>

<c:otherwise>
    <span class="badge badge-pending">
        PENDING
    </span>
</c:otherwise>

</c:choose>

</td>

<td>

<a class="btn-detail"
href="${pageContext.request.contextPath}/admin/guest?username=${c.username}">
View Guest
</a>

</td>

</tr>

</c:forEach>

</table>

</c:otherwise>

</c:choose>

</div>

</div>

<!-- ════════════════════════════════════════════════════════════
     JAVASCRIPT — tab switching + checkout confirmation
════════════════════════════════════════════════════════════ -->
<script>

    // Map tab names to their panel IDs and the matching tab index
    var tabNames = [
        'pending',
        'paid',
        'available',
        'food',
        'payments',
        'customers'
    ];
    var tabs     = document.querySelectorAll('.tab');

    function switchTab(name) {

        // Hide all panels, deactivate all tabs
        tabNames.forEach(function(t) {
            document.getElementById('tab-' + t).classList.remove('active');
        });
        tabs.forEach(function(t) {
            t.classList.remove('active');
        });

        // Show selected
        document.getElementById('tab-' + name).classList.add('active');
        tabs[tabNames.indexOf(name)].classList.add('active');
    }

    function confirmCheckout(username, roomType) {
        return confirm(
            'Checkout guest "' + username + '" from ' + roomType + ' room?\n\n' +
            'The room will be marked AVAILABLE for new bookings.'
        );
    }

</script>

</body>
</html>
