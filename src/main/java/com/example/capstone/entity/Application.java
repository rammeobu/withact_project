package com.example.capstone.entity;

import com.example.capstone.enums.ApplicationStatus;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Application {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;  // 지원자

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "party_id")
    private Party party;  // 지원한 대외활동

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "party_role_id")
    private PartyRole role;

    @Column(length = 1000)
    private String motivation;  // 지원 동기

    @Column(length = 1000)
    private String introduction;  // 자기소개

    private String portfolioUrl;  // 포트폴리오 링크

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ApplicationStatus status;  // PENDING, APPROVED, REJECTED

    private LocalDateTime appliedAt;  // 지원 일시

    private LocalDateTime processedAt;  // 승인/거절 일시

    @PrePersist
    public void prePersist() {
        this.appliedAt = LocalDateTime.now();
        this.status = ApplicationStatus.PENDING;
    }
}