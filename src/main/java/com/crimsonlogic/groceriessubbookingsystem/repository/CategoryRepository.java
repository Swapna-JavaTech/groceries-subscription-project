package com.crimsonlogic.groceriessubbookingsystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.crimsonlogic.groceriessubbookingsystem.entity.Category;

public interface CategoryRepository extends JpaRepository<Category, String> {

}
