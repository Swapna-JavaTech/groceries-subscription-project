package com.crimsonlogic.groceriessubbookingsystem.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.crimsonlogic.groceriessubbookingsystem.entity.WalletTransaction;

public interface WalletTransactionRepository extends JpaRepository<WalletTransaction, String> {
	List<WalletTransaction> findByWalletWalletId(String walletId);
}