package com.mindbridge.server.service;

import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Mindlog;
import com.mindbridge.server.repository.MindlogRepository;
import com.mindbridge.server.util.MindlogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
//import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MindlogService {

    @Autowired
    private MindlogRepository mindlogRepository;

    @Autowired
    private MindlogMapper mindlogMapper;

    // 모든 마인드로그 DTO 목록 조회
    public List<MindlogDTO> getAllMindlogs() {
        List<Mindlog> mindlogs = mindlogRepository.findAll();
        return mindlogs.stream()
                .map(mindlogMapper::toDTO)
                .collect(Collectors.toList());
    }

    // 마인드로그 작성
    public MindlogDTO addMindlog(Mindlog mindlog) {
        Mindlog savedMindlog = mindlogRepository.save(mindlog);
        return mindlogMapper.toDTO(savedMindlog);
    }

    // 마인드로그 조회
    public MindlogDTO getMindlogById(Long id) {
        Mindlog mindlog = mindlogRepository.findById(id).orElse(null);
        return mindlog != null ? mindlogMapper.toDTO(mindlog) : null;
    }

    // 마인드로그 수정
    public MindlogDTO updateMindlog(Long id, Mindlog mindlog) {
        if (mindlogRepository.existsById(id)) {
            mindlog.setId(id);
            Mindlog updatedMindlog = mindlogRepository.save(mindlog);
            return mindlogMapper.toDTO(updatedMindlog);
        } else {
            return null;
        }
    }

    // 마인드로그 삭제
    public void deleteMindlog(Long id) {
        mindlogRepository.deleteById(id);
    }

    // Mindlog 날짜 수정
    public MindlogDTO updateMindlogDate(Long id, Date newDate) {
        Mindlog mindlog = mindlogRepository.findById(id).orElse(null);
        if (mindlog != null) {
            mindlog.setDate(newDate);
            Mindlog updatedMindlog = mindlogRepository.save(mindlog);
            return mindlogMapper.toDTO(updatedMindlog);
        } else {
            return null;
        }
    }
}