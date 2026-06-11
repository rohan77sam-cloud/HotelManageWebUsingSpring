package com.hotel.controller;

import org.springframework.ui.Model;
import com.hotel.service.LoginService;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    private LoginService service =
            new LoginService();

    @PostMapping("/login")
    public String loginUser(

            @RequestParam("username")
            String username,

            @RequestParam("password")
            String password,

            HttpSession session,
            Model model) {

        if(username == null ||
                username.trim().isEmpty()) {

            model.addAttribute(
                    "error",
                    "Username is required");

            return "login";
        }

        if(password == null ||
                password.trim().isEmpty()) {

            model.addAttribute(
                    "error",
                    "Password is required");

            return "login";
        }

        boolean valid =
                service.validateUser(
                        username,
                        password
                );

        if(valid) {

            session.setAttribute(
                    "username",
                    username
            );

            return "profile";
        }

        return "register";
    }
}