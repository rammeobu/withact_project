package com.example.capstone.controller;

import com.example.capstone.dto.NotifyDto;
import com.example.capstone.service.NotifyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/notify/v1")
@RequiredArgsConstructor
public class NotifyController {
    private final NotifyService notifyService;
    @GetMapping
    @Operation(summary = "알림 목록 조회", description = "사용자의 알림 목록 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "조회 성공")
    })
    public ResponseEntity<List<NotifyDto>> getNotifications(@RequestParam("userId") Long userId) {
        return ResponseEntity.ok(notifyService.getNotify(userId));
    }
}
