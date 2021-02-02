package com.sunday.otmt.entity;

import lombok.*;
import org.hibernate.annotations.Cascade;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "USER")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "UserId")
	private int id;

	@Column(name = "UserName")
	private String userName;

	@Column(name = "FirstName")
	private String firstName;

	@Column(name = "LastName")
	private String lastName;

	@Column(name = "EmailAddress")
	private String emailAddress;

	@Column(name = "PhoneNumber")
	private String phoneNumber;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date createdAt;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "TEAM_MEMBER",
			joinColumns = { @JoinColumn(name = "UserId") },
			inverseJoinColumns = { @JoinColumn(name = "TeamId") }
	)
	private List<Team> registeredTeams;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "ASSIGNED_TASK",
			joinColumns = { @JoinColumn(name = "UserId") },
			inverseJoinColumns = { @JoinColumn(name = "TaskId") }
	)
	private List<Task> assignedTasks;

	@ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(
			name = "INVITATION",
			joinColumns = { @JoinColumn(name = "InvitedPerson")},
			inverseJoinColumns = { @JoinColumn(name = "InvitingTeam") }
	)
	private List<Team> invitingTeams;

	public void addRegisteredTeam(Team team) {
		if (registeredTeams == null){
			registeredTeams = new ArrayList<>();
		}
		registeredTeams.add(team);
	}

	public void addAssignedTask(Task newTask) {
		if (assignedTasks == null){
			assignedTasks = new ArrayList<>();
		}
		this.assignedTasks.add(newTask);
	}

}
