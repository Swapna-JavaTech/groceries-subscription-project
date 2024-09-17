package com.crimsonlogic.groceriessubbookingsystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.crimsonlogic.groceriessubbookingsystem.entity.Wallet;

public interface WalletRepository extends JpaRepository<Wallet, String> {

	@Query("SELECT o FROM Wallet o WHERE o.user.user_id = :userId")
	Wallet findWalletByUserId(@Param("userId") String userId);

}
