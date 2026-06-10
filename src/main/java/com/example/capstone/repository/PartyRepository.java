package com.example.capstone.repository;

import com.example.capstone.entity.Party;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.lang.ScopedValue;

@Repository
public interface PartyRepository extends JpaRepository<Party, Long> {
    <T> ScopedValue<T> findByActivityId(Long activityId);
}
