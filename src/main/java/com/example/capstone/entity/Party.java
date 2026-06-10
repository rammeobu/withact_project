package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
public class Party {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    private String title;
    private String content;
    private Long activityId;
    private Long leaderId;

    @OneToMany(mappedBy = "party",cascade = CascadeType.ALL)
    private List<PartyRole> roles = new ArrayList<>();
    public  void approveMember(String roleName)
    {
        PartyRole targetRole = this.roles.stream().
                filter(role -> role.getRoleName().equals(roleName)).
                findFirst().
                orElseThrow(()-> new RuntimeException("해당 직군 찾을수 없다"));
        targetRole.addParticipant();
    }
}
