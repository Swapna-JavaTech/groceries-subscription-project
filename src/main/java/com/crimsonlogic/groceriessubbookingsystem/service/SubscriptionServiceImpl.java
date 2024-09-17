package com.crimsonlogic.groceriessubbookingsystem.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.entity.Subscription;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.entity.Wallet;
import com.crimsonlogic.groceriessubbookingsystem.repository.GroceryRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.SubscriptionRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.UserRepository;

@Service
public class SubscriptionServiceImpl implements SubscriptionService {

	@Autowired
	private SubscriptionRepository subscriptionRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private GroceryRepository groceriesRepository;

	@Autowired
	private WalletService walletService;

	@Override
	public List<Subscription> getAllSubscription() {
		return subscriptionRepository.findAll();
	}

	@Override
	public Optional<Subscription> getSubscriptionById(String subId) {
		return subscriptionRepository.findById(subId);
	}

	@Override
	public List<Subscription> getSubscriptionsByUserId(String userId) {
		return subscriptionRepository.findSubscriptionsByUserId(userId);
	}

	@Override
	@Transactional
	public boolean updateSubscriptionStatus(String subscriptionId, String status) {
		// Fetch the subscription by its ID
		Subscription subscription = subscriptionRepository.findById(subscriptionId).orElse(null);

		if (subscription == null) {
			return false; // Subscription not found
		}

		try {
			// Convert string status to enum and update
			Subscription.SubscriptionStatus newStatus = Subscription.SubscriptionStatus.valueOf(status);

			subscription.setSubStatus(newStatus);
			subscriptionRepository.save(subscription); // Save the updated subscription
			return true;
		} catch (IllegalArgumentException e) {
			return false; // Invalid status value
		}
	}

	@Override
	public Subscription getSubscriptionByIds(String id) {
		return subscriptionRepository.findById(id).orElse(null);
	}

	private int getDayOfWeek(String weekDay) {
		switch (weekDay.toLowerCase()) {
		case "sunday":
			return Calendar.SUNDAY;
		case "monday":
			return Calendar.MONDAY;
		case "tuesday":
			return Calendar.TUESDAY;
		case "wednesday":
			return Calendar.WEDNESDAY;
		case "thursday":
			return Calendar.THURSDAY;
		case "friday":
			return Calendar.FRIDAY;
		case "saturday":
			return Calendar.SATURDAY;
		default:
			throw new IllegalArgumentException("Invalid day of the week: " + weekDay);
		}
	}

	public Subscription createSubscription(String groceryId, String userId, int quantity, String frequencyStr,
			String startDateStr, String weekDay, Integer dayOfMonth) throws IOException {
// Fetch the grocery details
		Groceries grocery = groceriesRepository.findById(groceryId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid grocery ID"));

// Fetch the user details
		Users user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("Invalid user ID"));

// Initialize subscription
		Subscription subscription = new Subscription();
		subscription.setGroceries(grocery);
		subscription.setUser(user);
		subscription.setQuantity(quantity);
		subscription.setAmount(grocery.getGrocery_price().multiply(BigDecimal.valueOf(quantity)));
		subscription.setSubStatus(Subscription.SubscriptionStatus.Processed);

// Set frequency and start date based on input
		Subscription.Frequency frequency;
		try {
			frequency = Subscription.Frequency.valueOf(frequencyStr);
		} catch (IllegalArgumentException e) {
			frequency = Subscription.Frequency.daily; // Default value or handle error
		}
		subscription.setFrequency(frequency);

		Timestamp startTimestamp = null;

// Handle different frequencies
		switch (frequency) {
		case daily:
			if (startDateStr != null && !startDateStr.isEmpty()) {
				LocalDate startDate = LocalDate.parse(startDateStr, DateTimeFormatter.ISO_LOCAL_DATE);
				startTimestamp = Timestamp.from(startDate.atStartOfDay().toInstant(java.time.ZoneOffset.UTC));
			}
			break;
		case weekly:
			if (weekDay != null) {
				Calendar cal = Calendar.getInstance();
				int currentDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
				int targetDayOfWeek = getDayOfWeek(weekDay);
				int daysUntilTargetDay = (targetDayOfWeek - currentDayOfWeek + 7) % 7;
				cal.add(Calendar.DAY_OF_YEAR, daysUntilTargetDay);
				startTimestamp = new Timestamp(cal.getTimeInMillis());
			}
			break;
		case monthly:
			if (dayOfMonth != null) {
				LocalDate today = LocalDate.now();
				LocalDate nextMonth = today.plusMonths(1);
				LocalDate subscriptionDate = nextMonth.withDayOfMonth(dayOfMonth);
				startTimestamp = Timestamp.from(subscriptionDate.atStartOfDay().toInstant(java.time.ZoneOffset.UTC));
			}
			break;
		}

		if (startTimestamp != null) {
			subscription.setStartedAt(startTimestamp);
		}

// Return the prepared subscription object without saving it
		return subscription;
	}

	// calculating the total amount of subscription
	public BigDecimal calculateTotalAmount(List<Subscription> cart) {
		BigDecimal totalAmount = BigDecimal.ZERO;
		if (cart != null) {
		for (Subscription sub : cart) {
			totalAmount = totalAmount.add(sub.getAmount());
		}
		}
		return totalAmount;
	}

	// reducing the quantity
	public void reduceQuantity(int index, List<Subscription> cart) {
		if (cart != null && index >= 0 && index < cart.size()) {
			Subscription subscription = cart.get(index);
			if (subscription.getQuantity() > 1) {
				subscription.setQuantity(subscription.getQuantity() - 1);
				subscription.setAmount(subscription.getGroceries().getGrocery_price()
						.multiply(BigDecimal.valueOf(subscription.getQuantity())));
			} else {
				cart.remove(index);
			}
		}
	}

	// increase the quantity
	public void addQuantity(int index, List<Subscription> cart) {
		if (cart != null && index >= 0 && index < cart.size()) {
			Subscription subscription = cart.get(index);
			subscription.setQuantity(subscription.getQuantity() + 1);
			subscription.setAmount(subscription.getGroceries().getGrocery_price()
					.multiply(BigDecimal.valueOf(subscription.getQuantity())));
		}
	}

	// redirecting to wallet page
	@Transactional
	public String checkoutSubscriptions(List<Subscription> cart, Users user) {
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

		// Save the subscriptions
		for (Subscription subscription : cart) {
			subscriptionRepository.save(subscription);
		}

		// Return a success message
		return "Subscription successful!";
	}

//    //managing download the pdf 
//    public ByteArrayResource generatePdf(String subscriptionId) throws IOException, DocumentException {
//        Optional<Subscription> subscriptionOpt = getSubscriptionById(subscriptionId);
//
//        Subscription subscription = subscriptionOpt.get();
//        Document document = new Document();
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//
//        try {
//            PdfWriter.getInstance(document, baos);
//            document.open();
//            document.add(new Paragraph("Subscription Details"));
//            document.add(new Paragraph("ID: " + subscription.getSubscription_id()));
//            document.add(new Paragraph("Item: " + subscription.getGroceries().getGroceryName())); // Assuming getName() method exists in Groceries
//            document.add(new Paragraph("Frequency: " + subscription.getFrequency()));
//            document.add(new Paragraph("Amount: " + subscription.getAmount()));
//            document.add(new Paragraph("Quantity: " + subscription.getQuantity()));
//            document.add(new Paragraph("Status: " + subscription.getSubStatus()));
//            document.add(new Paragraph("Started At: " + subscription.getStartedAt()));
//        } catch (DocumentException e) {
//            throw new IOException("Error generating PDF", e);
//        } finally {
//            document.close();
//        }
//
//        return new ByteArrayResource(baos.toByteArray());
//    }
}
