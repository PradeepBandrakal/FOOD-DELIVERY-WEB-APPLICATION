package com.foodapp.model;

public class CartItem {

    private MenuItem menuItem;

    private int quantity;

    // Default Constructor
    public CartItem() {

    }

    // Parameterized Constructor
    public CartItem(MenuItem menuItem, int quantity) {

        this.menuItem = menuItem;
        this.quantity = quantity;
    }

    // Getters and Setters

    public MenuItem getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Calculate Total Price
    public double getTotalPrice() {

        return menuItem.getPrice() * quantity;
    }
}