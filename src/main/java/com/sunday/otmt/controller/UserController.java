package com.sunday.otmt.controller;

import com.sunday.otmt.entity.Project;
import com.sunday.otmt.entity.Team;
import com.sunday.otmt.entity.User;
import com.sunday.otmt.exception.EntityNotFoundException;
import com.sunday.otmt.service.GenericService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private GenericService<User> userService;

    @Autowired
    @Qualifier("teamServiceImpl")
    private GenericService<Team> teamService;

    @PostMapping("/invite")
    public String getPeople(HttpServletRequest req, Model model) throws EntityNotFoundException {

        HttpSession session = req.getSession();
        Team team = (Team) session.getAttribute("currentTeam");
        if (team == null)
            return "error-page";

        User user = userService.getByName((String) req.getParameter("userName"));

        team.addToInvitations(user);
        user.addToInvitation(team);
        teamService.save(team);

        model.addAttribute("inviteMessage", "You invited " + user.getFirstName() + " successfully!");
        model.addAttribute("project", new Project());

        return "team-detail";

    }

    @PostMapping("/acceptInv")
    public String acceptInvitation(HttpServletRequest req, Model model) throws EntityNotFoundException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null)
            return "error-page";

        Team team = teamService.getById(Integer.parseInt(req.getParameter("teamId")));
        team.addTeamMember(user);
        team.getInvitedPeople().remove(user);

        teamService.save(team);

     //   model.addAttribute("inviteMessage", "You invited " + user.getFirstName() + " successfully!");
        model.addAttribute("team", new Team());

        return "home";

    }


    @PostMapping("/declineInv")
    public String declineInvitation(HttpServletRequest req, Model model) throws EntityNotFoundException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null)
            return "error-page";

        Team team = teamService.getById(Integer.parseInt(req.getParameter("teamId")));


team.getInvitedPeople().remove(user);
        teamService.save(team);

        model.addAttribute("team", new Team());

        return "home";

    }



}
