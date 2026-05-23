package com.example.capstone.repository;

import com.example.capstone.entity.AvailableTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AvailableTimeRepository extends JpaRepository<AvailableTime, Long> {

    void deleteByUserIdAndActivityId(Long userId, Long activityId);

    List<AvailableTime> findByUserIdAndActivityId(Long userId, Long activityId);
}
