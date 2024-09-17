package com.crimsonlogic.groceriessubbookingsystem.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "password_info")
@Data
@NoArgsConstructor
/*
 * @author nagamounikay Maintaining the PasswordResetToken table
 * 
 * @version 1.1
 */
public class PasswordResetToken {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String token;
	private String userId;
	private LocalDateTime expiryDate;

}
