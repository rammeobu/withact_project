package com.example.capstone.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// SwaggerConfig.java 예시
@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI() {
      return new OpenAPI()
              .info(new Info()
              .title("Capstone Login API")
              .description("API for Login Capstone Project")
              .version("ver_1.0.0"));
    }
}