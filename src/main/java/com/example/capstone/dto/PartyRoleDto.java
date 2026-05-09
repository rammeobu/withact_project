package com.example.capstone.dto;

import com.example.capstone.entity.PartyRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PartyRoleDto {
    private Long id;
    private String roleName;
    private Integer targetCount;
    private Integer currentCount;

    public static PartyRoleDto from(PartyRole entity) {
        return PartyRoleDto.builder().
                id(entity.getId()).
                roleName(entity.getRoleName()).
                targetCount(entity.getTargetCount()).
                currentCount(entity.getCurrentCount()).
                build();
    }
}
