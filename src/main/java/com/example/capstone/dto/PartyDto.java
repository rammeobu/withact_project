package com.example.capstone.dto;

import com.example.capstone.entity.Party;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;


@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PartyDto {
    private Long id;
    private String title;
    private String content;
    private Long activityId;
    private String activityTitle;
    private Long leaderId;
    private List<PartyRoleDto> roles;

    public static PartyDto from(Party entity) {
        return PartyDto.builder()
                .id(entity.getId())
                .title(entity.getTitle())
                .content(entity.getContent())
                .activityId(entity.getActivityId())
                .leaderId(entity.getLeaderId())
                .roles(entity.getRoles().stream()
                        .map(PartyRoleDto::from)
                        .collect(Collectors.toList()))
                .build();
    }
}