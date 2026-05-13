package com.example.capstone.config;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DotenvConfig {

    static {
        // Spring 시작 전에 환경변수 로드
        try {
            Dotenv dotenv = Dotenv.configure()
                    .directory("./")
                    .ignoreIfMissing()
                    .load();

            dotenv.entries().forEach(entry -> {
                System.setProperty(entry.getKey(), entry.getValue());
                System.out.println("[ENV] " + entry.getKey() + " = " +
                        (entry.getKey().contains("PASSWORD") ? "****" : entry.getValue()));
            });
        } catch (Exception e) {
            System.err.println("Failed to load .env file: " + e.getMessage());
        }
    }

    @PostConstruct
    public void init() {
        System.out.println("DotenvConfig initialized!");
    }
}