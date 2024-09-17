package com.crimsonlogic.groceriessubbookingsystem.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.crimsonlogic.groceriessubbookingsystem.entity.Category;
import com.crimsonlogic.groceriessubbookingsystem.service.CategoryService;

@Controller
@RequestMapping("/categories")
public class CategoryController {

	@Autowired
	private CategoryService categoryService;

	private static final Logger LOG = LoggerFactory.getLogger(CategoryController.class);

	// display the category form
	@GetMapping("/add")
	public String showAddCategoryForm(Model model) {
		LOG.debug("inside show category-form handler method");
		model.addAttribute("category", new Category());
		return "add-category";
	}

	// load the category items
	@PostMapping("/add")
	public String addCategory(Category category, Model model) {
		categoryService.saveCategory(category);
		model.addAttribute("message", "Category added successfully");
		return "redirect:/categories/list"; // Redirect to the list page after successful addition
	}

	// display the list of categories
	@GetMapping("/list")
	public String listCategories(Model model) {
		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("categories", categories);
		return "categories";
	}
}
