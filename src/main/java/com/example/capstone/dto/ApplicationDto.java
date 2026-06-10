package com.example.capstone.dto;

import com.example.capstone.enums.ApplicationStatus;
import lombok.*;
import java.time.LocalDateTime;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApplicationDto {

    private Long id;
    private Long userId;
    private Long partyId;
    private Long roleId;
    private String motivation;
    private String introduction;
    private String portfolioUrl;

    private String userName;
    private String partyName;
    private String roleName;
    private String skill;
    private ApplicationStatus status;
    private LocalDateTime appliedAt;
    private LocalDateTime processedAt;
}