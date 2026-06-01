package com.example.capstone.controller;

import com.example.capstone.service.EmailAuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/email")
@RequiredArgsConstructor
public class EmailAuthController {

    private final EmailAuthService emailAuthService;
    //리퀘스트
    @PostMapping("/request")
    public ResponseEntity<String> requestEmailAuth(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        try {
            emailAuthService.sendVerificationEmail(email);
            return ResponseEntity.ok("대학 이메일로 인증번호가 발송되었습니다.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("메일 발송 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    //검증
    @PostMapping("/verify")
    public ResponseEntity<String> verifyEmailCode(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String code = request.get("code");

        try {
            boolean isVerified = emailAuthService.verifyEmailCode(email, code);
            if (isVerified) {
                return ResponseEntity.ok("이메일 인증에 성공했습니다!");
            } else {
                return ResponseEntity.badRequest().body("인증번호가 일치하지 않습니다.");
            }
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}