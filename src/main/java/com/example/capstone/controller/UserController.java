package com.example.capstone.controller;

import com.example.capstone.dto.UserDto;
import com.example.capstone.entity.User;
import com.example.capstone.repository.UserRepository;
import com.example.capstone.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.repository.Repository;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/User/v1")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PutMapping("/{id}/pofile")
    public User updateUser(@PathVariable Long id, @RequestBody UserDto userDto) {
        return userService.UserDate(id, userDto);
    }
    @PutMapping("/{id}")
    public UserDto getUser(@PathVariable Long id, @RequestBody UserDto userDto) {
        return userService.findbyid(id);
    }
}
