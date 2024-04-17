package com.mindbridge.server.controller;

import com.mindbridge.server.model.Mindlog;
import com.mindbridge.server.service.MindlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/mindlog")
public class MindlogController {

    @Autowired
    private MindlogService mindlogService;

    @GetMapping
    public List<Mindlog> getAllMindlogs() {
        return mindlogService.getAllMindlogs();
    }

    @PostMapping
    public Mindlog addMindlog(@RequestBody Mindlog mindlog) {
        return mindlogService.addMindlog(mindlog);
    }

    @GetMapping("/{id}")
    public Mindlog getMindlogById(@PathVariable Long id) {
        return mindlogService.getMindlogById(id);
    }

    @PutMapping("/{id}")
    public Mindlog updateMindlog(@PathVariable Long id, @RequestBody Mindlog mindlog) {
        return mindlogService.updateMindlog(id, mindlog);
    }

    @DeleteMapping("/{id}")
    public void deleteMindlog(@PathVariable Long id) {
        mindlogService.deleteMindlog(id);
    }
}
