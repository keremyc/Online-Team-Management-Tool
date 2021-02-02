package com.sunday.otmt.controller;

import com.sunday.otmt.entity.User;
import com.sunday.otmt.service.GenericService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private GenericService<User> userService;

    @PostMapping("/users")
    public String getPeople(Model model){

        List<User> users = userService.getAll();
        model.addAttribute("allUsers", users);
        return "invite";

    }




}
