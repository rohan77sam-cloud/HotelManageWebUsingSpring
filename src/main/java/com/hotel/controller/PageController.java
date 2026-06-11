package com.hotel.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String home() {
        return "register";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/profilePage")
    public String profilePage() {
        return "profile";
    }

    @GetMapping("/roomBookingPage")
    public String roomBookingPage() {
        return "roombooking";
    }

    @GetMapping("/foodPage")
    public String foodPage() {
        return "orderfood";
    }

    // FIX: paymentPage calculates totals from session and passes them to payment.jsp.
    // Also stores totalAmount in session so PaymentController can validate it.
    @GetMapping("/paymentPage")
    public String paymentPage(HttpSession session, Model model) {

        Double roomPrice =
                (Double) session.getAttribute("roomPrice");

        Double foodPrice =
                (Double) session.getAttribute("foodPrice");

        double room = (roomPrice == null ? 0.0 : roomPrice);
        double food = (foodPrice == null ? 0.0 : foodPrice);
        double total = room + food;

        model.addAttribute("roomPrice", room);
        model.addAttribute("foodPrice", food);
        model.addAttribute("total", total);

        session.setAttribute("totalAmount", total);

        return "payment";
    }

    // NOTE: /logout is handled by LogoutController.java — do NOT add it here.
}
