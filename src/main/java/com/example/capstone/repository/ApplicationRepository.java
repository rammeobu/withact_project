package com.example.capstone.repository;

import com.example.capstone.entity.Application;
import com.example.capstone.enums.ApplicationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ApplicationRepository extends JpaRepository<Application, Long> {

    List<Application> findByUserId(Long userId);

    List<Application> findByPartyId(Long partyId);

    List<Application> findByRoleId(Long roleId);

    Optional<Application> findByUserIdAndPartyId(Long userId, Long partyId);

    List<Application> findByPartyIdAndStatus(Long partyId, ApplicationStatus status);
}