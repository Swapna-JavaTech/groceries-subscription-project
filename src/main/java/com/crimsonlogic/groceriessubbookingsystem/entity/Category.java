package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "Category")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the Category table
 * 
 * @version 1.1
 */
public class Category {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "CTG"))
	private String category_id;

	@Column(nullable = false)
	private String category_name;

	@OneToMany(mappedBy = "category")
	@ToString.Exclude
	private List<Groceries> groceries;
}
