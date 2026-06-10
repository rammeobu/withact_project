package com.example.capstone.service;

import com.example.capstone.dto.MemberDto;
import com.example.capstone.entity.Member;
import com.example.capstone.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;
    @Transactional(readOnly = true)
    public MemberDto findbyid(Long id) {
        Member member = memberRepository.findById(id).
                orElseThrow(()->new RuntimeException("유저가 없다"));
        return MemberDto.from(member);
    }
    public MemberDto findbymemberid(Long id) {
        Member member =memberRepository.findById(id).orElseThrow(()->new RuntimeException("유저가 없다"));
        return MemberDto.fromSimple(member);

    }
    @Transactional
    public MemberDto updateMember(Long userId, MemberDto memberDto) {
        Member member = memberRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저가 존재하지 않습니다"));
        member.setName(memberDto.getName());
        member.setEmail(memberDto.getEmail());
        member.setBelong(memberDto.getBelong());
        member.setSpec(memberDto.getSpec());
        member.setMajor(memberDto.getMajor());
        memberRepository.save(member);
        return MemberDto.from(member);
    }

}
