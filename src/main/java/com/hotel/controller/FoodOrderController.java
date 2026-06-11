package com.hotel.controller;

import com.hotel.service.FoodOrderService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FoodOrderController {

    private FoodOrderService service =
            new FoodOrderService();

    @PostMapping("/foodorder")

    public String orderFood(

            @RequestParam("cuisine")
            String cuisine,

            @RequestParam("foodName")
            String foodName,

            @RequestParam("price")
            double price,

            HttpSession session) {

        String username =
                (String) session.getAttribute("username");


        // Session Validation
        if(username == null) {
            return "login";
        }

        // Cuisine Validation
        if(cuisine == null ||
                cuisine.trim().isEmpty()) {

            return "orderfood";
        }

        // Food Name Validation
        if(foodName == null ||
                foodName.trim().isEmpty()) {

            return "orderfood";
        }

        // Price Validation
        if(price <= 0) {

            return "orderfood";
        }

        service.saveFood(
                username,
                cuisine,
                foodName,
                price
        );

        // FIX: Accumulate the food price in the session each time an item is ordered.
        // The payment page needs this to show the food total.
        // We read the existing foodPrice (if any) and add the new item's price to it.
        Double existingFoodPrice =
                (Double) session.getAttribute("foodPrice");

        double newFoodTotal =
                (existingFoodPrice == null ? 0.0 : existingFoodPrice) + price;

        session.setAttribute("foodPrice", newFoodTotal);

        return "orderfood";
    }
}
