package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.entity.Order;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.service.GroceriesService;
import com.crimsonlogic.groceriessubbookingsystem.service.OrderService;

@Controller
@RequestMapping("/orders")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private GroceriesService groceryService;

	private static final Logger LOG = LoggerFactory.getLogger(OrderController.class);

	// View the orders based on the role
	@GetMapping("/viewOrders")
	public String viewOrders(HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("user");
		List<Order> orders;
		if (user != null && "Seller".equals(user.getUserRole())) {
			orders = orderService.getAllOrders();
		} else {
			orders = orderService.getOrdersByUserId(user.getUser_id());
		}
		model.addAttribute("orders", orders);
		model.addAttribute("userId", user != null ? user.getUser_id() : null);
		return "orderList";
	}

	// Updating the status
	@PostMapping("/updateStatus")
	public String updateOrderStatus(@RequestParam("order_id") String orderId,
			@RequestParam("orderStatus") String status, HttpSession session, Model model) {
		Order.OrderStatus orderStatus;
		try {
			orderStatus = Order.OrderStatus.valueOf(status);
		} catch (IllegalArgumentException e) {
			model.addAttribute("message", "Invalid status");
			return "orderList";
		}

		orderService.updateOrderStatus(orderId, orderStatus);

		Users user = (Users) session.getAttribute("user");
		List<Order> orders;
		if ("Seller".equals(user.getUserRole())) {
			orders = orderService.getAllOrders();
		} else {
			orders = orderService.getOrdersByUserId(user.getUser_id());
		}
		model.addAttribute("orders", orders);
		model.addAttribute("message", "Order status updated successfully");
		model.addAttribute("updateSuccess", true);

		return "orderList";
	}

	// View the order details and grocery details based on grocery id
	@GetMapping("/order")
	public String getOrder(@RequestParam("groceryId") String groceryId, Model model) {
		LOG.debug("inside show order-details handler method");
		Groceries grocery = groceryService.getGroceryById(groceryId);
		model.addAttribute("grocery", grocery);
		return "order-details";
	}

	// Post the order details and grocery details into cart
	@PostMapping("/submit")
	public String submitOrder(@ModelAttribute Order order, @RequestParam("grocery_id") String groceryId,
			@RequestParam("quantity") int quantity, @RequestParam("user_id") String userId, HttpSession session,
			Model model) throws IOException {
		// Validate stock before creating the order
		if (!groceryService.updateStock(groceryId, -quantity)) {
			model.addAttribute("message", "Insufficient stock for the requested quantity.");
			return "order-details";
		}

		Order newOrder = orderService.createOrder(groceryId, quantity, userId);

		session.setAttribute("orderId", newOrder);

		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");
		if (cart == null) {
			cart = new ArrayList<>();
		}
		cart.add(newOrder);
		session.setAttribute("cart", cart);

		BigDecimal totalAmount = orderService.calculateTotalAmount(cart);

		model.addAttribute("cart", cart);
		model.addAttribute("totalAmount", totalAmount);

		return "addToCart";
	}

	// Increase the item quantity
	@PostMapping("/addQuantity")
	public String addQuantity(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");

		if (cart != null && index >= 0 && index < cart.size()) {
			Order order = cart.get(index);
			if (!groceryService.updateStock(order.getGrocery().getGrocery_id(), -1)) {
				model.addAttribute("message", "Insufficient stock to increase quantity.");
				return "redirect:/orders/cart";
			}
			orderService.increaseOrderQuantity(cart, index);
			session.setAttribute("cart", cart);

			BigDecimal totalAmount = orderService.calculateTotalAmount(cart);
			model.addAttribute("totalAmount", totalAmount);
		}

		return "redirect:/orders/cart";
	}

	// Reduce the item quantity
	@PostMapping("/reduceQuantity")
	public String reduceQuantity(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");

		if (cart != null && index >= 0 && index < cart.size()) {
			Order order = cart.get(index);
			if (!groceryService.updateStock(order.getGrocery().getGrocery_id(), 1)) {
				model.addAttribute("message", "Failed to update stock after reducing quantity.");
				return "redirect:/orders/cart";
			}
			orderService.decreaseOrderQuantity(cart, index);
			session.setAttribute("cart", cart);

			BigDecimal totalAmount = orderService.calculateTotalAmount(cart);
			model.addAttribute("totalAmount", totalAmount);
		}

		return "redirect:/orders/cart";
	}

	// Remove item from the cart
	@PostMapping("/remove")
	public String removeFromCart(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");

		if (cart != null && index >= 0 && index < cart.size()) {
			Order order = cart.remove(index);
			if (order != null) {
				groceryService.updateStock(order.getGrocery().getGrocery_id(), order.getQuantity()); // Re-add stock
			}
			session.setAttribute("cart", cart);

			BigDecimal totalAmount = orderService.calculateTotalAmount(cart);
			model.addAttribute("totalAmount", totalAmount);
		}

		return "redirect:/orders/cart";
	}

	// Display the cart list
	@GetMapping("/cart")
	public String viewCart(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");

		BigDecimal totalAmount = orderService.calculateTotalAmount(cart);

		model.addAttribute("cart", cart);
		model.addAttribute("totalAmount", totalAmount);

		return "addToCart";
	}

	// Redirect to the payment page
	@GetMapping("/checkout")
	public String checkout(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");
		if (cart == null || cart.isEmpty()) {
			model.addAttribute("message", "No items in the cart");
			return "addToCart";
		}

		BigDecimal totalAmount = orderService.calculateTotalAmount(cart);

		session.setAttribute("cart", cart);
		session.setAttribute("totalAmount", totalAmount);

		return "redirect:/payment?totalAmount=" + totalAmount;
	}

	// Redirecting to the wallet page
	@GetMapping("/walletcheckout")
	public String checkoutOrder(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Order> cart = (List<Order>) session.getAttribute("cart");
		Users user = (Users) session.getAttribute("user");

		String result = orderService.checkoutOrder(cart, user);

		if (result.equals("No items in the cart") || result.contains("Insufficient wallet balance")) {
			model.addAttribute("message", result);
			return "addToCart";
		}

		// Clear the subscription cart
		session.removeAttribute("cart");

		// Redirect to the payment success page
		model.addAttribute("message", result);
		return "paymentConfirmation";
	}

	// Display the invoice details
	@GetMapping("/invoice")
	public String getInvoiceDetails(@RequestParam("orderId") String orderId, Model model) {
		Order order = orderService.getOrdersById(orderId);
		if (order != null) {
			model.addAttribute("order", order);
			return "invoicePage";
		} else {
			model.addAttribute("message", "Order not found.");
			return "errorPage";
		}
	}
}
