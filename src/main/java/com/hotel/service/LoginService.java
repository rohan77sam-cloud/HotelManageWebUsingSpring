package com.hotel.service;

import com.hotel.entity.UserEntity;
import com.hotel.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class LoginService {

    public boolean validateUser(String username,
                                String password) {

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Query<UserEntity> query =
                session.createQuery(
                        "from UserEntity where username=:u and password=:p",
                        UserEntity.class
                );

        query.setParameter("u", username);
        query.setParameter("p", password);

        UserEntity user =
                query.uniqueResult();

        session.close();

        return user != null;
    }
}