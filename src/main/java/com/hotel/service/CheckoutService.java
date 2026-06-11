package com.hotel.service;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.hotel.entity.RoomEntity;
import com.hotel.util.HibernateUtil;

public class CheckoutService {

    public boolean checkoutRoom(
            int roomId) {

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Transaction tx =
                session.beginTransaction();

        RoomEntity room =
                session.get(
                        RoomEntity.class,
                        roomId);

        if(room != null &&
                room.isPaymentDone()) {

            room.setStatus(
                    "Available");

            room.setUsername(null);

            room.setPaymentDone(false);

            session.merge(room);
        }

        tx.commit();

        session.close();

        return true;
    }
}