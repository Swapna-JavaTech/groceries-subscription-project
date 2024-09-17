package com.crimsonlogic.groceriessubbookingsystem.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.crimsonlogic.groceriessubbookingsystem.entity.Users;

public interface UserRepository extends JpaRepository<Users, String> {

	Optional<Users> findByUserEmail(String email);

}
