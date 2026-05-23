package com.example.capstone.controller;

import com.example.capstone.dto.PartyDto;
import com.example.capstone.dto.PartyRoleDto;

import com.example.capstone.entity.Party;
import com.example.capstone.entity.PartyRole;
import com.example.capstone.service.PartyService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.stream.Collectors;

import java.util.List;

@RestController
@RequestMapping("/api/Party/v1")
@RequiredArgsConstructor
public class PartyController {

    private final PartyService partyService;

    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "모집하는 파티가 존재"),
            @ApiResponse(responseCode = "404", description = "모집하는 파티가 없음")
    })
    @GetMapping // 모든 파티 찾기
    public ResponseEntity<List<Party>> findPartyAll() {
        List<Party> parties = partyService.findAll();
        if (parties.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(parties);
    }

    @GetMapping("/{id}") // 특정 id의 파티 찾기
    public ResponseEntity<PartyDto> getPartyOne(@PathVariable("id") Long id) {
        Party party = partyService.findByPartyId(id);

        return ResponseEntity.ok(PartyDto.from(party));
    }

    @GetMapping("/{id}/roles") // 특정 파티의 직군 조회
    public ResponseEntity<List<PartyRoleDto>> getPartyRoles(@PathVariable("id") Long id) {
        List<PartyRoleDto> roles = partyService.findRolesByPartyId(id).stream().
                map(PartyRoleDto::from).
                collect(Collectors.toList());
        return ResponseEntity.ok(roles);
    }

    @PostMapping // 파티 생성
    public ResponseEntity<Party> createParty(@RequestBody Party party) {
        Party createdParty = partyService.save(party);
        return ResponseEntity.status(201).body(createdParty);
    }
    @PostMapping("/{id}/roles")
    public ResponseEntity<PartyRole> createPartyroles(@PathVariable("id") Long id,@RequestBody PartyRole partyRole) {
        PartyRole createdParty = partyService.addRole(id,partyRole);
        return ResponseEntity.status(201).body(createdParty);
    }

    @DeleteMapping("/{id}") // 특정 파티 삭제
    public ResponseEntity<Void> deleteParty(@PathVariable("id") Long id) {
        partyService.delete(id);
        return ResponseEntity.noContent().build();
    }
}