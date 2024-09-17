package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.crimsonlogic.groceriessubbookingsystem.entity.Category;
import com.crimsonlogic.groceriessubbookingsystem.entity.Groceries;
import com.crimsonlogic.groceriessubbookingsystem.service.CategoryService;
import com.crimsonlogic.groceriessubbookingsystem.service.GroceriesService;

@Controller
@RequestMapping("/groceries")
public class GroceriesController {

	@Autowired
	private GroceriesService groceriesService;

	@Autowired
	private CategoryService categoryService;

	private static final Logger LOG = LoggerFactory.getLogger(GroceriesController.class);

	// Display the add grocery item JSP page
	@GetMapping("/add")
	public String showAddForm(Model model) {
		LOG.debug("inside show add-grocery handler method");
		List<Category> categories = categoryService.getAllCategories(); // Fetch all categories
		model.addAttribute("categories", categories);
		return "add-grocery";
	}

	// Load the item details into the database
	@PostMapping("/add")
	public String addGrocery(@RequestParam("imageURL") MultipartFile file,
			@RequestParam("groceryName") String groceryName, @RequestParam("description") String description,
			@RequestParam("grocery_price") BigDecimal groceryPrice, @RequestParam("in_stock") int inStock,
			@RequestParam("category_id") String categoryId, // Changed to String to match entity ID type
			Model model) {

		try {
			if (inStock < 0) {
				model.addAttribute("message", "Stock quantity cannot be negative.");
				return "add-grocery";
			}

			groceriesService.saveGrocery(file, groceryName, description, groceryPrice, inStock, categoryId);
			model.addAttribute("message", "Grocery item added successfully");
		} catch (IllegalArgumentException | IOException e) {
			model.addAttribute("message", e.getMessage());
		}
		return "redirect:/groceries/list";
	}

	// Display the list of groceries
	@GetMapping("/list")
	public String listGroceries(Model model) {
		List<Groceries> groceriesList = groceriesService.getAllGroceries();
		model.addAttribute("groceries", groceriesList);
		return "groceries";
	}

	// Display the editing grocery item form
	@GetMapping("/edit/{id}")
	public String showUpdateForm(@PathVariable("id") String id, Model model) {
		Groceries grocery = groceriesService.getGroceryById(id);
		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("grocery", grocery);
		model.addAttribute("categories", categories);
		return "update-grocery";
	}

	// Update the grocery item
	@PostMapping("/edit")
	public String updateGrocery(@RequestParam("id") String id, @RequestParam("imageURL") MultipartFile file,
			@RequestParam("groceryName") String groceryName, @RequestParam("description") String description,
			@RequestParam("grocery_price") BigDecimal groceryPrice, @RequestParam("in_stock") int inStock,
			@RequestParam("category_id") String categoryId, Model model) {
		try {
			if (inStock < 0) {
				model.addAttribute("message", "Stock quantity cannot be negative.");
				return "update-grocery";
			}

			groceriesService.updateGrocery(id, file, groceryName, description, groceryPrice, inStock, categoryId);
			model.addAttribute("message", "Grocery item updated successfully");
		} catch (IllegalArgumentException e) {
			model.addAttribute("message", e.getMessage());
		} catch (IOException e) {
			model.addAttribute("message", "Failed to upload file: " + file.getOriginalFilename());
		}
		return "redirect:/groceries/list";
	}

}
