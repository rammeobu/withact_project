package com.example.capstone.service;

import com.example.capstone.entity.Party;
import com.example.capstone.entity.PartyRole;
import com.example.capstone.repository.PartyRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PartyService {
    private final PartyRepository partyRepository;
    public List<Party> findAll(){
        return partyRepository.findAll();
    }
    @Transactional
    public Party save(Party party){
        return partyRepository.save(party);
    }
    public Party findById(Long party){
        return partyRepository.findById(party)
                .orElseThrow(() -> new RuntimeException("Party not found"));
    }
    @Transactional
    public void delete(Long id){
        partyRepository.deleteById(id);
    }
    public Party findByActivityId(Long activityId){
        return partyRepository.getReferenceById(activityId);
    }
    public void approvePartyicipant(Long partyId,String roleName){
        Party party = findById(partyId);
        PartyRole targetRole = party.getRoles().stream()
                .filter(role->role.getRoleName().equals(roleName))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("해당 직군 찾기 불가능"));
        if (targetRole.getTargetCount() < targetRole.getCurrentCount()){
            targetRole.setTargetCount(targetRole.getCurrentCount()+1);
        }else{
            throw new RuntimeException("이미 모집 끝난 직군");
        }
    }


}

