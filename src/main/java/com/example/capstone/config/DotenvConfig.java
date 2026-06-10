package com.example.capstone.config;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DotenvConfig {

    static {
        그럼 로그 안찍는걸로 바꾸자오전 4:37Claude 응답: System.javastatic {
            try {
                Dotenv dotenv = Dotenv.configure()
                        .directory("./")
                        .ignoreIfMissing()
                        .load();

                dotenv.entries().forEach(entry -> {
                    System.setProperty(entry.getKey(), entry.getValue());
                });
            } catch (Exception e) {
                System.err.println("Failed to load .env file: " + e.getMessage());
            }
        }
    }

    @PostConstruct
    public void init() {
        System.out.println("DotenvConfig initialized!");
    }
}