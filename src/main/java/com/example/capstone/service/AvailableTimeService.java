package com.example.capstone.service;

import com.example.capstone.entity.Activity;
import com.example.capstone.entity.AvailableTime;
import com.example.capstone.entity.Member;
import com.example.capstone.repository.ActivityRepository;
import com.example.capstone.repository.AvailableTimeRepository;
import com.example.capstone.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class AvailableTimeService {

    private final AvailableTimeRepository availableTimeRepository;
    private final MemberRepository memberRepository;
    private final ActivityRepository activityRepository;

    // userId → memberId로 변경
    public void saveAvailableTime(Long memberId, Long activityId, Map<String, List<String>> schedule) {

        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new RuntimeException("유저 없음"));

        Activity activity = activityRepository.findById(activityId)
                .orElseThrow(() -> new RuntimeException("대외활동 없음"));

        // 메서드 이름 변경
        availableTimeRepository.deleteByMemberIdAndActivityId(memberId, activityId);

        schedule.forEach((day, hours) -> {
            if (hours != null && !hours.isEmpty()) {
                AvailableTime availableTime = AvailableTime.builder()
                        .member(member)
                        .activity(activity)
                        .dayOfWeek(DayOfWeek.valueOf(day))
                        .hours(hours)
                        .build();
                availableTimeRepository.save(availableTime);
            }
        });
    }

    @Transactional(readOnly = true)
    public Map<String, List<String>> getMyAvailableTime(Long memberId, Long activityId) {
        List<AvailableTime> times = availableTimeRepository.findByMemberIdAndActivityId(memberId, activityId);
        return times.stream()
                .collect(Collectors.toMap(
                        time -> time.getDayOfWeek().name(),
                        AvailableTime::getHours
                ));
    }

    public void deleteAvailableTime(Long memberId, Long activityId) {
        availableTimeRepository.deleteByMemberIdAndActivityId(memberId, activityId);
    }
}