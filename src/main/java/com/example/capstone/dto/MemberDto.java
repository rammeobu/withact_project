package com.example.capstone.dto;

import com.example.capstone.entity.Member;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberDto {
    private Long id;
    private String name;
    private String skill;
    private String email;
    private String phone;
    private String address;

    public static MemberDto from(Member member) {
        MemberDto dto = new MemberDto();
        dto.setId(member.getId());
        dto.setName(member.getName());
        dto.setSkill(member.getSkill());
        dto.setEmail(member.getEmail());
        dto.setPhone(member.getPhone());
        dto.setAddress(member.getAddress());
        return dto;
    }

}