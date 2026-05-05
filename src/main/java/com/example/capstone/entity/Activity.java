package com.example.capstone.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;
import java.time.LocalDate;


@Entity
@Data
public class Activity {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private String organization;
    private String category;
    @Column(length = 2000)
    private String description;

    private LocalDate startDate;
    private LocalDate endDate;
    private String location;
    private String sourceUrl;

}
