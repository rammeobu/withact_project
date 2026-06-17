package com.example.capstone.service;

import com.example.capstone.dto.PartyRoleDto;
import com.example.capstone.entity.Application;
import com.example.capstone.enums.ApplicationStatus;

import com.example.capstone.repository.ActivityRepository;
import com.example.capstone.repository.ApplicationRepository;
import com.example.capstone.dto.PartyDto;
import com.example.capstone.entity.Party;
import com.example.capstone.entity.PartyRole;
import com.example.capstone.repository.PartyRepository;
import com.example.capstone.repository.PartyRoleRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PartyService {
    private final PartyRepository partyRepository;
    private final PartyRoleRepository partyRoleRepository;
    private final ApplicationRepository applicationRepository;
    private final ActivityRepository activityRepository;
    public List<Party> findAll(){
        return partyRepository.findAll();
    }
    public List<PartyRole> findRolesByPartyId(Long partyId){
        Party party = partyRepository.findById(partyId).
                orElseThrow(() -> new RuntimeException("Party not found"));
        return party.getRoles();
    }
    @Transactional
    public Party save(Party party){
        return partyRepository.save(party);
    }
    @Transactional
    public PartyRole addRole(Long partyId, PartyRoleDto dto) {  // PartyRole → PartyRoleDto
        Party party = findByPartyId(partyId);
        PartyRole role = new PartyRole();
        role.setParty(party);
        role.setRoleName(dto.getRoleName());
        role.setTargetCount(dto.getTargetCount());
        role.setCurrentCount(0);
        return partyRoleRepository.save(role);
    }
    public Party findByPartyId(Long party){
        return partyRepository.findById(party)
                .orElseThrow(() -> new RuntimeException("Party not found"));
    }
    @Transactional
    public void delete(Long id){
        partyRepository.deleteById(id);
    }

    @Transactional
    public Party updateParty(Long id, PartyDto partyDto) {
        Party party = partyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Party not found"));
        party.setTitle(partyDto.getTitle());
        party.setContent(partyDto.getContent());
        return partyRepository.save(party);
    }
    public PartyDto findByPartyIdWithActivityTitle(Long partyId) {
        Party party = partyRepository.findById(partyId)
                .orElseThrow(() -> new RuntimeException("Party not found"));

        String activityTitle = activityRepository.findById(party.getActivityId())
                .map(a -> a.getTitle())
                .orElse(null);

        return PartyDto.builder()
                .id(party.getId())
                .title(party.getTitle())
                .content(party.getContent())
                .activityId(party.getActivityId())
                .activityTitle(activityTitle)
                .leaderId(party.getLeaderId())
                .roles(party.getRoles().stream()
                        .map(PartyRoleDto::from)
                        .collect(Collectors.toList()))
                .build();
    }
    @Transactional
    public void leaveParty(Long partyId, Long userId) {
        Application application = applicationRepository
                .findByPartyIdAndMemberIdAndStatus(partyId, userId, ApplicationStatus.APPROVED)
                .orElseThrow(() -> new RuntimeException("해당 파티의 멤버가 아닙니다"));

        // 2. PartyRole의 currentCount 감소
        PartyRole role = application.getRole();
        role.setCurrentCount(role.getCurrentCount() - 1);

        // 3. Application 삭제
        applicationRepository.delete(application);
    }
    @Transactional
    public PartyRole updateRoleTargetCount(Long roleId, Integer targetCount) {
        PartyRole role = partyRoleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));
        role.setTargetCount(targetCount);
        return partyRoleRepository.save(role);
    }
}

