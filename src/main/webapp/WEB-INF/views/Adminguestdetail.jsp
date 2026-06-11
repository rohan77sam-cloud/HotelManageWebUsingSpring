<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>Guest Detail — ${guestName}</title>
<style>

* { box-sizing: border-box; margin: 0; padding: 0; }

body { font-family: Arial, sans-serif; background: #f0f2f5; min-height: 100vh; }

.navbar {
    background: linear-gradient(to right, #0f3460, #e94560);
    padding: 0 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 60px;
    color: white;
    box-shadow: 0 2px 8px rgba(0,0,0,0.3);
}
.navbar h2 { font-size: 18px; }
.btn-back {
    background: rgba(255,255,255,0.15);
    border: 1px solid rgba(255,255,255,0.4);
    color: white;
    padding: 7px 18px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 13px;
}
.btn-back:hover { background: rgba(255,255,255,0.3); }

.content { max-width: 860px; margin: 30px auto; padding: 0 20px; }

/* ── Guest name header ── */
.guest-header {
    background: white;
    border-radius: 12px;
    padding: 24px 28px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    display: flex;
    align-items: center;
    gap: 20px;
}
.avatar {
    width: 60px; height: 60px;
    background: linear-gradient(135deg, #0f3460, #e94560);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 26px;
    font-weight: bold;
    flex-shrink: 0;
}
.guest-header h2 { font-size: 22px; color: #0f3460; }
.guest-header p  { color: #888; font-size: 14px; margin-top: 4px; }

/* ── Section card ── */
.card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
}
.card-header {
    padding: 14px 22px;
    font-size: 15px;
    font-weight: bold;
    color: white;
}
.card-header.blue   { background: #3498db; }
.card-header.gold   { background: #f39c12; }
.card-header.green  { background: #27ae60; }

table { width: 100%; border-collapse: collapse; }
th {
    background: #f8f9fa;
    padding: 10px 18px;
    text-align: left;
    font-size: 12px;
    text-transform: uppercase;
    color: #666;
    letter-spacing: 0.5px;
    border-bottom: 1px solid #eee;
}
td {
    padding: 13px 18px;
    font-size: 14px;
    color: #333;
    border-bottom: 1px solid #f4f4f4;
}
tr:last-child td { border-bottom: none; }
.total-row td {
    font-weight: bold;
    font-size: 15px;
    background: #f8fff8;
    color: #1e8449;
}
.empty { padding: 20px; text-align: center; color: #bbb; }

.badge { display: inline-block; padding: 3px 10px; border-radius: 10px; font-size: 12px; font-weight: bold; }
.badge-paid     { background: #d4efdf; color: #1e8449; }
.badge-pending  { background: #ffe0e0; color: #c0392b; }
.badge-booked   { background: #d6eaf8; color: #1a5276; }

/* Checkout button inside detail page */
.btn-checkout {
    background: #e94560; color: white;
    border: none; padding: 8px 18px;
    border-radius: 6px; cursor: pointer; font-size: 13px;
}
.btn-checkout:hover { background: #c0392b; }

.no-room {
    padding: 20px; text-align: center; color: #aaa;
}

</style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>&#128100; Guest Detail</h2>
    <a class="btn-back"
       href="${pageContext.request.contextPath}/admin/dashboard">
        &#8592; Back to Dashboard
    </a>
</div>

<div class="content">

    <!-- GUEST NAME HEADER -->
    <div class="guest-header">
        <div class="avatar">
            ${guestName.substring(0,1).toUpperCase()}
        </div>
        <div>
            <h2>${guestName}</h2>
            <p>Full profile — room, food orders &amp; payment status</p>
        </div>
    </div>

    <!-- ── SECTION 1: ROOM DETAILS ── -->
    <div class="card">
        <div class="card-header blue">&#127963; Room Booking</div>

        <c:choose>
            <c:when test="${guestRoom == null}">
                <div class="no-room">No active room booking found for this guest.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>Room ID</th>
                        <th>Room Type</th>
                        <th>Price (&#8377;)</th>
                        <th>Status</th>
                        <th>Payment</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td>#${guestRoom.roomId}</td>
                        <td>${guestRoom.roomType}</td>
                        <td>&#8377;${guestRoom.price}</td>
                        <td><span class="badge badge-booked">BOOKED</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${guestRoom.paymentDone}">
                                    <span class="badge badge-paid">PAID &#10003;</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-pending">PENDING</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${guestRoom.paymentDone}">
                                <form action="${pageContext.request.contextPath}/checkout"
                                      method="post"
                                      onsubmit="return confirm('Checkout ${guestName} and free the ${guestRoom.roomType} room?')">
                                    <input type="hidden" name="roomId" value="${guestRoom.roomId}">
                                    <button class="btn-checkout">&#10003; Checkout</button>
                                </form>
                            </c:if>
                            <c:if test="${!guestRoom.paymentDone}">
                                <span style="color:#aaa;font-size:13px;">Awaiting Payment</span>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ── SECTION 2: FOOD ORDERS ── -->
    <div class="card">
        <div class="card-header gold">&#127829; Food Orders</div>

        <c:choose>
            <c:when test="${empty foodOrders}">
                <div class="empty">No food orders placed by this guest.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Cuisine</th>
                        <th>Food Item</th>
                        <th>Price (&#8377;)</th>
                    </tr>

                    <c:forEach var="f" items="${foodOrders}">
                    <tr>
                        <td>#${f.orderId}</td>
                        <td>${f.cuisine}</td>
                        <td>${f.foodName}</td>
                        <td>&#8377;${f.price}</td>
                    </tr>
                    </c:forEach>

                    <tr class="total-row">
                        <td colspan="3">Total Food Bill</td>
                        <td>&#8377;${foodTotal}</td>
                    </tr>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ── SECTION 3: PAYMENT SUMMARY ── -->
    <div class="card">
        <div class="card-header green">&#128181; Payment Summary</div>
        <table>
            <tr>
                <th>Item</th>
                <th>Amount (&#8377;)</th>
            </tr>
            <tr>
                <td>Room — ${guestRoom != null ? guestRoom.roomType : 'N/A'}</td>
                <td>&#8377;${guestRoom != null ? guestRoom.price : 0}</td>
            </tr>
            <tr>
                <td>Total Food Orders</td>
                <td>&#8377;${foodTotal}</td>
            </tr>
            <tr class="total-row">
                <td>Grand Total</td>
                <td>&#8377;${(guestRoom != null ? guestRoom.price : 0) + foodTotal}</td>
            </tr>
            <tr>
                <td>Payment Status</td>
                <td>
                    <c:choose>
                        <c:when test="${guestRoom != null && guestRoom.paymentDone}">
                            <span class="badge badge-paid">PAID &#10003;</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-pending">PENDING</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>

</div>

</body>
</html>
