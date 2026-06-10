package com.example.capstone.service;
import com.example.capstone.dto.FilterOptionDto;
import com.example.capstone.entity.Activity;
import com.example.capstone.repository.PartyRoleRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;
import com.example.capstone.repository.ActivityRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor

public class ActivityService {
    private final ActivityRepository activityRepository;
    private final PartyRoleRepository partyRoleRepository;
    public List<Activity> findAll(){
        return activityRepository.findAll();
    }
    @Transactional
    public Activity save(Activity activity){
        return activityRepository.save(activity);
    }
    public Activity findById(Long activity){
        return activityRepository.findById(activity)
        .orElseThrow(() -> new RuntimeException("Activity not found"));
    }
    @Transactional
    public void delete(Long id){
        activityRepository.deleteById(id);
    }
    public List<FilterOptionDto> getFilters() {
        List<String> roles = partyRoleRepository.findDistinctRoleNames();
        return List.of(new FilterOptionDto("직군", roles));
    }
}
