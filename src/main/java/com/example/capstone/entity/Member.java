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
public class Member {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String spec;
    private String email;
    @Column(name = "any_field")
    private String any;
    private String address;
    private String major;
    private String belong;
    private String preference;
    private String introduction;
}
