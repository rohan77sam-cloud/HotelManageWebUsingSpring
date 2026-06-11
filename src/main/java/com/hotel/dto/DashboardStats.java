package com.hotel.dto;

public class DashboardStats {

    private long totalRooms;
    private long bookedRooms;
    private long availableRooms;
    private double totalRevenue;

    // getters setters

    public long getTotalRooms() {
        return totalRooms;
    }

    public void setTotalRooms(long totalRooms) {
        this.totalRooms = totalRooms;
    }

    public long getBookedRooms() {
        return bookedRooms;
    }

    public void setBookedRooms(long bookedRooms) {
        this.bookedRooms = bookedRooms;
    }

    public long getAvailableRooms() {
        return availableRooms;
    }

    public void setAvailableRooms(long availableRooms) {
        this.availableRooms = availableRooms;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}