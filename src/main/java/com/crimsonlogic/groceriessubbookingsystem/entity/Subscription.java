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
@Table(name = "Subscriptions")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the Subscription table
 * 
 * @version 1.1
 */
public class Subscription {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "SUB"))
	private String subscription_id;

	@ManyToOne
	@ToString.Exclude
	@JoinColumn(name = "grocery_id", foreignKey = @ForeignKey(name = "FK_Grocery"))
	private Groceries groceries;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Frequency frequency;

	private int quantity;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private SubscriptionStatus subStatus;

	@Column(nullable = false)
	private BigDecimal amount;

	@Column(name = "startedAt")
	private Timestamp startedAt;

	public enum Frequency {
		weekly, daily, monthly
	}

	public enum SubscriptionStatus {
		Pending, Processed, Shipped, Delivered, Cancelled, NotDelivered
	}

	@ManyToOne
	@JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_USER"))
	private Users user;
}
