package com.example.capstone.service;

import com.example.capstone.controller.dto.JoinRequest;
import com.example.capstone.controller.dto.LoginRequest;
import com.example.capstone.entity.User;
import com.example.capstone.repository.UserRepository;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    // 비밀번호 암호화 도구 (나중에 시큐리티 설정 후 주석 해제)
    // private final BCryptPasswordEncoder encoder;

    //아이디 중복 체크
    @Transactional(readOnly = true) // 읽기 전용으로 성능 최적화
    public boolean checkLoginIdDuplicate(String loginId) {
        return userRepository.existsByLoginId(loginId);
    }

    // 일단 암호화 없이 테스트
    public void join(JoinRequest req) {
        // 나중에 암호화를 도입한다면: req.toEntity(encoder.encode(req.getPassword()))
        userRepository.save(req.toEntity(req.getPassword()));
    }

    //로그인
    public User login(String loginId, String password) {
        // 아이디로 유저 찾기
        return userRepository.findByLoginId(loginId)
                .filter(u -> u.getPassword().equals(password)) // 비밀번호 일치 확인
                .orElse(null); // 없거나 틀리면 null 반환
    }
}