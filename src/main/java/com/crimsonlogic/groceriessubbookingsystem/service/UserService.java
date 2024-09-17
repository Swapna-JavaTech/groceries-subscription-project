package com.crimsonlogic.groceriessubbookingsystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.crimsonlogic.groceriessubbookingsystem.entity.PasswordResetToken;
import com.crimsonlogic.groceriessubbookingsystem.entity.Users;
import com.crimsonlogic.groceriessubbookingsystem.repository.PasswordResetTokenRepository;
import com.crimsonlogic.groceriessubbookingsystem.repository.UserRepository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;
	private final PasswordResetTokenRepository tokenRepository;

	@Autowired
	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder,
			PasswordResetTokenRepository tokenRepository) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
		this.tokenRepository = tokenRepository;
	}

	// save the user
	@Transactional
	public void registerUser(Users user) {
		user.setUserPassword(passwordEncoder.encode(user.getUserPassword()));
		userRepository.save(user);
	}

	// login the user
	public Optional<Users> loginUser(String email, String password) {
		Optional<Users> userOptional = userRepository.findByUserEmail(email);
		if (userOptional.isPresent()) {
			Users user = userOptional.get();
			System.out.println(user.getUserPassword());
			if (passwordEncoder.matches(password, user.getUserPassword())) {
				return Optional.of(user);
			}
		}
		return Optional.empty();
	}

	// get the user by id as optional class
	public Optional<Users> getUserById(String userId) {
		return userRepository.findById(userId);
	}

	// update the user
	@Transactional
	public void updateUser(String userId, Users updatedUser) {
		if (userRepository.existsById(userId)) {
			updatedUser.setUser_id(userId);
			userRepository.save(updatedUser);
		}
	}

	// get the user by id
	public Users getUsersById(String userId) {
		return userRepository.findById(userId).orElse(null);
	}

	// generate the reset password token
	@Transactional
	public String generatePasswordResetToken(String email) {
		Optional<Users> userOptional = userRepository.findByUserEmail(email);
		if (userOptional.isPresent()) {
			Users user = userOptional.get();
			// Delete existing token if any
			tokenRepository.deleteByToken(user.getResetToken());

			// Generate a new token
			String token = UUID.randomUUID().toString();
			PasswordResetToken resetToken = new PasswordResetToken();
			resetToken.setToken(token);
			resetToken.setUserId(user.getUser_id());
			resetToken.setExpiryDate(LocalDateTime.now().plusHours(1)); // Token valid for 1 hour
			tokenRepository.save(resetToken);

			// Update user with new token
			user.setResetToken(token);
			userRepository.save(user);

			return token;
		}
		return null;
	}

	// Validate the password token
	public boolean validatePasswordResetToken(String token) {
		Optional<PasswordResetToken> resetTokenOptional = tokenRepository.findByToken(token);
		if (resetTokenOptional.isPresent()) {
			PasswordResetToken resetToken = resetTokenOptional.get();
			return LocalDateTime.now().isBefore(resetToken.getExpiryDate());
		}
		return false;
	}

	// reset password
	@Transactional
	public boolean resetPassword(String token, String newPassword) {
		Optional<PasswordResetToken> resetTokenOptional = tokenRepository.findByToken(token);
		if (resetTokenOptional.isPresent()) {
			PasswordResetToken resetToken = resetTokenOptional.get();
			Optional<Users> userOptional = userRepository.findById(resetToken.getUserId());
			if (userOptional.isPresent()) {
				Users user = userOptional.get();
				user.setUserPassword(passwordEncoder.encode(newPassword));
				user.setResetToken(null); // Clear the token after successful reset
				userRepository.save(user);
				tokenRepository.deleteByToken(token); // Delete the token
				return true;
			}
		}
		return false;
	}
}
