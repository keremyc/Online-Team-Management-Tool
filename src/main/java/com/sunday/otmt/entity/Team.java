package com.sunday.otmt.entity;

import lombok.*;

import java.util.*;

import javax.persistence.*;

import org.hibernate.annotations.Cascade;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "TEAM")
@Getter @Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Team {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "TeamId")
	private int id;
	
	@Column(name = "Name")
	private String name;
	
	@Column(name = "Description")
	private String description;
	
	@Column(name = "Category")
	private String category;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	@Column(name = "CreatedAt")
	private Date createdAt;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "TeamManagerId")
	private User manager;

	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	@JoinTable(
			name="TEAM_MEMBER",
			joinColumns = { @JoinColumn(name = "TeamId") },
			inverseJoinColumns = { @JoinColumn(name = "UserId") }
	)
	private List<User> teamMembers;

	@JoinTable(
			name = "INVITATION",
			joinColumns = { @JoinColumn(name = "InvitingTeam") },
			inverseJoinColumns = { @JoinColumn(name = "InvitedPerson") }
	)
	@ManyToMany(fetch = FetchType.LAZY)
	private List<User> invitedPeople = new ArrayList<>();

	@Cascade({ org.hibernate.annotations.CascadeType.SAVE_UPDATE,
			org.hibernate.annotations.CascadeType.PERSIST})
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "ownerTeam", orphanRemoval = true)
	private List<Project> teamProjects;
	
	public void addTeamMember(User teamMember) {
		if (teamMembers == null) {
			teamMembers = new ArrayList<>();
		}
		teamMembers.add(teamMember);
	}

	public void addProject(Project project) {
		if (teamProjects == null){
			teamProjects = new ArrayList<>();

		}
		teamProjects.add(project);
	}

	public void addToInvitations(User user) {
		invitedPeople.add(user);
	}
}
