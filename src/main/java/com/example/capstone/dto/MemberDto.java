package com.example.capstone.dto;

import com.example.capstone.entity.Member;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberDto {
    private Long id;
    private String name;
    private String spec;
    private String email;
    private String phone;
    private String introduction;
    private String major;
    private String city;
    private String address;
    private String belong;
    private String preference;

    public static MemberDto from(Member member) {
        MemberDto dto = new MemberDto();
        dto.setId(member.getId());
        dto.setName(member.getName());
        dto.setSpec(member.getSpec());
        dto.setEmail(member.getEmail());
        dto.setAddress(member.getAddress());
        return dto;
    }
    public static MemberDto fromSimple(Member member) {
        MemberDto dto = new MemberDto();
        dto.setId(member.getId());
        dto.setName(member.getName());
        return dto;
    }

}