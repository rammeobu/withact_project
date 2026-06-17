package com.example.capstone.controller;

import com.example.capstone.dto.MemberDto;
import com.example.capstone.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user/v1")
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @PutMapping("/{id}/personal")
    @Operation(summary = "사용자 프로필 업데이트", description = "사용자 프로필 업데이트")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "업데이트 성공"),
            @ApiResponse(responseCode = "400", description = "잘못된 요청"),
            @ApiResponse(responseCode = "404", description = "사용자 없음")
    })
    public MemberDto updateMember(@PathVariable Long id, @RequestBody MemberDto memberDto) {
        return memberService.updateMember(id, memberDto);
    }

    @GetMapping("/{id}")
    @Operation(summary = "사용자 조회", description = "사용자 기본 정보 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "조회 성공"),
            @ApiResponse(responseCode = "404", description = "사용자 없음")
    })
    public MemberDto getUser(@PathVariable Long id) {
        return memberService.findbyid(id);
    }

    @GetMapping("/{id}/personal")
    @Operation(summary = "지원자 프로필 조회", description = "지원자의 프로필 정보 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "조회 성공"),
            @ApiResponse(responseCode = "404", description = "사용자 없음")
    })
    public MemberDto getPersonal(@PathVariable Long id) {
        return memberService.findbymemberid(id);
    }
    @PostMapping
    @Operation(summary = "사용자 생성", description = "사용자 정보 생성")
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "생성 성공"),
            @ApiResponse(responseCode = "400", description = "잘못된 요청")
    })
    public ResponseEntity<MemberDto> createMember(@RequestBody MemberDto memberDto) {
        return ResponseEntity.status(201).body(memberService.createMember(memberDto));
    }

}

