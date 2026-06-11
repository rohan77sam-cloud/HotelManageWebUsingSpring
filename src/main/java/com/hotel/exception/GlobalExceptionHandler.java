package com.hotel.exception;

import org.hibernate.HibernateException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

//    @ExceptionHandler(Exception.class)
//    public String handleException(
//            Exception ex,
//            Model model) {
//
//        model.addAttribute(
//                "message",
//                ex.getMessage());
//
//        return "error";
//    }


    @ExceptionHandler(
            NullPointerException.class)
    public String handleNPE(
            NullPointerException ex,
            Model model) {

        model.addAttribute(
                "message",
                "Data not found.");

        return "error";
    }

    @ExceptionHandler(
            HibernateException.class)
    public String handleHibernate(
            HibernateException ex,
            Model model) {

        model.addAttribute(
                "message",
                "Database Error.");

        return "error";
    }

}