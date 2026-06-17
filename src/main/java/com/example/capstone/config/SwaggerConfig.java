package com.example.capstone.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI(@Value("${server.port:8080}") String serverPort) {
        Server localServer = new Server();
        localServer.setUrl("http://localhost:" + serverPort);
        localServer.setDescription("Local Server");

        Server prodServer = new Server();
        prodServer.setUrl("https://backend.withact.xyz");
        prodServer.setDescription("Production Server");

        return new OpenAPI()
                .servers(List.of(localServer, prodServer))
                .info(new Info()
                        .title("Capstone Login API")
                        .description("API for Login Capstone Project")
                        .version("ver_1.0.0"));
    }
}
