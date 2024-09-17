package com.crimsonlogic.groceriessubbookingsystem.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.entity.Order;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.entity.Wallet;
import com.crimsonlogic.groceriessubbookingsystem.repository.OrderRepository;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private GroceriesService groceryService;

	@Autowired
	private UserService userService;

	@Autowired
	private WalletService walletService;

	// list of orders
	@Override
	public List<Order> getAllOrders() {
		return orderRepository.findAll();
	}

	// get the order by id as optional class
	@Override
	public Optional<Order> getOrderById(String orderId) {
		return orderRepository.findById(orderId);
	}

	// get order by id
	public Order getOrdersById(String orderId) {
		return orderRepository.findById(orderId).orElse(null);
	}

	// save order
	@Override
	public Order saveOrder(Order order) {
		return orderRepository.save(order);
	}

	// Fetch orders by a specific user ID
	public List<Order> getOrdersByUserId(String userId) {
		return orderRepository.findOrdersByUserId(userId);
	}

	// updating the order status
	@Transactional
	public void updateOrderStatus(String orderId, Order.OrderStatus status) {
		Order order = orderRepository.findById(orderId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid order ID"));
		order.setOrderStatus(status);
		orderRepository.save(order);
	}

	// calculating the total amount in the cart
	public BigDecimal calculateTotalAmount(List<Order> cart) {
		BigDecimal totalAmount = BigDecimal.ZERO;
		if (cart != null) {
			for (Order order : cart) {
				totalAmount = totalAmount.add(order.getTotalAmount());
			}
		}
		return totalAmount;
	}

	// calculating the total amount
	public BigDecimal calculateOrderTotalAmount(Order order) {
		return order.getGrocery().getGrocery_price().multiply(BigDecimal.valueOf(order.getQuantity()));
	}

	// creating the order
	public Order createOrder(String groceryId, int quantity, String userId) {
		Groceries grocery = groceryService.getGroceryById(groceryId);
		Users user = userService.getUsersById(userId);

		Order order = new Order();
		order.setGrocery(grocery);
		order.setUsers(user);
		order.setQuantity(quantity);
		order.setTotalAmount(calculateOrderTotalAmount(order));
		order.setOrderStatus(Order.OrderStatus.Processed);
		order.setOrder_date(Timestamp.from(Instant.now()));

		return order;
	}

	// increasing the quantity of the item
	public void increaseOrderQuantity(List<Order> cart, int index) {
		if (cart != null && index >= 0 && index < cart.size()) {
			Order order = cart.get(index);
			order.setQuantity(order.getQuantity() + 1);
			order.setTotalAmount(calculateOrderTotalAmount(order));
		}
	}

	// decreasing the order of the item
	public void decreaseOrderQuantity(List<Order> cart, int index) {
		if (cart != null && index >= 0 && index < cart.size()) {
			Order order = cart.get(index);
			if (order.getQuantity() > 1) {
				order.setQuantity(order.getQuantity() - 1);
				order.setTotalAmount(calculateOrderTotalAmount(order));
			} else {
				cart.remove(index);
			}
		}
	}

	// redirecting to wallet page
	@Transactional
	public String checkoutOrder(List<Order> cart, Users user) {
		if (cart == null || cart.isEmpty()) {
			return "No items in the cart";
		}

		// Calculate the total amount
		BigDecimal totalAmount = calculateTotalAmount(cart);

		// Get the wallet information
		Wallet wallet = walletService.getOrCreateWalletByUserId(user.getUser_id());

		// Check if the wallet balance is sufficient
		if (wallet.getBalance().compareTo(totalAmount) < 0) {
			return "Insufficient wallet balance. Please recharge your wallet.";
		}

		// Deduct the total amount from the wallet
		walletService.debitWallet(user.getUser_id(), totalAmount);

		// Save the orders
		for (Order order : cart) {
			orderRepository.save(order);
		}

		// Return a success message
		return "Order successful!";
	}
}
