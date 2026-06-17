# withact 🎯

> 대외활동 정보 탐색 및 팀원 모집 플랫폼

![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.x-6DB33F?style=flat&logo=springboot&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-11.x-003545?style=flat&logo=mariadb&logoColor=white)
![Raspberry Pi](https://img.shields.io/badge/Raspberry_Pi-5-A22846?style=flat&logo=raspberrypi&logoColor=white)

## 📌 프로젝트 소개

**withact**는 대학생을 위한 대외활동 정보 탐색 및 팀원 모집 플랫폼입니다.  
크롤링을 통해 수집된 대외활동 정보를 제공하고, 함께할 팀원을 모집할 수 있는 파티 시스템을 제공합니다.

- 🔍 대외활동 정보 자동 수집 및 탐색
- 👥 팀원 모집 파티 생성 및 직군별 모집 관리
- 📱 Flutter 기반 모바일 앱 제공
- 🔐 회원가입 / 로그인 / 인증 기능

---

## 🗂 브랜치 구조

| 브랜치 | 설명 |
|--------|------|
| [`capstone-backend`](https://github.com/rammeobu/team-project/tree/capstone-backend) | Spring Boot 백엔드 |
| [`capstone-frontend`](https://github.com/rammeobu/team-project/tree/capstone-frontend) | Flutter 프론트엔드 |

---

## 🛠 기술 스택

### Backend
| 분류 | 기술 |
|------|------|
| Framework | Spring Boot 3.x, JPA |
| Database | MariaDB |
| Server | Raspberry Pi 5, Cloudflare Tunnel |
| Crawler | Python, Playwright |
| Docs | Swagger (OAS 3.1) |

### Frontend
| 분류 | 기술 |
|------|------|
| Framework | Flutter |
| 통신 | REST API (Dio) |

---

## 🖥 서버 구성

```
Raspberry Pi 5
├── Spring Boot API     → https://backend.withact.xyz
├── MariaDB
├── Cloudflare Tunnel
└── Python Crawler (매일 03:00 자동 실행)
```

---

## 📡 주요 API

| 컨트롤러 | 설명 |
|----------|------|
| Auth | 회원가입 / 로그인 |
| Member | 사용자 프로필 관리 |
| Party | 팀원 모집 파티 CRUD |
| PartyRole | 파티 직군 관리 |
| Application | 파티 지원 / 승인 / 거절 |
| AvailableTime | 가능 시간 등록 |
| Activity | 대외활동 정보 조회 |
| Notify | 알림 관리 |

> Swagger UI: `https://backend.withact.xyz/swagger-ui.html`

---

## 👨‍👩‍👧 팀원

| 이름 | 역할 |
|------|------|
| ._cloudhigh(팀장) | Spring Boot REST API 설계 및 구현, DB 설계, 서버 구축 및 운영, Python 크롤러 개발, Swagger 문서화, 배포 |
| 익명2 | Spring Boot 인증 및 보안 구현, 사용자 관리 API, 서비스 디자인 및 UI 가이드 |
| jimmychoi46 | Flutter 모바일 앱 개발, 화면 구현, REST API 연동, UI/UX 설계 |
