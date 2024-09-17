package com.crimsonlogic.groceriessubbookingsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.crimsonlogic.groceriessubbookingsystem.entity.Subscription;

public interface SubscriptionRepository extends JpaRepository<Subscription, String> {

	@Query("SELECT o FROM Subscription o WHERE o.user.user_id = :userId")
	List<Subscription> findSubscriptionsByUserId(@Param("userId") String userId);
}
