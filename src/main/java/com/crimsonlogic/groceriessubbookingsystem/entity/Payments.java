package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "payment_info")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the payment table
 * 
 * @version 1.1
 */
public class Payments {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "PAMT"))
	private String payment_id;

	private float amount; // Consider using BigDecimal for currency amounts

	private LocalDate payment_date;

	private String payment_mode;

	// Avoid storing card numbers directly for security reasons
	private String card_number; // Change to String for proper formatting and security

	private String expire_date;

	private int cvv_number; // Consider not storing CVV for security reasons

	@ManyToOne
	@JoinColumn(name = "user_id")
	private Users user;

}
