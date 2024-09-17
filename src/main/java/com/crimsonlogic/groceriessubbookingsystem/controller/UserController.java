package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.util.Optional;

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

import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.service.UserService;

@Controller
@RequestMapping("/users")
public class UserController {

	@Autowired
	private UserService userService;

	private static final Logger LOG = LoggerFactory.getLogger(SubscriptionController.class);

	// Display the registration page
	@GetMapping("/register")
	public String showSignUpForm(Model model) {
		LOG.debug("inside show registration handler method");
		model.addAttribute("user", new Users());
		return "signup";
	}

	// Load the user details into the database
	@PostMapping("/signup")
	public String registerUser(@ModelAttribute("user") Users user, Model model) {
		userService.registerUser(user);
		model.addAttribute("message", "User registered successfully!");
		return "login";
	}

	// Display the login page
	@GetMapping("/login")
	public String showLoginForm(Model model) {
		model.addAttribute("user", new Users());
		return "login";
	}

	// Handle login
	@PostMapping("/login")
	public String loginUser(@ModelAttribute("user") Users user, Model model, HttpSession session) {
		Optional<Users> loggedInUser = userService.loginUser(user.getUserEmail(), user.getUserPassword());
		if (loggedInUser.isPresent()) {
			Users loggedIn = loggedInUser.get();
			session.setAttribute("userRole", loggedIn.getUserRole());
			session.setAttribute("user", loggedIn);
			if ("seller".equalsIgnoreCase(loggedIn.getUserRole())) {
				return "seller";
			} else if ("customer".equalsIgnoreCase(loggedIn.getUserRole())) {
				return "customer";
			} else {
				model.addAttribute("error", "Unknown user role");
				return "login";
			}
		} else {
			model.addAttribute("error", "Invalid email or password");
			return "login";
		}
	}

	// Display the profile
	@GetMapping("/profile")
	public String showProfileForm(@RequestParam("user_id") String userId, Model model) {
		Optional<Users> user = userService.getUserById(userId);
		if (user.isPresent()) {
			model.addAttribute("user", user.get());
			return "profile";
		} else {
			model.addAttribute("error", "User not found");
			return "error";
		}
	}

	// Update user profile
	@PostMapping("/profile")
	public String updateUser(@ModelAttribute("user") Users user, Model model) {
		Optional<Users> existingUser = userService.getUserById(user.getUser_id());
		if (existingUser.isPresent()) {
			userService.updateUser(user.getUser_id(), user);
			model.addAttribute("message", "Profile updated successfully!");
			model.addAttribute("user", user);
			return "profile";
		} else {
			model.addAttribute("error", "User not found");
			return "error";
		}
	}

	// Display the forgot password page
	@GetMapping("/forgot-password")
	public String showForgotPasswordForm() {
		return "forgotPassword";
	}

	// Handle password reset request
	@PostMapping("/forgot-password")
	public String handleForgotPassword(@RequestParam("email") String email, Model model) {
		String token = userService.generatePasswordResetToken(email);
		if (token != null) {
			// Construct the reset password URL
			String resetPasswordUrl = "http://localhost:8080/GroceriesSubBookingSystem/users/reset-password?token="
					+ token;
			model.addAttribute("message", "Password reset link has been sent to your email address.");
			model.addAttribute("resetPasswordUrl", resetPasswordUrl);
			model.addAttribute("token", token);
		} else {
			model.addAttribute("error", "No user found with this email address.");
		}
		return "forgotPassword";
	}

	// Display the reset password page
	@GetMapping("/reset-password")
	public String showResetPasswordForm(@RequestParam("token") String token, Model model) {
		if (userService.validatePasswordResetToken(token)) {
			model.addAttribute("token", token);
			return "resetPassword";
		} else {
			model.addAttribute("error", "Invalid or expired reset token.");
			return "error";
		}
	}

	// Handle password reset
	@PostMapping("/reset-password")
	public String handleResetPassword(@RequestParam("token") String token,
			@RequestParam("newPassword") String newPassword, Model model) {
		if (userService.resetPassword(token, newPassword)) {
			model.addAttribute("message", "Password has been successfully reset.");
			return "login";
		} else {
			model.addAttribute("error", "Failed to reset password.");
			return "error";
		}
	}
}
