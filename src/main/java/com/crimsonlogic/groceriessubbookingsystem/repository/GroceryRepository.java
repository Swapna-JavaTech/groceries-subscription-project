package com.crimsonlogic.groceriessubbookingsystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;

public interface GroceryRepository extends JpaRepository<Groceries, String> {

}
