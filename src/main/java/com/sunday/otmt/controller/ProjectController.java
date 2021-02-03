package com.sunday.otmt.controller;

import com.sunday.otmt.entity.*;
import com.sunday.otmt.service.GenericService;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/proj")
public class ProjectController {

	@Autowired
	@Qualifier("teamServiceImpl")
	private GenericService<Team> teamService;
	
	@Autowired
	@Qualifier("projectServiceImpl")
	private GenericService<Project> projectService;

    @PostMapping("/create")
    public String createProject(HttpServletRequest req,
                                @ModelAttribute("project") Project project){

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null)
            return "login-page";

        User manager = project.getManager();
        Team team = (Team) session.getAttribute("currentTeam");

        if (manager == null || team == null)
            return "error-page";
        
        project.setOwnerTeam(team);
        team.addProject(project);
        teamService.save(team);
        
        session.setAttribute("currentTeam", team);
        
        return "team-detail";
    }

    @PostMapping("/createTask")
    public String createTask(HttpServletRequest req,
            				@ModelAttribute("task") Task task) {

    	HttpSession session = req.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        if (currentUser == null)
            return "login-page";

        Team currentTeam = (Team) session.getAttribute("currentTeam");
        if (currentTeam == null)
            return "redirect:/home";
        Project currentProject = (Project) session.getAttribute("currentProject");
        if (currentProject == null)
            return "redirect:/team/details";

        currentProject.addTask(task);
        task.setOwnerProject(currentProject);
        projectService.save(currentProject);
        
    	return "project-detail";
    }
    
	@GetMapping("/details")
	public String showProject(@RequestParam("projectId") int projectId,
                              HttpServletRequest req,
                              Model model) {
		
        HttpSession session = req.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        if (currentUser == null)
            return "login-page";

        Team currentTeam = (Team) session.getAttribute("currentTeam");
        if (currentTeam == null)
            return "redirect:/home";
        
        Project project = projectService.getById(projectId);
        List<User> projectMembers = new ArrayList<>();
        for (Task task: project.getProjectTasks()){
            for (User user: task.getRespondents()){
                if (!(projectMembers.contains(user))){
                    projectMembers.add(user);
                }
            }
        }

        session.setAttribute("currentProject", project);
        model.addAttribute("projectMembers", projectMembers);
        // TODO: PRoject MEmbers inside Session

		model.addAttribute("task", new Task());

		return "project-detail";
	}

	@GetMapping("/deleteTask")
    public String deleteTask(HttpServletRequest req,
                             @RequestParam("taskId") int taskId,
                             Model model){

        HttpSession session = req.getSession();
        Project currentProject = (Project) session.getAttribute("currentProject");
        if (currentProject == null)
            return "error-page";

        Task task = currentProject.getProjectTasks().stream()
                .filter(t -> t.getId() == taskId)
                .findFirst().get();

        if (task == null){
            return "error-page";
        }

        currentProject.getProjectTasks().remove(task);
        projectService.save(currentProject);

        model.addAttribute("task", new Task());

        return "project-detail";
    }

    @GetMapping("/mark")
    public String updateStatusOfTask(HttpServletRequest req,
                                     @RequestParam("taskId") Integer taskId,
                                     Model model){

        HttpSession session = req.getSession();
        Project currentProject = (Project) session.getAttribute("currentProject");
        if (currentProject == null)
            return "error-page";

        Task task = currentProject.getProjectTasks().stream()
                .filter(t -> t.getId() == taskId)
                .findFirst()
                .get();

        if (task == null)
            return "error-page";

        if (task.getStatus().equals(Status.FINISHED) || task.getStatus().equals(Status.PENDING))
            task.setStatus(Status.IN_PROGRESS);
        else
            task.setStatus(Status.FINISHED);

        projectService.save(currentProject);

        model.addAttribute("task", new Task());

        return "project-detail";

    }
    
}