package com.crimsonlogic.groceriessubbookingsystem.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.crimsonlogic.groceriessubbookingsystem.entity.Subscription;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;

public interface SubscriptionService {

	// list of subscriptions
	List<Subscription> getAllSubscription();

	// get subscription by id as optional class
	Optional<Subscription> getSubscriptionById(String subId);

	// list of subscriptions by user id
	List<Subscription> getSubscriptionsByUserId(String userId);

	// update the status
	boolean updateSubscriptionStatus(String subscriptionId, String status);

	// create subscription
	Subscription createSubscription(String groceryId, String userId, int quantity, String frequencyStr,
			String startDateStr, String weekDay, Integer dayOfMonth) throws IOException;

	// Calculate the total amount
	BigDecimal calculateTotalAmount(List<Subscription> cart);

	// reduce the quantity
	void reduceQuantity(int index, List<Subscription> cart);

	// increase the quantity
	void addQuantity(int index, List<Subscription> cart);

	// redirecting to the the wallet
	String checkoutSubscriptions(List<Subscription> cart, Users user);

	// get subscriptions by id
	Subscription getSubscriptionByIds(String id);
	// ByteArrayResource generatePdf(String subscriptionId) throws IOException,
	// DocumentException;
}
