package com.hotel.service;

import com.hotel.entity.PaymentEntity;
import com.hotel.entity.RoomEntity;
import com.hotel.util.HibernateUtil;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class PaymentService {

    public boolean makePayment(
            String username,
            double enteredAmount,
            double actualAmount) {

        if (enteredAmount != actualAmount)
            return false;

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Transaction tx =
                session.beginTransaction();

        PaymentEntity payment =
                new PaymentEntity();

        payment.setUsername(username);
        payment.setTotalAmount(actualAmount);

        // FIX: session.save() was removed in Hibernate 6. Use session.persist() instead.
        session.persist(payment);


        Query<RoomEntity> query =
                session.createQuery(
                        "from RoomEntity where username=:u and status='Booked'",
                        RoomEntity.class);

        query.setParameter("u", username);

        RoomEntity room =
                query.setMaxResults(1)
                        .uniqueResult();

        if(room != null) {

            room.setPaymentDone(true);

            session.merge(room);
        }
        tx.commit();

        session.close();

        return true;
    }
}
