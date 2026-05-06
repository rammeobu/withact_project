package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Data

public class PartyRole {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "party_id")
    private Party party;

    private String roleName;
    private Integer targetCount;
    private Integer currentCount;
}
