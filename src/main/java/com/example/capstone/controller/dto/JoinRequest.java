package com.example.capstone.controller.dto;

import com.example.capstone.entity.UserRole;
import com.example.capstone.entity.User;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class JoinRequest {
    @NotBlank(message = "아이디가 비어있습니다.")
    private String loginId;

    @NotBlank(message = "비밀번호가 비어있습니다.")
    private String password;
    private String passwordConfirm;

    @NotBlank(message = "이름이 비어있습니다.")
    private String username;

    public User toEntity(String encodedPassword) {
        return User.builder()
                .loginId(this.loginId)
                .password(encodedPassword)
                .username(this.username)
                .role(UserRole.USER)
                .build();
    }

}
