package com.mindbridge.server.service;

import com.mindbridge.server.model.Mindlog;
import com.mindbridge.server.repository.MindlogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MindlogService {

    @Autowired
    private MindlogRepository mindlogRepository;

    public List<Mindlog> getAllMindlogs() {
        return mindlogRepository.findAll();
    }

    public Mindlog addMindlog(Mindlog mindlog) {
        return mindlogRepository.save(mindlog);
    }

    public Mindlog getMindlogById(Long id) {
        return mindlogRepository.findById(id).orElse(null);
    }

    public Mindlog updateMindlog(Long id, Mindlog mindlog) {
        if (mindlogRepository.existsById(id)) {
            mindlog.setId(id);
            return mindlogRepository.save(mindlog);
        } else {
            return null;
        }
    }

    public void deleteMindlog(Long id) {
        mindlogRepository.deleteById(id);
    }
}
