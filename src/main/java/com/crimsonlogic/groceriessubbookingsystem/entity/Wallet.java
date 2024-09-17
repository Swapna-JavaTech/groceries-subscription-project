package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "wallet")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the Wallet table
 * 
 * @version 1.1
 */
public class Wallet {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "WAL"))
	private String walletId;

	@ManyToOne
	@ToString.Exclude
	@JoinColumn(name = "user_id", unique = true, foreignKey = @ForeignKey(name = "FK_user"))
	private Users user;

	@Column(name = "balance", nullable = false, precision = 19, scale = 2)
	private BigDecimal balance;

}
