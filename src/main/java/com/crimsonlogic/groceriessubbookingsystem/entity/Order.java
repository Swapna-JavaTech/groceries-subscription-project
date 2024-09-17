package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "Orders")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the Order table
 * 
 * @version 1.1
 */
public class Order {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "ORDNO"))
	private String order_id;

	@ManyToOne
	@JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_USER"))
	private Users users;

	private int quantity;

	@ManyToOne
	@ToString.Exclude
	@JoinColumn(name = "grocery_id", foreignKey = @ForeignKey(name = "FK_Grocery"))
	private Groceries grocery;

	@Column(nullable = false)
	private BigDecimal totalAmount;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private OrderStatus orderStatus;

	@Column(name = "order_date")
	private Timestamp order_date;

	public enum OrderStatus {
		Pending, Processed, Shipped, Delivered, Cancelled
	}
}
