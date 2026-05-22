package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table (name = "users")
@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
public class User {
    @Id
    private Long id;
    private String name;

    private String skill;
    private String email;
    private String any;
    private String phone;
    private String address;
}
