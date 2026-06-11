package com.hotel.controller;

import com.hotel.service.RoomBookingService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RoomBookingController {

    private RoomBookingService service =
            new RoomBookingService();

    @PostMapping("/bookroom")

    public String bookRoom(

            @RequestParam("roomType")
            String roomType,

            @RequestParam("price")
            double price,

            HttpSession session) {

        String username =
                (String) session.getAttribute("username");

        // Session Validation
        if(username == null) {
            return "login";
        }

// Room Type Validation
        if(roomType == null ||
                roomType.trim().isEmpty()) {

            return "booking";
        }

// Price Validation
        if(price <= 0) {

            return "booking";
        }

        boolean booked =
                service.bookRoom(
                        username,
                        roomType,
                        price
                );

        if (booked) {

            // FIX: Store the room price in the session so the payment page
            // can display it and use it for total calculation.
            session.setAttribute("roomPrice", price);

            return "orderfood";
        }

        return "roomBooked";
    }
}
