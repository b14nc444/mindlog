package com.mindbridge.server.controller;

import com.mindbridge.server.dto.AppointmentDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class TestController {

    @GetMapping("/say")
    public String sayHello() {
        String say = "hello";
        System.out.println(say);
        return say;
    }

}
