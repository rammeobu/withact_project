package com.example.capstone.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class FilterOptionDto {
    private String title;
    private List<String> option;
}