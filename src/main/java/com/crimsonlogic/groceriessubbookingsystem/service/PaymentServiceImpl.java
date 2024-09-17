package com.crimsonlogic.groceriessubbookingsystem.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crimsonlogic.groceriessubbookingsystem.entity.Order;
import com.crimsonlogic.groceriessubbookingsystem.entity.Payments;
import com.crimsonlogic.groceriessubbookingsystem.entity.Subscription;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.repository.OrderRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.PaymentRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.SubscriptionRepository;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentRepository paymentRepository;

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private SubscriptionRepository subscriptionRepository;

	// save payment
	@Override
	public void savePayment(Payments payment) {
		paymentRepository.save(payment);
	}

	// list of payments by user id
	public List<Payments> findPaymentsByUserId(String userId) {
		return paymentRepository.findPaymentsByUserId(userId);
	}

	// save payment details of order and subscription
	public void savePaymentAndOrders(Payments payment, Users user, List<?> cart) {
		// Save the payment details
		payment.setPayment_date(LocalDate.now());
		payment.setUser(user);
		paymentRepository.save(payment);

		// Save the orders to the database
		if (cart.isEmpty())
			return;

		if (cart.get(0) instanceof Order) {
			for (Object item : cart) {
				Order order = (Order) item;
				order.setUsers(user);
				orderRepository.save(order);
			}
		} else if (cart.get(0) instanceof Subscription) {
			for (Object item : cart) {
				Subscription subscription = (Subscription) item;
				subscription.setUser(user);
				subscriptionRepository.save(subscription);
			}
		}
	}
}
