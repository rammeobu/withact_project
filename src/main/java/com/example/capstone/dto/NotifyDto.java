package com.example.capstone.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor

public class NotifyDto {
    private Long id;
    private String title;
    private String content;

}