package com.crimsonlogic.groceriessubbookingsystem.service;

import com.crimsonlogic.groceriessubbookingsystem.entity.Order;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface OrderService {
	// display the list of orders
	List<Order> getAllOrders();

	// get the order by id as optional class
	Optional<Order> getOrderById(String orderId);

	// save order
	Order saveOrder(Order order);

	// get the list of orders based on user id
	List<Order> getOrdersByUserId(String userId);

	// updating the order status
	void updateOrderStatus(String orderId, Order.OrderStatus status);

	// calculating the total amount
	BigDecimal calculateTotalAmount(List<Order> cart);

	// calculating the cart total amount
	BigDecimal calculateOrderTotalAmount(Order order);

	// create order
	Order createOrder(String groceryId, int quantity, String userId);

	// decrease quantity
	void decreaseOrderQuantity(List<Order> cart, int index);

	// increase the quantity
	void increaseOrderQuantity(List<Order> cart, int index);

	// get order by id
	Order getOrdersById(String orderId);

	// redirecting to wallet
	String checkoutOrder(List<Order> cart, Users user);
}
