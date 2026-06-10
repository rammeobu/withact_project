package com.example.capstone.controller;

import com.example.capstone.dto.ApplicationDto;
import com.example.capstone.service.ApplicationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/application/v1")
@RequiredArgsConstructor
public class ApplicationController {

    private final ApplicationService applicationService;

    @PostMapping
    @Operation(summary = "지원하기", description = "대외활동 파티에 지원")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "지원 성공"),
            @ApiResponse(responseCode = "400", description = "이미 지원함 또는 모집 마감")
    })
    public ResponseEntity<ApplicationDto> apply(@RequestBody ApplicationDto dto) {
        ApplicationDto response = applicationService.apply(dto);
        return ResponseEntity.ok(response);
    }
    //TODO :Security 적용후 @AutenticationPrincipal 교체 필요
    @GetMapping("/{userid}")
    @Operation(summary = "내 지원 내역 조회", description = "사용자의 모든 지원 내역 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "조회 성공")
    })
    public ResponseEntity<List<ApplicationDto>> getMyApplications(@RequestParam Long userId) {
        List<ApplicationDto> applications = applicationService.getMyApplications(userId);
        return ResponseEntity.ok(applications);
    }


    @GetMapping("/party/{partyId}")
    @Operation(summary = "파티 지원자 목록", description = "특정 파티에 지원한 모든 사용자 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "조회 성공")
    })
    public ResponseEntity<List<ApplicationDto>> getPartyApplications(@PathVariable Long partyId) {
        List<ApplicationDto> applications = applicationService.getPartyApplications(partyId);
        return ResponseEntity.ok(applications);
    }

    @PutMapping("/{id}/approve")
    @Operation(summary = "지원 승인", description = "지원을 승인하고 모집 인원 증가")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "승인 성공"),
            @ApiResponse(responseCode = "400", description = "이미 처리됨 또는 모집 마감")
    })
    public ResponseEntity<String> approveApplication(@PathVariable Long id) {
        applicationService.approveApplication(id);
        return ResponseEntity.ok("지원이 승인되었습니다.");
    }

    @PutMapping("/{id}/reject")
    @Operation(summary = "지원 거절", description = "지원을 거절")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "거절 성공"),
            @ApiResponse(responseCode = "400", description = "이미 처리됨")
    })
    public ResponseEntity<String> rejectApplication(@PathVariable Long id) {
        applicationService.rejectApplication(id);
        return ResponseEntity.ok("지원이 거절되었습니다.");
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "지원 취소", description = "사용자가 본인의 지원을 취소")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "취소 성공"),
            @ApiResponse(responseCode = "400", description = "본인 지원이 아니거나 이미 처리됨")
    })
    public ResponseEntity<String> cancelApplication(
            @PathVariable Long id,
            @RequestParam Long userId
    ) {
        applicationService.cancelApplication(id, userId);
        return ResponseEntity.ok("지원이 취소되었습니다.");
    }
}