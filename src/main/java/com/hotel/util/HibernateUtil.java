package com.hotel.util;

import com.hotel.entity.AdminEntity;
import com.hotel.entity.FoodEntity;
import com.hotel.entity.PaymentEntity;
import com.hotel.entity.RoomEntity;
import com.hotel.entity.UserEntity;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {

        try {

            sessionFactory =
                    new Configuration()
                            .configure("hibernate.cfg.xml")
                            .addAnnotatedClass(UserEntity.class)
                            .addAnnotatedClass(RoomEntity.class)
                            .addAnnotatedClass(FoodEntity.class)
                            .addAnnotatedClass(PaymentEntity.class)
                            // ADDED: AdminEntity was missing — without this,
                            // the admins table is never created and admin login always fails.
                            .addAnnotatedClass(AdminEntity.class)
                            .buildSessionFactory();

        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
