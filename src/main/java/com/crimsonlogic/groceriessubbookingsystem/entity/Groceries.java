package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "Groceries")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the Grocery table
 * 
 * @version 1.1
 */
public class Groceries {
	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "GRC"))
	private String grocery_id;

	@Column(name = "grocery_name")
	private String groceryName;

	private String description;

	@Column(nullable = false)
	private BigDecimal grocery_price;

	private String imageURL;

	private int in_stock;

	@ManyToOne
	@ToString.Exclude
	@JoinColumn(name = "category_id", foreignKey = @ForeignKey(name = "FK_Category"))
	private Category category;

	@OneToMany(mappedBy = "groceries")
	@ToString.Exclude
	private List<Subscription> subscription; // Updated to one-to-one relationship

	@OneToMany(mappedBy = "grocery")
	@ToString.Exclude
	private List<Order> orders; // Updated to reference multiple orders

	public Groceries(String grocery_id) {
		super();
		this.grocery_id = grocery_id;
	}
}
