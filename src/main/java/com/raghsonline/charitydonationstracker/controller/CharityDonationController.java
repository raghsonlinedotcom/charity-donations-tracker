package com.raghsonline.charitydonationstracker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;

@Controller
@CrossOrigin(origins = "http://localhost:8081")
public class CharityDonationController {

    @RequestMapping("/")
    public String index(Model model) {
        System.out.println("URL '/' invoked!");
        model.addAttribute("date", LocalDateTime.now());
        return "charityDonations";
    }
}

