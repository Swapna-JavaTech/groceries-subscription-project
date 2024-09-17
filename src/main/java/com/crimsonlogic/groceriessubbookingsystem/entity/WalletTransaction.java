package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.math.BigDecimal;
import java.util.Date;

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
@Table(name = "wallet_transaction")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the WalletTransaction table
 * 
 * @version 1.1
 */
public class WalletTransaction {

	@Id
	@GeneratedValue(generator = "custom-prefix-generator")
	@GenericGenerator(name = "custom-prefix-generator", strategy = "com.crimsonlogic.groceriessubbookingsystem.util.CustomPrefixIdentifierGenerator", parameters = @org.hibernate.annotations.Parameter(name = "prefix", value = "TRX"))
	private String transactionId;

	@ManyToOne
	@ToString.Exclude
	@JoinColumn(name = "wallet_id", foreignKey = @ForeignKey(name = "FK_wallet"))
	private Wallet wallet;

	@Column(name = "amount", nullable = false, precision = 19, scale = 2)
	private BigDecimal amount;

	@Column(name = "transaction_date", nullable = false)
	private Date transactionDate;

	@Column(name = "transaction_type", nullable = false)
	private String transactionType; // Example values: "RECHARGE", "DEBIT"
}
