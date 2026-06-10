package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;


@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PUBLIC)
public class PartyRole {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "party_id")
    private Party party;

    private String roleName;
    private Integer targetCount;
    private Integer currentCount;
    @OneToMany(mappedBy = "role", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Application> applications = new ArrayList<>();
    public void addParticipant(){
        if (this.currentCount >= this.targetCount){
            throw new RuntimeException("이미 모집이 끝난 직군");
        }
        this.currentCount++;
    }

    public Integer getMaxCount() {
        return this.targetCount;
    }
}
