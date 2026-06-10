package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity //DB테이블과 매핑
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users")
public class User {
        @Id//기본키를 지정하는 어노테이션
        @GeneratedValue(strategy = GenerationType.IDENTITY)

        private Long id;

        private String loginId;
        private String password;
        private String username;

        private UserRole role;
        //이 형태로 키값을 지정
}
