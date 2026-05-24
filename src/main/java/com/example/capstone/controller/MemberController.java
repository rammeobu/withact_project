package com.example.capstone.controller;

import com.example.capstone.dto.MemberDto;
import com.example.capstone.entity.Member;
import com.example.capstone.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/User/v1")
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @PutMapping("/{id}/profile")
    public Member updateUser(@PathVariable Long id, @RequestBody MemberDto memberDto) {
        return memberService.updateUser(id, memberDto);
    }
    @GetMapping("/{id}")
    public MemberDto getUser(@PathVariable Long id) {
        return memberService.findbyid(id);
    }
}
