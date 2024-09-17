package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.math.BigDecimal;
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

import com.crimsonlogic.groceriessubbookingsystem.entity.Payments;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	private static final Logger LOG = LoggerFactory.getLogger(PaymentController.class);

	// display the payment page
	@GetMapping
	public String paymentPage(@RequestParam("totalAmount") BigDecimal totalAmount, Model model) {
		LOG.debug("inside show payment handler method");
		model.addAttribute("totalAmount", totalAmount);
		return "payment";
	}

	// save the payment details
	@PostMapping("/complete")
	public String completePayment(@ModelAttribute Payments payment, HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("user");

		// Get cart items and check their type
		List<?> cart = (List<?>) session.getAttribute("cart");

		if (cart == null || cart.isEmpty()) {
			model.addAttribute("message", "No items in the cart");
			return "payment";
		}

		// Save payment details and orders/subscriptions
		paymentService.savePaymentAndOrders(payment, user, cart);

		// Clear the cart from the session
		session.removeAttribute("cart");

		model.addAttribute("message", "Payment completed successfully");
		return "paymentConfirmation";
	}

	// display the payment history based on user_id
	@GetMapping("/history")
	public String paymentHistory(HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("user");
		if (user == null) {
			model.addAttribute("message", "User not found in session");
			return "payment";
		}

		List<Payments> paymentHistory = paymentService.findPaymentsByUserId(user.getUser_id());
		model.addAttribute("paymentHistory", paymentHistory);
		return "paymentHistory";
	}
}
