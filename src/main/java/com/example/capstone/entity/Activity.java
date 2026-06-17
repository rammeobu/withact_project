package com.example.capstone.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;


@Entity
@Data
@Table(name = "activities")
public class Activity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String organization;
    private String category;
    @Column(columnDefinition = "MEDIUMTEXT")
    private String description;
    private LocalDate startDate;
    private LocalDate endDate;
    private String location;
    private String sourceUrl;
    private String imageUrl;

}
