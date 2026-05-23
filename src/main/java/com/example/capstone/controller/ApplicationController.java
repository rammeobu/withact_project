package com.example.capstone.controller;

import com.example.capstone.dto.ApplicationDto;
import com.example.capstone.service.ApplicationService;
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
    public ResponseEntity<ApplicationDto> apply(@RequestBody ApplicationDto dto) {
        ApplicationDto response = applicationService.apply(dto);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/my")
    public ResponseEntity<List<ApplicationDto>> getMyApplications(@RequestParam Long userId) {
        List<ApplicationDto> applications = applicationService.getMyApplications(userId);
        return ResponseEntity.ok(applications);
    }
}
