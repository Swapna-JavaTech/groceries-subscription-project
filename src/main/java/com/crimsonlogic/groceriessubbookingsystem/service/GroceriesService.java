package com.crimsonlogic.groceriessubbookingsystem.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;

public interface GroceriesService {
	// display the list of groceries
	List<Groceries> getAllGroceries();

	// get the grocery by id
	Groceries getGroceryById(String groceryId);

	// save the grocery
	void saveGrocery(MultipartFile file, String groceryName, String description, BigDecimal groceryPrice, int inStock,
			String categoryId) throws IOException;

	// delete the grocery
	void deleteGrocery(String groceryId);

	// update the grocery
	void updateGrocery(String id, MultipartFile file, String groceryName, String description, BigDecimal groceryPrice,
			int inStock, String categoryId) throws IOException;

	// update the stock
	boolean updateStock(String groceryId, int quantityChange);
	// Other methods as needed
}
