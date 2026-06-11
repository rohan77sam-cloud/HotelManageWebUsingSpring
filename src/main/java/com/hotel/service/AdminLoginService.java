package com.hotel.service;

import com.hotel.entity.AdminEntity;
import com.hotel.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class AdminLoginService {

    public boolean validate(
            String username,
            String password) {

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Query<AdminEntity> query =
                session.createQuery(
                        "from AdminEntity where username=:u and password=:p",
                        AdminEntity.class);

        query.setParameter("u", username);
        query.setParameter("p", password);

        AdminEntity admin =
                query.uniqueResult();

        session.close();

        return admin != null;
    }
}