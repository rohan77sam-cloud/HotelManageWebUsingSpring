package com.hotel.controller;

import com.hotel.service.RegisterService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterController {

    private RegisterService service =
            new RegisterService();

    @PostMapping("/register")

    public String registerUser(

            @RequestParam("username")
            String username,

            @RequestParam("password")
            String password) {

        // Backend Validation 1
        if(username == null ||
                username.trim().isEmpty()) {

            return "register";
        }

        // Backend Validation 2
        if(password == null ||
                password.trim().isEmpty()) {

            return "register";
        }

        // Backend Validation 3
        if(password.length() < 6) {

            return "register";
        }

        service.registerUser(
                username,
                password
        );

        return "login";
    }
}