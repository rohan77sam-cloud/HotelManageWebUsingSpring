package com.hotel.service;

import com.hotel.entity.FoodEntity;
import com.hotel.entity.PaymentEntity;
import com.hotel.entity.RoomEntity;
import com.hotel.util.HibernateUtil;

import org.hibernate.Session;

import java.util.List;

// REPLACED: Old version only had getAllRooms().
// New version has separate methods for each tab of the admin dashboard:
//   - rooms split into booked (pending) vs booked (paid) vs available
//   - all food orders
//   - all payment records

public class AdminDashboardService {

    // ── ROOMS ────────────────────────────────────────────────────────

    // Rooms that are currently BOOKED and payment is NOT done yet (Pending)
    public List<RoomEntity> getPendingRooms() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<RoomEntity> list =
                session.createQuery(
                        "from RoomEntity where status='Booked' and paymentDone=false",
                        RoomEntity.class
                ).list();

        session.close();
        return list;
    }

    // Rooms that are BOOKED and payment IS done — admin can checkout these
    public List<RoomEntity> getPaidRooms() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<RoomEntity> list =
                session.createQuery(
                        "from RoomEntity where status='Booked' and paymentDone=true",
                        RoomEntity.class
                ).list();

        session.close();
        return list;
    }

    // Rooms that have been checked out — now Available for next guest
    public List<RoomEntity> getAvailableRooms() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<RoomEntity> list =
                session.createQuery(
                        "from RoomEntity where status='Available'",
                        RoomEntity.class
                ).list();

        session.close();
        return list;
    }

    // All rooms combined — still available for the old simple view
    public List<RoomEntity> getAllRooms() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<RoomEntity> list =
                session.createQuery(
                        "from RoomEntity",
                        RoomEntity.class
                ).list();

        session.close();
        return list;
    }

    // ── FOOD ORDERS ──────────────────────────────────────────────────

    // All food orders across all guests
    public List<FoodEntity> getAllFoodOrders() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<FoodEntity> list =
                session.createQuery(
                        "from FoodEntity order by username",
                        FoodEntity.class
                ).list();

        session.close();
        return list;
    }

    // Food orders for one specific guest (used in guest detail popup)
    public List<FoodEntity> getFoodOrdersByUser(String username) {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<FoodEntity> list =
                session.createQuery(
                        "from FoodEntity where username=:u",
                        FoodEntity.class
                ).setParameter("u", username).list();

        session.close();
        return list;
    }

    // ── PAYMENTS ─────────────────────────────────────────────────────

    // All payment records
    public List<PaymentEntity> getAllPayments() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<PaymentEntity> list =
                session.createQuery(
                        "from PaymentEntity order by username",
                        PaymentEntity.class
                ).list();

        session.close();
        return list;
    }
    public long getTotalRooms() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        Long count =
                session.createQuery(
                        "select count(r) from RoomEntity r",
                        Long.class
                ).uniqueResult();

        session.close();

        return count == null ? 0 : count;
    }
    public long getBookedRoomsCount() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        Long count =
                session.createQuery(
                        "select count(r) from RoomEntity r where status='Booked'",
                        Long.class
                ).uniqueResult();

        session.close();

        return count == null ? 0 : count;
    }
    public long getAvailableRoomsCount() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        Long count =
                session.createQuery(
                        "select count(r) from RoomEntity r where status='Available'",
                        Long.class
                ).uniqueResult();

        session.close();

        return count == null ? 0 : count;
    }
    public double getTotalRevenue() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        Double revenue =
                session.createQuery(
                        "select sum(totalAmount) from PaymentEntity",
                        Double.class
                ).uniqueResult();

        session.close();

        return revenue == null ? 0 : revenue;
    }
    public List<RoomEntity> getCurrentCustomers() {

        Session session =
                HibernateUtil.getSessionFactory().openSession();

        List<RoomEntity> list =
                session.createQuery(
                        "from RoomEntity where username is not null",
                        RoomEntity.class
                ).list();

        session.close();

        return list;
    }

    public double getOccupancyPercentage() {

        long total =
                getTotalRooms();

        long booked =
                getBookedRoomsCount();

        if(total == 0) {
            return 0;
        }

        return (booked * 100.0) / total;
    }
}
