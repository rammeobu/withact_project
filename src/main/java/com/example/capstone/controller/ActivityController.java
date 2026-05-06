package com.example.capstone.controller;
import com.example.capstone.entity.Activity;
import com.example.capstone.service.ActivityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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
    @Operation(summary = "대외활동 전체 조회",description = "대외활동 전체 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200",description = "성공"),
            @ApiResponse(responseCode = "204",description = "대외활동 없음")
    })
    public ResponseEntity<List<Activity>> getAll() {
        List<Activity> activities=activityService.findAll();
        if (activities.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(activityService.findAll());
    }
    @Operation(summary = "대외활동 조회",description = "id로 대회활동 조회")
    @ApiResponses({
            @ApiResponse(responseCode = "200",description = "성공"),
            @ApiResponse(responseCode = "404",description = "대외활동 존제 안함")
    })
    @GetMapping("/{id}")
    public ResponseEntity<Activity> getOne(@PathVariable Long id) {
        return ResponseEntity.ok(activityService.findById(id));
    }

    @Operation(summary = "대외활동 생성",description = "새로운 대외활동 생성")
    @ApiResponses({
            @ApiResponse(responseCode = "201",description = "생성됨")
    })
    @PostMapping
    public ResponseEntity<Activity> save(@RequestBody Activity activity) {
        return ResponseEntity.status(201).body(activityService.save(activity));
    }
    @Operation(summary = "대외활동 삭제",description = "id로 대외활동 삭제")
    @ApiResponses({
            @ApiResponse(responseCode = "204",description = "내용 없음"),
            @ApiResponse(responseCode = "404",description = "삭제할 파일 없음")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        activityService.delete(id);
        return ResponseEntity.noContent().build();
    }
}