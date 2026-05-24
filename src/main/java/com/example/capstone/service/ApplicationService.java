
package com.example.capstone.service;

import com.example.capstone.dto.ApplicationDto;
import com.example.capstone.entity.*;
import com.example.capstone.enums.ApplicationStatus;
import com.example.capstone.repository.ApplicationRepository;
import com.example.capstone.repository.PartyRepository;
import com.example.capstone.repository.PartyRoleRepository;
import com.example.capstone.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ApplicationService {

    private final ApplicationRepository applicationRepository;
    private final MemberRepository memberRepository;
    private final PartyRepository partyRepository;
    private final PartyRoleRepository partyRoleRepository;


    public ApplicationDto apply(ApplicationDto dto) {

        applicationRepository.findByUserIdAndPartyId(dto.getUserId(), dto.getPartyId())
                .ifPresent(app -> {
                    throw new RuntimeException("이미 지원한 대외활동입니다.");
                });

        Member member = memberRepository.findById(dto.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Party party = partyRepository.findById(dto.getPartyId())
                .orElseThrow(() -> new RuntimeException("Party not found"));

        PartyRole role = partyRoleRepository.findById(dto.getRoleId())
                .orElseThrow(() -> new RuntimeException("PartyRole not found"));

        if (role.getCurrentCount() >= role.getMaxCount()) {
            throw new RuntimeException("해당 역할의 모집 인원이 마감되었습니다.");
        }

        Application application = Application.builder()
                .member(member)
                .party(party)
                .role(role)
                .motivation(dto.getMotivation())
                .introduction(dto.getIntroduction())
                .portfolioUrl(dto.getPortfolioUrl())
                .status(ApplicationStatus.PENDING)
                .build();

        Application saved = applicationRepository.save(application);

        return toDto(saved);
    }

    @Transactional(readOnly = true)
    public List<ApplicationDto> getMyApplications(Long userId) {
        return applicationRepository.findByUserId(userId).stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ApplicationDto> getPartyApplications(Long partyId) {
        return applicationRepository.findByPartyId(partyId).stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }


    public void approveApplication(Long applicationId) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Application not found"));

        if (application.getStatus() != ApplicationStatus.PENDING) {
            throw new RuntimeException("이미 처리된 지원입니다.");
        }

        PartyRole role = application.getRole();

        if (role.getCurrentCount() >= role.getMaxCount()) {
            throw new RuntimeException("모집 인원이 마감되었습니다.");
        }

        application.setStatus(ApplicationStatus.APPROVED);
        application.setProcessedAt(LocalDateTime.now());

        role.setCurrentCount(role.getCurrentCount() + 1);
        partyRoleRepository.save(role);
    }

    public void rejectApplication(Long applicationId) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Application not found"));

        if (application.getStatus() != ApplicationStatus.PENDING) {
            throw new RuntimeException("이미 처리된 지원입니다.");
        }

        application.setStatus(ApplicationStatus.REJECTED);
        application.setProcessedAt(LocalDateTime.now());
    }


    public void cancelApplication(Long applicationId, Long userId) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Application not found"));

        if (!application.getMember().getId().equals(userId)) {
            throw new RuntimeException("본인의 지원만 취소할 수 있습니다.");
        }

        if (application.getStatus() != ApplicationStatus.PENDING) {
            throw new RuntimeException("대기중인 지원만 취소할 수 있습니다.");
        }

        applicationRepository.delete(application);
    }

    private ApplicationDto toDto(Application app) {
        return ApplicationDto.builder()
                .id(app.getId())
                .userId(app.getMember().getId())
                .userName(app.getMember().getName())
                .partyId(app.getParty().getId())
                .partyName(app.getParty().getTitle())
                .roleId(app.getRole().getId())
                .roleName(app.getRole().getRoleName())
                .motivation(app.getMotivation())
                .introduction(app.getIntroduction())
                .portfolioUrl(app.getPortfolioUrl())
                .status(app.getStatus())
                .appliedAt(app.getAppliedAt())
                .processedAt(app.getProcessedAt())
                .build();
    }
}