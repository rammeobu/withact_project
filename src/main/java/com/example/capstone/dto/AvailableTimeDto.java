package com.example.capstone.dto;

import lombok.*;

import java.util.List;
import java.util.Map;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class AvailableTimeDto {
    private Long userId;
    private Long activityId;
    private Map<String, List<Integer>> schedule;
}