package com.example.capstone.controller;

import com.example.capstone.controller.dto.JoinRequest;
import com.example.capstone.controller.dto.LoginRequest;
import com.example.capstone.entity.User;
import com.example.capstone.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController // 1. @Controller 대신 @RestController 사용
@RequiredArgsConstructor
@RequestMapping("/api/auth") // 공통 경로 설정
@Tag(name = "Auth", description = "인증 관리 (회원가입/로그인)") // Swagger용 태그
public class AuthController {

    private final UserService userService;

    // 회원가입 화면(@GetMapping)은 이제 플러터 앱이 스스로 띄우므로 삭제합니다.

    @PostMapping("/join")
    @Operation(summary = "회원가입", description = "아이디 중복 확인 후 회원가입을 진행합니다.")
    public ResponseEntity<String> join(@Valid @RequestBody JoinRequest req) { // 2. @RequestBody로 변경

        // 아이디 중복 체크
        if(userService.checkLoginIdDuplicate(req.getLoginId())) {
            return ResponseEntity.badRequest().body("이미 존재하는 아이디입니다.");
        }

        if (!req.getPassword().equals(req.getPasswordConfirm())) {
            return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
        }

        userService.join(req);
        return ResponseEntity.ok("회원가입 성공"); // 3. HTML 대신 결과 메시지나 데이터를 리턴
    }

    @PostMapping("/login")
    @Operation(summary = "로그인", description = "아이디와 비밀번호를 확인하여 로그인을 처리합니다.")
    public ResponseEntity<String> login(@Valid @RequestBody LoginRequest req) {
        // 로그인 로직 처리 (예: 토큰 발급 등)
        User loginUser = userService.login(req.getLoginId(),req.getPassword());

        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("아이디 또는 비밀 번호가 일치하지 않습니다");
        }
        return ResponseEntity.ok("로그인 성공");
    }
}