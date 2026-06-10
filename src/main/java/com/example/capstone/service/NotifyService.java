package com.example.capstone.service;

import com.example.capstone.dto.NotifyDto;
import com.example.capstone.entity.Notify;
import com.example.capstone.repository.NotifyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotifyService {
    private final NotifyRepository notifyRepository;
    public List<NotifyDto> getNotify(Long userid){
        return notifyRepository.findByUserId(userid).stream().
                map(n->new NotifyDto(n.getId(), n.getTitle(), n.getContent())).
                toList();
    }
}

