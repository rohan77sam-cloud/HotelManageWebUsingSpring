package com.hotel.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.hotel")

// FIX: Implement WebMvcConfigurer so we can register a resource handler.
// When @EnableWebMvc is used, Spring takes over ALL request handling.
// Without addResourceHandlers(), requests to /images/*.jpg are intercepted
// by Spring and return nothing — that is why images were broken.
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {

        InternalResourceViewResolver resolver =
                new InternalResourceViewResolver();

        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");

        return resolver;
    }

    // FIX: Tell Spring to serve everything under /images/** directly
    // from the /images/ folder inside webapp (where you placed your .jpg files).
    // Without this, image requests are 404/blank even if the files exist.
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/images/**")
                .addResourceLocations("/images/");
    }
}
