package com.example.capstone.service;

import com.example.capstone.dto.UserDto;
import com.example.capstone.entity.User;
import com.example.capstone.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    @Transactional
    public User updateUser(Long userId , UserDto userDto) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저가 존재하지 않습니다"));
        user.setName(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setPhone(userDto.getPhone());
        user.setAddress(userDto.getAddress());
        return userRepository.save(user);
    }
    @Transactional(readOnly = true)
    public UserDto findbyid(Long id) {
        User user = userRepository.findById(id).
                orElseThrow(()->new RuntimeException("유저가 없다"));
        return UserDto.from(user);
    }
}
