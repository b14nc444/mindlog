package com.mindbridge.server.controller;

import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Mindlog;
import com.mindbridge.server.service.AppointmentService;
import com.mindbridge.server.service.MindlogService;
import com.mindbridge.server.util.AppointmentMapper;
import com.mindbridge.server.util.MindlogMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// @RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/mindlog")
public class MindlogController {

    public MindlogController(MindlogService mindlogService, MindlogMapper mindlogMapper) {
        this.mindlogService = mindlogService;
        this.mindlogMapper = mindlogMapper;
    }
    private final MindlogService mindlogService;
    private final MindlogMapper mindlogMapper;

    @GetMapping
    public List<MindlogDTO> getAllMindlogs() {
        return mindlogService.getAllMindlogs();
    }

    // 감정 기록 추가 
    @PostMapping
    public MindlogDTO addMindlog(@RequestBody MindlogDTO mindlogDTO) {
        Mindlog mindlog = mindlogMapper.toEntity(mindlogDTO);
        MindlogDTO addedMindlog = mindlogService.addMindlog(mindlog);
        System.out.println("감정 기록 추가" + mindlogDTO);
        return addedMindlog;
    }

    // 감정 기록 조회 
    @GetMapping("/{id}")
    public MindlogDTO getMindlogById(@PathVariable Long id) {
        MindlogDTO mindlogDTO = mindlogService.getMindlogById(id);
        System.out.println("감정 기록 조회" + mindlogDTO);
        return mindlogDTO != null ? mindlogDTO : null;
    }

    // 감정 기록 수정 
    @PutMapping("/{id}")
    public MindlogDTO updateMindlog(@PathVariable Long id, @RequestBody MindlogDTO mindlogDTO) {
        Mindlog mindlog = mindlogMapper.toEntity(mindlogDTO);
        MindlogDTO updatedMindlogDTO = mindlogService.updateMindlog(id, mindlog);
        System.out.println("감정 기록 수정" + mindlogDTO);
        return updatedMindlogDTO;
    }

    // 감정 기록 삭제 
    @DeleteMapping("/{id}")
    public void deleteMindlog(@PathVariable Long id) {
        System.out.println("감정 기록 삭제" + id);
        mindlogService.deleteMindlog(id);
    }
}
