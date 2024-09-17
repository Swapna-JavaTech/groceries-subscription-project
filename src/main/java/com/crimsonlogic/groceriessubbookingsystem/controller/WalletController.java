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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.entity.Wallet;
import com.crimsonlogic.groceriessubbookingsystem.entity.WalletTransaction;
import com.crimsonlogic.groceriessubbookingsystem.service.WalletService;

@Controller
@RequestMapping("/wallets")
public class WalletController {

	@Autowired
	private WalletService walletService;

	private static final Logger LOG = LoggerFactory.getLogger(SubscriptionController.class);

	// Display wallet balance and transaction history
	@GetMapping("/wallet")
	public String displayWallet(Model model, HttpSession session) {
		LOG.debug("inside show wallet handler method");
		Users user = (Users) session.getAttribute("user");
		Wallet wallet = walletService.getOrCreateWalletByUserId(user.getUser_id());

		if (wallet == null) {
			model.addAttribute("error", "Wallet not found for user.");
			return "error"; // Or handle it according to your error page
		}

		List<WalletTransaction> transactions = walletService.getWalletTransactions(wallet.getWalletId());

		model.addAttribute("wallet", wallet);
		model.addAttribute("transactions", transactions);

		return "wallet"; // JSP page name
	}

	// Recharge wallet
	@PostMapping("/recharge")
	public String rechargeWallet(@RequestParam("amount") BigDecimal amount, Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("user");
		walletService.rechargeWallet(user.getUser_id(), amount);

		return "redirect:/wallets/wallet"; // Redirect to wallet page after recharge
	}
}