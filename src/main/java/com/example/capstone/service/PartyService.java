package com.example.capstone.service;

import com.example.capstone.entity.Party;
import com.example.capstone.entity.PartyRole;
import com.example.capstone.repository.PartyRepository;
import com.example.capstone.repository.PartyRoleRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PartyService {
    private final PartyRepository partyRepository;
    private final PartyRoleRepository partyRoleRepository;
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
    public PartyRole addRole(Long partyId, PartyRole role) {
        Party party = findByPartyId(partyId);
        role.setParty(party);
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

    public Party findByActivityId(Long activityId){
        return partyRepository.getReferenceById(activityId);
    }
    public void approvePartyicipant(Long partyId,String roleName){
        Party party = findByPartyId(partyId);
        party.approveMember(roleName);
    }
}

