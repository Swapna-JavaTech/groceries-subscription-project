package com.crimsonlogic.groceriessubbookingsystem.service;

import com.crimsonlogic.groceriessubbookingsystem.entity.Category;
import com.crimsonlogic.groceriessubbookingsystem.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryRepository categoryRepository;

	// save the category
	@Override
	public Category saveCategory(Category category) {
		return categoryRepository.save(category);
	}

	// get all the categories
	@Override
	public List<Category> getAllCategories() {
		return categoryRepository.findAll();
	}

	// get categories by id as optional class
	@Override
	public Optional<Category> getListCategoryById(String id) {
		return categoryRepository.findById(id);
	}

	// delete the category
	@Override
	public void deleteCategory(String id) {
		categoryRepository.deleteById(id);
	}

	// get category by id
	@Override
	public Category getCategoryById(String id) {
		return categoryRepository.findById(id).orElse(null);
	}
}
