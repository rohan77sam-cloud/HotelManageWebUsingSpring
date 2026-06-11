package com.hotel.controller;

import com.hotel.service.PaymentService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PaymentController {

    private PaymentService service =
            new PaymentService();

    @PostMapping("/payment")

    public String payment(

            @RequestParam("amount")
            double amount,

            HttpSession session) {

        String username =
                (String) session.getAttribute(
                        "username"
                );

        Object totalObj =
                session.getAttribute(
                        "totalAmount"
                );

        if(totalObj == null)
            return "invalidPayment";

        double actualAmount =
                (double) totalObj;

        boolean status =
                service.makePayment(
                        username,
                        amount,
                        actualAmount
                );

        if(status)
            return "thanks";

        return "invalidPayment";
    }
}