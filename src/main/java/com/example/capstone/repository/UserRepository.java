package com.example.capstone.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.capstone.entity.User;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByLoginId(String loginId);
    boolean existsByUsername(String username);
    Optional<User> findByLoginId(String loginId);
}