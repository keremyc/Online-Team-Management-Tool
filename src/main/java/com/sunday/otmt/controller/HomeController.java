package com.sunday.otmt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sunday.otmt.entity.Task;
import com.sunday.otmt.entity.Team;
import com.sunday.otmt.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;

import com.sunday.otmt.service.GenericService;

@Controller
public class HomeController {

	@Autowired
	@Qualifier("userServiceImpl")
	private GenericService<User> userService;

	@GetMapping("/")
	public String showHomePage(Model model,
							   HttpServletRequest req) {
		HttpSession session = req.getSession();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentUserName = authentication.getName();
		User user = null;
		try {
			user = userService.getByName(currentUserName);
		} catch (Exception e) {
			return "error-page";
		}
		session.setAttribute("currentUser", user);

		for (Team team:
			 user.getInvitingTeams()) {
			System.out.println(team);
		}

		Team team = new Team();
		model.addAttribute("team", team);
		System.out.println("Deneme");
		return "home";
	}

}