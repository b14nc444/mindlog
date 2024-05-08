package com.mindbridge.server.controller;


import com.mindbridge.server.dto.MindlogDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/test")
public class testController {

    @GetMapping
    public String test() {
        return "test";
    }
}
