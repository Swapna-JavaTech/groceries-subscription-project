package com.crimsonlogic.groceriessubbookingsystem.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.entity.Wallet;
import com.crimsonlogic.groceriessubbookingsystem.entity.WalletTransaction;
import com.crimsonlogic.groceriessubbookingsystem.repository.UserRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.WalletRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.WalletTransactionRepository;

@Service
public class WalletService {

	@Autowired
	private WalletRepository walletRepository;

	@Autowired
	private WalletTransactionRepository walletTransactionRepository;

	@Autowired
	private UserRepository userRepository;

	// Get or Create Wallet by User ID
	public Wallet getOrCreateWalletByUserId(String userId) {
		Wallet wallet = walletRepository.findWalletByUserId(userId);
		if (wallet == null) {
			// Create a new wallet for the user if it doesn't exist
			wallet = new Wallet();
			Users user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
			wallet.setUser(user);
			wallet.setBalance(BigDecimal.ZERO);
			wallet = walletRepository.save(wallet); // Save the newly created wallet
		}
		return wallet;
	}

	// Add money to the wallet (Recharge)
	public Wallet rechargeWallet(String userId, BigDecimal amount) {
		Wallet wallet = getOrCreateWalletByUserId(userId);
		wallet.setBalance(wallet.getBalance().add(amount));

		// Save the transaction
		WalletTransaction transaction = new WalletTransaction();
		transaction.setWallet(wallet);
		transaction.setAmount(amount);
		transaction.setTransactionDate(new Date());
		transaction.setTransactionType("RECHARGE");

		walletTransactionRepository.save(transaction);
		return walletRepository.save(wallet);
	}

	// Deduct money from the wallet (Debit)
	public Wallet debitWallet(String userId, BigDecimal amount) {
		Wallet wallet = getOrCreateWalletByUserId(userId);
		wallet.setBalance(wallet.getBalance().subtract(amount));

		// Save the transaction
		WalletTransaction transaction = new WalletTransaction();
		transaction.setWallet(wallet);
		transaction.setAmount(amount.negate()); // Store as negative amount
		transaction.setTransactionDate(new Date());
		transaction.setTransactionType("DEBIT");

		walletTransactionRepository.save(transaction);
		return walletRepository.save(wallet);
	}

	// Get wallet transaction history
	public List<WalletTransaction> getWalletTransactions(String walletId) {
		return walletTransactionRepository.findByWalletWalletId(walletId);
	}

	// Cancelled amount
	@Transactional
	public boolean creditWalletForCancelledSubscription(String userId, BigDecimal amount) {
		try {
			Wallet wallet = getOrCreateWalletByUserId(userId);
			wallet.setBalance(wallet.getBalance().add(amount));

			// Save the transaction
			WalletTransaction transaction = new WalletTransaction();
			transaction.setWallet(wallet);
			transaction.setAmount(amount); // Store as positive amount
			transaction.setTransactionDate(new Date());
			transaction.setTransactionType("CREDIT");

			walletTransactionRepository.save(transaction);
			walletRepository.save(wallet);
			return true;
		} catch (Exception e) {
			// Log and handle exceptions
			e.printStackTrace();
			return false;
		}
	}
}
