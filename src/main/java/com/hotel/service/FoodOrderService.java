package com.hotel.service;

import com.hotel.entity.FoodEntity;
import com.hotel.util.HibernateUtil;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class FoodOrderService {

    public void saveFood(
            String username,
            String cuisine,
            String foodName,
            double price) {

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Transaction tx =
                session.beginTransaction();

        FoodEntity food =
                new FoodEntity();

        food.setUsername(username);
        food.setCuisine(cuisine);
        food.setFoodName(foodName);
        food.setPrice(price);

        // FIX: session.save() was removed in Hibernate 6. Use session.persist() instead.
        session.persist(food);

        tx.commit();

        session.close();
    }
}
