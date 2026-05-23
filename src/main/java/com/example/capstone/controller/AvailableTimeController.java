package com.example.capstone.controller;

import com.example.capstone.dto.AvailableTimeDto;
import com.example.capstone.service.AvailableTimeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/available-time/v1")
@RequiredArgsConstructor
public class AvailableTimeController {

    private final AvailableTimeService availableTimeService;


    @PostMapping
    public ResponseEntity<String> submitAvailableTime(@RequestBody AvailableTimeDto dto) {
        availableTimeService.saveAvailableTime(
                dto.getUserId(),
                dto.getActivityId(),
                dto.getSchedule()
        );
        return ResponseEntity.ok("활동 가능 시간이 저장되었습니다.");
    }


    @GetMapping
    public ResponseEntity<Map<String, List<Integer>>> getMyAvailableTime(
            @RequestParam Long userId,
            @RequestParam Long activityId
    ) {
        Map<String, List<Integer>> schedule = availableTimeService
                .getMyAvailableTime(userId, activityId);
        return ResponseEntity.ok(schedule);
    }


    @DeleteMapping
    public ResponseEntity<String> deleteAvailableTime(
            @RequestParam Long userId,
            @RequestParam Long activityId
    ) {
        availableTimeService.deleteAvailableTime(userId, activityId);
        return ResponseEntity.ok("활동 가능 시간이 삭제되었습니다.");
    }
}