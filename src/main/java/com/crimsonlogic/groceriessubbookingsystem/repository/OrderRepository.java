package com.crimsonlogic.groceriessubbookingsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.crimsonlogic.groceriessubbookingsystem.entity.Order;

public interface OrderRepository extends JpaRepository<Order, String> {

	@Query("SELECT o FROM Order o WHERE o.users.user_id = :userId")
	List<Order> findOrdersByUserId(@Param("userId") String userId);

}
