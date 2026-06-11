package com.hotel.controller;

import com.hotel.entity.FoodEntity;
import com.hotel.entity.PaymentEntity;
import com.hotel.entity.RoomEntity;
import com.hotel.service.AdminDashboardService;
import com.hotel.service.AdminLoginService;
import com.hotel.service.CheckoutService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

// REPLACED: Old version only loaded rooms for the dashboard.
// New version loads rooms (split by status), food orders, and payments.
// Also added /admin/guest — a detail page showing one guest's full info.
// Also added /admin/logout.

@Controller
public class AdminController {

    private AdminLoginService loginService =
            new AdminLoginService();

    private AdminDashboardService dashboardService =
            new AdminDashboardService();

    private CheckoutService checkoutService =
            new CheckoutService();

    // ── OPEN ADMIN LOGIN PAGE ────────────────────────────────────────
    @GetMapping("/admin")
    public String adminLoginPage() {
        return "adminLogin";
    }

    // ── PROCESS ADMIN LOGIN ──────────────────────────────────────────
    @PostMapping("/adminlogin")
    public String login(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        if(username == null ||
                username.trim().isEmpty()) {

            model.addAttribute(
                    "error",
                    "Username required");

            return "adminLogin";
        }

        if(password == null ||
                password.trim().isEmpty()) {

            model.addAttribute(
                    "error",
                    "Password required");

            return "adminLogin";
        }
        boolean valid = loginService.validate(username, password);

        if (valid) {
            session.setAttribute("admin", username);
            return "redirect:/admin/dashboard";
        }

        // Send error message back to login page
        model.addAttribute("error", "Invalid username or password. Please try again.");
        return "adminLogin";
    }

    // ── ADMIN DASHBOARD ──────────────────────────────────────────────
    // Loads all data needed for the 3 room tabs + food tab + payment tab
    @GetMapping("/admin/dashboard")
    public String dashboard(HttpSession session,
                            Model model) {

        if (session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }

        model.addAttribute(
                "pendingRooms",
                dashboardService.getPendingRooms());

        model.addAttribute(
                "paidRooms",
                dashboardService.getPaidRooms());

        model.addAttribute(
                "availableRooms",
                dashboardService.getAvailableRooms());

        model.addAttribute(
                "customers",
                dashboardService.getCurrentCustomers());

        model.addAttribute(
                "allFoodOrders",
                dashboardService.getAllFoodOrders());

        model.addAttribute(
                "allPayments",
                dashboardService.getAllPayments());

        model.addAttribute(
                "totalRooms",
                dashboardService.getTotalRooms());

        model.addAttribute(
                "bookedRooms",
                dashboardService.getBookedRoomsCount());

        model.addAttribute(
                "availableCount",
                dashboardService.getAvailableRoomsCount());

        model.addAttribute(
                "revenue",
                dashboardService.getTotalRevenue());

        model.addAttribute(
                "occupancy",
                dashboardService.getOccupancyPercentage());

        return "adminDashboard";
    }

    // ── GUEST DETAIL PAGE ────────────────────────────────────────────
    // Shows one guest's room + food orders + payment status
    // URL: GET /admin/guest?username=john
    @GetMapping("/admin/guest")
    public String guestDetail(
            @RequestParam("username") String username,
            HttpSession session,
            Model model) {

        if (session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }

        // Room booked by this guest (latest Booked one)
        List<RoomEntity> rooms = dashboardService.getAllRooms();
        RoomEntity guestRoom = null;
        for (RoomEntity r : rooms) {
            if (username.equals(r.getUsername()) &&
                    "Booked".equals(r.getStatus())) {
                guestRoom = r;
                break;
            }
        }

        List<FoodEntity> foodOrders =
                dashboardService.getFoodOrdersByUser(username);

        // Food total
        double foodTotal = 0;
        for (FoodEntity f : foodOrders) {
            foodTotal += f.getPrice();
        }

        model.addAttribute("guestName",   username);
        model.addAttribute("guestRoom",   guestRoom);
        model.addAttribute("foodOrders",  foodOrders);
        model.addAttribute("foodTotal",   foodTotal);

        return "Adminguestdetail";
    }

    // ── CHECKOUT ─────────────────────────────────────────────────────
    // Marks room as Available — only works if paymentDone = true
    @PostMapping("/checkout")
    public String checkout(
            @RequestParam int roomId,
            HttpSession session) {

        if (session.getAttribute("admin") == null) {
            return "redirect:/admin";
        }

        checkoutService.checkoutRoom(roomId);
        return "redirect:/admin/dashboard";
    }

    // ── ADMIN LOGOUT ─────────────────────────────────────────────────
    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:/admin";
    }

}
