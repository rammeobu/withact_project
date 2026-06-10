package com.example.capstone.repository;

import com.example.capstone.entity.AvailableTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AvailableTimeRepository extends JpaRepository<AvailableTime, Long> {

    void deleteByMemberIdAndActivityId(Long memberId, Long activityId);
    List<AvailableTime> findByMemberIdAndActivityId(Long memberId, Long activityId);
}
