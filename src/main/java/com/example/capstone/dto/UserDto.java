package com.example.capstone.dto;

import com.example.capstone.entity.User;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserDto {
    private Long id;
    private String name;
    private String skill;
    private String email;
    private String phone;
    private String address;

    public static UserDto from(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setSkill(user.getSkill());
        dto.setEmail(user.getEmail());
        dto.setPhone(user.getPhone());
        dto.setAddress(user.getAddress());
        return dto;
    }

}