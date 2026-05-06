package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class Party {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    private String title;
    private String content;
    private Long activityId;
    private Long leaderId;

    @OneToMany(mappedBy = "party",cascade = CascadeType.ALL)
    private List<PartyRole> roles = new ArrayList<>();

}
