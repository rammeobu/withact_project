package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PartyRole {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "party_id")
    private Party party;

    private String roleName;
    private Integer targetCount;
    private Integer currentCount;

    public void addParticipant(){
        if (this.currentCount >= this.targetCount){
            throw new RuntimeException("이미 모집이 끝난 직군");
        }
        this.currentCount++;
    }
}
