package com.crimsonlogic.groceriessubbookingsystem.service;

import java.util.List;

import com.crimsonlogic.groceriessubbookingsystem.entity.Payments;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;

public interface PaymentService {
	// save payment
	void savePayment(Payments payment);

	// list of payments
	List<Payments> findPaymentsByUserId(String userId);

	// save payment and orders
	void savePaymentAndOrders(Payments payment, Users user, List<?> cart);
}
