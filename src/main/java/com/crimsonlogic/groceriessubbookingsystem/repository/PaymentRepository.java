package com.crimsonlogic.groceriessubbookingsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.crimsonlogic.groceriessubbookingsystem.entity.Payments;

public interface PaymentRepository extends JpaRepository<Payments, String> {

	@Query("SELECT p FROM Payments p WHERE p.user.user_id = :userId")
	List<Payments> findPaymentsByUserId(@Param("userId") String userId);

}
