package com.sunday.otmt.dao;

import java.util.List;

import com.sunday.otmt.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.annotations.QueryHints;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sunday.otmt.entity.Team;

@Repository
public class TeamDAOImpl implements GenericDAO<Team> {
	
	private final SessionFactory sessionFactory;

	@Autowired
	public TeamDAOImpl(SessionFactory sessionFactory){
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Team save(Team team) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(team);
		return team;
	}

	@Override
	public Team getEntityById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Team team = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.teamMembers " +
						"where t.id =: id", Team.class)
				.setParameter("id", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		team = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.teamProjects " +
				"where t.id =: id", Team.class)
				.setParameter("id", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();


		team = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.invitedPeople " +
						"where t.id =: id", Team.class)
				.setParameter("id", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		return team;
	}

	@Override
	public List<Team> getAllEntities() {
		Session session = sessionFactory.getCurrentSession();
		List<Team> teams = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.teamMembers", Team.class)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		teams = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.teamProjects ", Team.class)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		teams = session.createQuery(
				"select DISTINCT t from Team t " +
						"left join fetch t.invitedPeople", Team.class)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		return teams;
	}

	@Override
	public void delete(int id) {
		Session session = sessionFactory.getCurrentSession();
		Team team = session.get(Team.class, id);
		session.delete(team);
	}
	
}