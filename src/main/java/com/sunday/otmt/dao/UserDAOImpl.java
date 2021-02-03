package com.sunday.otmt.dao;

import java.util.List;

import com.sunday.otmt.entity.Task;
import com.sunday.otmt.entity.Team;
import com.sunday.otmt.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.annotations.QueryHints;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.QueryHint;

@Repository
public class UserDAOImpl implements GenericDAO<User> {

	private final SessionFactory sessionFactory;

	@Autowired
	public UserDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public User save(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(user);
		return user;
	}

	@Override
	public User getEntityById(int id) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.registeredTeams " +
						"where u.id =: userId", User.class)
				.setParameter("userId", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		user = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.assignedTasks " +
						"where u.id =: userId", User.class)
				.setParameter("userId", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();


		user = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.invitingTeams " +
						"where u.id =: userId", User.class)
				.setParameter("userId", id)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		return user;
	}

	@Override
	public List<User> getAllEntities() {

		Session session = sessionFactory.getCurrentSession();

		List<User> users = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.registeredTeams ",  User.class)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		users = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.assignedTasks " +
						"where u in :users", User.class)
				.setParameter("users", users)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		users = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.invitingTeams " +
						"where u in :users", User.class)
				.setParameter("users", users)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getResultList();

		return users;
	}

	@Override
	public void delete(int id) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);
		session.delete(user);
	}
	
	@Override
	public User getEntityByName(String name) {
		Session session = sessionFactory.getCurrentSession();

		User user = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.registeredTeams " +
						"where u.userName =: uName", User.class)
				.setParameter("uName", name)
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		user = session.createQuery(
				"select DISTINCT u from User u " +
				"left join fetch u.assignedTasks " +
				"where u.id =: userId", User.class)
				.setParameter("userId", user.getId())
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		user = session.createQuery(
				"select DISTINCT u from User u " +
						"left join fetch u.invitingTeams " +
						"where u.id =: userId", User.class)
				.setParameter("userId", user.getId())
				.setHint(QueryHints.PASS_DISTINCT_THROUGH, false)
				.getSingleResult();

		return user;

	}
	
}