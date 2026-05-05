package com.example.capstone.controller;
import com.example.capstone.entity.Activity;
import com.example.capstone.service.ActivityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/activities/v1")
@RequiredArgsConstructor
public class ActivityController {

    private final ActivityService activityService;

    @GetMapping
    public ResponseEntity<List<Activity>> getAll() {
        return ResponseEntity.ok(activityService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Activity> getOne(@PathVariable Long id) {
        return ResponseEntity.ok(activityService.findById(id));
    }

    @PostMapping
    public ResponseEntity<Activity> save(@RequestBody Activity activity) {
        return ResponseEntity.status(201).body(activityService.save(activity));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        activityService.delete(id);
        return ResponseEntity.noContent().build();
    }
}