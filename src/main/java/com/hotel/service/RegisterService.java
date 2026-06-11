package com.hotel.service;

import org.hibernate.query.Query;
import com.hotel.entity.UserEntity;
import com.hotel.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RegisterService {

    public void registerUser(
            String username,
            String password) {

        UserEntity user =
                new UserEntity();

        user.setUsername(username);
        user.setPassword(password);

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Query<UserEntity> query =
                session.createQuery(
                        "from UserEntity where username=:u",
                        UserEntity.class);

        query.setParameter(
                "u",
                username);

        UserEntity existingUser =
                query.uniqueResult();

        if(existingUser != null) {

            session.close();

            return;
        }

        Transaction tx =
                session.beginTransaction();

        // FIX: session.save() was removed in Hibernate 6. Use session.persist() instead.
        session.persist(user);

        tx.commit();

        session.close();
    }
}
