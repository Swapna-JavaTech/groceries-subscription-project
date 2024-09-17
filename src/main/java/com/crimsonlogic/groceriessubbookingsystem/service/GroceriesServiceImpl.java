package com.crimsonlogic.groceriessubbookingsystem.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.crimsonlogic.groceriessubbookingsystem.entity.Category;
import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.repository.CategoryRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.GroceryRepository;

@Service
public class GroceriesServiceImpl implements GroceriesService {

	@Autowired
	private GroceryRepository groceriesRepository;

	@Autowired
	private CategoryRepository categoryRepository;

	private static final String UPLOADED_FOLDER = "uploaded/";

	// save grocery
	@Override
	public void saveGrocery(MultipartFile file, String groceryName, String description, BigDecimal groceryPrice,
			int inStock, String categoryId) throws IOException {
		if (file.isEmpty()) {
			throw new IllegalArgumentException("Please select a file to upload");
		}

		// Save the file on the server
		File dir = new File(UPLOADED_FOLDER);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String fileName = file.getOriginalFilename();
		File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
		file.transferTo(serverFile);

		// Retrieve the selected category
		Category category = categoryRepository.findById(categoryId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid category ID"));

		// Create a new grocery item
		Groceries groceries = new Groceries();
		groceries.setGroceryName(groceryName);
		groceries.setDescription(description);
		groceries.setGrocery_price(groceryPrice);
		groceries.setIn_stock(inStock);
		groceries.setImageURL(fileName);
		groceries.setCategory(category); // Set the selected category

		// Save the grocery item to the repository
		groceriesRepository.save(groceries);
	}

	// display the list of groceries
	@Override
	public List<Groceries> getAllGroceries() {
		return groceriesRepository.findAll();
	}

	// get the groceries by id
	@Override
	public Groceries getGroceryById(String groceryId) {
		return groceriesRepository.findById(groceryId).orElse(null);
	}

	// delete the grocery
	@Override
	public void deleteGrocery(String groceryId) {
		groceriesRepository.deleteById(groceryId);
	}

	// update the grocery
	public void updateGrocery(String id, MultipartFile file, String groceryName, String description,
			BigDecimal groceryPrice, int inStock, String categoryId) throws IOException {
		Groceries grocery = groceriesRepository.findById(id)
				.orElseThrow(() -> new IllegalArgumentException("Invalid grocery ID"));

		// file uploading
		if (file != null && !file.isEmpty()) {
			File dir = new File(UPLOADED_FOLDER);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String fileName = file.getOriginalFilename();
			File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
			file.transferTo(serverFile);
			grocery.setImageURL(fileName);
		}

		// save the grocery
		grocery.setGroceryName(groceryName);
		grocery.setDescription(description);
		grocery.setGrocery_price(groceryPrice);
		grocery.setIn_stock(inStock);

		// get the category by id
		Category category = categoryRepository.findById(categoryId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid category ID"));
		grocery.setCategory(category);

		groceriesRepository.save(grocery);
	}

	// update the stock
	public boolean updateStock(String groceryId, int quantityChange) {
		Groceries grocery = groceriesRepository.findById(groceryId).orElse(null);
		if (grocery == null) {
			return false; // Grocery item not found
		}
		int newStock = grocery.getIn_stock() + quantityChange;
		if (newStock < 0) {
			return false; // Not enough stock
		}
		// set the new stock
		grocery.setIn_stock(newStock);
		groceriesRepository.save(grocery);
		return true;
	}
}
