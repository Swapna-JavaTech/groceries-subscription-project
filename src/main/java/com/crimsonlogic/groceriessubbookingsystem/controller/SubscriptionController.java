package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.entity.Subscription;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.repository.SubscriptionRepository;
import com.crimsonlogic.groceriessubbookingsystem.service.GroceriesService;
import com.crimsonlogic.groceriessubbookingsystem.service.SubscriptionService;
import com.crimsonlogic.groceriessubbookingsystem.service.WalletService;

@Controller
@RequestMapping("/subscription")
public class SubscriptionController {

	@Autowired
	private SubscriptionService subscriptionService;

	@Autowired
	private GroceriesService groceryService;

	@Autowired
	private SubscriptionRepository subscriptionRepository;

	@Autowired
	private WalletService walletService;

	private static final Logger LOG = LoggerFactory.getLogger(SubscriptionController.class);

	// Displaying the subscription and grocery details
	@GetMapping("/sub")
	public String getSubscriptionDetails(@RequestParam("groceryId") String groceryId, Model model) {
		LOG.debug("inside show subscription-details handler method");
		Groceries grocery = groceryService.getGroceryById(groceryId);
		model.addAttribute("grocery", grocery);
		return "subscription-details";
	}

	// Load the grocery details and subscription details
	@PostMapping("/submit")
	public String submitSubscription(@RequestParam("grocery_id") String groceryId,
			@RequestParam("quantity") int quantity, @RequestParam("user_id") String userId,
			@RequestParam("frequency") String frequencyStr,
			@RequestParam(value = "startDate", required = false) String startDateStr,
			@RequestParam(value = "weekDay", required = false) String weekDay,
			@RequestParam(value = "dayOfMonth", required = false) Integer dayOfMonth, HttpSession session,
			Model model) {

		try {
			// Validate stock availability
			if (!groceryService.updateStock(groceryId, -quantity)) {
				model.addAttribute("message", "Insufficient stock for the requested quantity.");
				return "subscription-details";
			}

			// Create a subscription
			Subscription subscription = subscriptionService.createSubscription(groceryId, userId, quantity,
					frequencyStr, startDateStr, weekDay, dayOfMonth);

			// Get the subscription cart from the session
			@SuppressWarnings("unchecked")
			List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");
			if (cart == null) {
				cart = new ArrayList<>();
			}

			// Add the subscription to the cart
			cart.add(subscription);
			session.setAttribute("subCart", cart);

			// Calculate the total amount of all items in the cart
			BigDecimal totalAmount = subscriptionService.calculateTotalAmount(cart);

			// Add cart and total amount to the model to display in the view
			model.addAttribute("subCart", cart);
			model.addAttribute("subTotalAmount", totalAmount);

			return "subCart";
		} catch (IOException e) {
			model.addAttribute("message", "Error creating subscription: " + e.getMessage());
			return "errorPage";
		}
	}

	// Display the subscription cart details
	@GetMapping("/subcart")
	public String viewCart(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");

		// Calculate total amount using SubscriptionService
		BigDecimal totalAmount = subscriptionService.calculateTotalAmount(cart);

		model.addAttribute("cart", cart);
		model.addAttribute("subTotalAmount", totalAmount);

		return "subCart";
	}

	// Remove the subscription item
	@PostMapping("/subremove")
	public String removeFromCart(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");
		if (cart != null && index >= 0 && index < cart.size()) {
			Subscription subscription = cart.remove(index);

			// Restore stock of the removed subscription item
			if (subscription != null) {
				groceryService.updateStock(subscription.getGroceries().getGrocery_id(), subscription.getQuantity());
			}

			session.setAttribute("subCart", cart);
		}
		return "redirect:/subscription/subcart";
	}

	// Increase the quantity of subscription item
	@PostMapping("/addquantity")
	public String addQuantity(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");

		if (cart != null && index >= 0 && index < cart.size()) {
			Subscription subscription = cart.get(index);

			// Check if stock is available before increasing quantity
			if (!groceryService.updateStock(subscription.getGroceries().getGrocery_id(), -1)) {
				model.addAttribute("message", "Insufficient stock to increase quantity.");
				return "redirect:/subscription/subcart";
			}

			subscriptionService.addQuantity(index, cart);
			session.setAttribute("subCart", cart);

			// Calculate the total amount after addition
			BigDecimal totalAmount = subscriptionService.calculateTotalAmount(cart);
			model.addAttribute("subCart", cart);
			model.addAttribute("subTotalAmount", totalAmount);
		}

		return "redirect:/subscription/subcart";
	}

	// Decrease the quantity of subscription item
	@PostMapping("/reducequantity")
	public String reduceQuantity(@RequestParam("index") int index, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");

		if (cart != null && index >= 0 && index < cart.size()) {
			Subscription subscription = cart.get(index);

			subscriptionService.reduceQuantity(index, cart);

			// Restore stock when decreasing quantity
			groceryService.updateStock(subscription.getGroceries().getGrocery_id(), 1);
			session.setAttribute("subCart", cart);

			// Calculate the total amount after reduction
			BigDecimal totalAmount = subscriptionService.calculateTotalAmount(cart);
			model.addAttribute("subCart", cart);
			model.addAttribute("subTotalAmount", totalAmount);
		}

		return "redirect:/subscription/subcart";
	}

	// Redirecting to the payment page
	@GetMapping("/subcheckout")
	public String checkout(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<Subscription> cart = (List<Subscription>) session.getAttribute("subCart");
		Users user = (Users) session.getAttribute("user");

		String result = subscriptionService.checkoutSubscriptions(cart, user);

		if (result.equals("No items in the cart") || result.contains("Insufficient wallet balance")) {
			model.addAttribute("message", result);
			return "subCart";
		}

		// Clear the subscription cart
		session.removeAttribute("subCart");

		// Redirect to the payment success page
		model.addAttribute("message", result);
		return "subscriptionSuccess";
	}

	// Display the calendar page
	@GetMapping("/subscriptionlist")
	public String viewSubscriptions(Model model, HttpSession session) {
		return "calander";
	}

	// Loading the subscription details into the calendar
	@GetMapping("/api/subscriptions")
	@ResponseBody
	public List<Map<String, Object>> getSubscriptions(HttpSession session) {
		Users user = (Users) session.getAttribute("user");
		List<Subscription> subscriptions = subscriptionService.getSubscriptionsByUserId(user.getUser_id());
		List<Map<String, Object>> events = new ArrayList<>();

		for (Subscription subscription : subscriptions) {
			Map<String, Object> event = new HashMap<>();
			event.put("id", subscription.getSubscription_id()); // Include event ID
			event.put("title", subscription.getGroceries().getGroceryName());
			event.put("start", subscription.getStartedAt().toInstant().toString()); // Convert Timestamp to ISO 8601
																					// string
			event.put("frequency", subscription.getFrequency().toString());
			event.put("amount", subscription.getAmount().toString());
			event.put("quantity", subscription.getQuantity());
			event.put("status", subscription.getSubStatus().toString());
			events.add(event);
		}

		return events;
	}

	// Calendar status updating
	@PostMapping("/update-status")
	@ResponseBody
	public Map<String, Object> updateSubscriptionStatus(@RequestParam("eventId") String id,
			@RequestParam("status") String status, HttpSession session) {

		Map<String, Object> response = new HashMap<>();
		Users user = (Users) session.getAttribute("user");

		if (status == null || status.isEmpty()) {
			response.put("success", false);
			response.put("message", "Status is required");
			return response;
		}

		boolean success = subscriptionService.updateSubscriptionStatus(id, status);

		if (success) {
			// If the status is "Cancelled", credit the wallet
			if ("Cancelled".equalsIgnoreCase(status)) {
				Subscription subscription = subscriptionRepository.findById(id).orElse(null);
				if (subscription != null) {
					BigDecimal cancelledAmount = subscription.getAmount();
					boolean credited = walletService.creditWalletForCancelledSubscription(user.getUser_id(),
							cancelledAmount);
					if (credited) {
						response.put("success", true);
						response.put("message", "Subscription status updated and wallet credited successfully.");
					} else {
						response.put("success", false);
						response.put("message", "Subscription status updated but failed to credit wallet.");
					}
				} else {
					response.put("success", false);
					response.put("message", "Subscription not found.");
				}
			} else {
				response.put("success", true);
				response.put("message", "Subscription status updated successfully.");
			}
		} else {
			response.put("success", false);
			response.put("message", "Failed to update status.");
		}

		return response;
	}

	// Method to display all subscriptions
	@GetMapping("/allsubscriptions")
	public String viewAllSubscriptions(Model model) {
		List<Subscription> subscriptions = subscriptionService.getAllSubscription();
		model.addAttribute("subscriptions", subscriptions);
		return "sub-list";
	}

	// seller status updating
	@PostMapping("/updateStatus")
	public String updatedSubscriptionStatus(@RequestParam("subscriptionId") String subscriptionId,
			@RequestParam("subStatus") String subStatus, RedirectAttributes redirectAttributes) {
		boolean success = subscriptionService.updateSubscriptionStatus(subscriptionId, subStatus);

		if (success) {
			redirectAttributes.addFlashAttribute("updateSuccess", true);
		} else {
			redirectAttributes.addFlashAttribute("updateSuccess", false);
		}

		return "redirect:/subscription/allsubscriptions"; // Redirect back to the page with the updated list
	}
}
