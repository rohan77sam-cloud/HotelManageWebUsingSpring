package com.hotel.service;

import com.hotel.entity.RoomEntity;
import com.hotel.util.HibernateUtil;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class RoomBookingService {

    public boolean bookRoom(
            String username,
            String roomType,
            double price) {

        // Business Validation

        if(username == null ||
                username.trim().isEmpty()) {

            return false;
        }

        if(roomType == null ||
                roomType.trim().isEmpty()) {

            return false;
        }

        if(price <= 0) {

            return false;
        }

        Session session =
                HibernateUtil
                        .getSessionFactory()
                        .openSession();

        Query<RoomEntity> query =
                session.createQuery(
                        "from RoomEntity where roomType=:r and status='Booked'",
                        RoomEntity.class
                );

        query.setParameter("r", roomType);

        // FIX: Added setMaxResults(1) before uniqueResult().
        // Without this, if there are somehow 2 rows with the same roomType+Booked status,
        // uniqueResult() throws NonUniqueResultException and crashes the app.
        query.setMaxResults(1);

        RoomEntity existingRoom =
                query.uniqueResult();

        if (existingRoom != null) {
            session.close();
            return false;
        }

        Transaction tx =
                session.beginTransaction();

        RoomEntity room =
                new RoomEntity();

        room.setUsername(username);
        room.setRoomType(roomType);
        room.setPrice(price);
        room.setStatus("Booked");

        room.setPaymentDone(false);

        // FIX: session.save() was removed in Hibernate 6. Use session.persist() instead.
        session.persist(room);

        tx.commit();

        session.close();

        return true;
    }
}
