package com.example.capstone.controller;

import com.example.capstone.controller.dto.JoinRequest; // 1. DTO 임포트 체크
import com.example.capstone.controller.dto.LoginRequest;
import com.example.capstone.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor

public class AuthController {

    private final UserService userService;

    // 1. 회원가입 화면 띄우기
    @GetMapping("/join")
    public String joinPage(Model model) {
        model.addAttribute("joinRequest", new JoinRequest());
        return "join"; // templates/join.html을 찾아감
    }

    // 2. 실제 회원가입 처리
    @PostMapping("/join")
    public String join(@Valid @ModelAttribute("joinRequest") JoinRequest req,
                       BindingResult bindingResult) {

        // 아이디 중복 체크 로직 (Service 호출)
        if(userService.checkLoginIdDuplicate(req.getLoginId())) {
            bindingResult.rejectValue("loginId", "duplicate", "이미 존재하는 아이디입니다.");
        }

        // 에러가 있으면 다시 회원가입 페이지로
        if(bindingResult.hasErrors()) {
            return "join";
        }

        userService.join(req);
        return "redirect:/login"; // 가입 성공 시 로그인 페이지로 이동
    }
    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("loginRequest", new LoginRequest());
        return "login";
    }
}
