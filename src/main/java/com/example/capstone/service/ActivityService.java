package com.example.capstone.service;
import com.example.capstone.entity.Activity;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;
import com.example.capstone.repository.ActivityRepository;

import java.util.List;

@Service
@RequiredArgsConstructor

public class ActivityService {
    private final ActivityRepository activityRepository;
    public List<Activity> findAll(){
        return activityRepository.findAll();
    }
    public Activity save(Activity activity){
        return activityRepository.save(activity);
    }
    public Activity findById(Long activity){
        return activityRepository.findById(activity)
        .orElseThrow(() -> new RuntimeException("Activity not found"));
    }
    public void delete(Long id){
        activityRepository.deleteById(id);
    }
}
