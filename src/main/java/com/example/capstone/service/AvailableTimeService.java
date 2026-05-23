package com.example.capstone.service;

import com.example.capstone.entity.Activity;
import com.example.capstone.entity.AvailableTime;
import com.example.capstone.entity.User;
import com.example.capstone.repository.ActivityRepository;
import com.example.capstone.repository.AvailableTimeRepository;
import com.example.capstone.repository.UserRepository;
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
    private final UserRepository userRepository;
    private final ActivityRepository activityRepository;

    public void saveAvailableTime(Long userId, Long activityId, Map<String, List<Integer>> schedule) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저 없음"));

        Activity activity = activityRepository.findById(activityId)
                .orElseThrow(() -> new RuntimeException("대외활동 없음"));


        availableTimeRepository.deleteByUserIdAndActivityId(userId, activityId);

        schedule.forEach((day, hours) -> {
            if (hours != null && !hours.isEmpty()) {
                AvailableTime availableTime = AvailableTime.builder()
                        .user(user)
                        .activity(activity)
                        .dayOfWeek(DayOfWeek.valueOf(day))
                        .hours(hours)
                        .build();
                availableTimeRepository.save(availableTime);
            }
        });
    }
    @Transactional(readOnly = true)
    public Map<String, List<Integer>> getMyAvailableTime(Long userId, Long activityId) {
        List<AvailableTime> times = availableTimeRepository
                .findByUserIdAndActivityId(userId, activityId);

        return times.stream()
                .collect(Collectors.toMap(
                        time -> time.getDayOfWeek().name(),
                        AvailableTime::getHours
                ));
    }
    public void deleteAvailableTime(Long userId, Long activityId) {
        availableTimeRepository.deleteByUserIdAndActivityId(userId, activityId);
    }
}