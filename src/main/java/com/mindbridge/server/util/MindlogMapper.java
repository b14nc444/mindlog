package com.mindbridge.server.util;

import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Mindlog;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class MindlogMapper {

    // Mindlog 엔티티를 MindlogDTO로 변환
    public MindlogDTO toDTO(Mindlog mindlog) {
        MindlogDTO mindlogDTO = new MindlogDTO();

        mindlogDTO.setId(mindlog.getId());
        mindlogDTO.setDate(mindlog.getDate());
        mindlogDTO.setMoodColor(mindlog.getMoodColor());
        mindlogDTO.setMoods(mindlog.getMoods()); // 리스트를 직접 할당
        mindlogDTO.setTitle(mindlog.getTitle());
        mindlogDTO.setEmotionRecord(mindlog.getEmotionRecord());
        mindlogDTO.setEventRecord(mindlog.getEventRecord());
        mindlogDTO.setQuestionRecord(mindlog.getQuestionRecord());
        return mindlogDTO;
    }

    // MindlogDTO를 Mindlog 엔티티로 변환
    public Mindlog toEntity(MindlogDTO mindlogDTO) {
        Mindlog mindlog = new Mindlog();
        mindlog.setId(mindlogDTO.getId());
        mindlog.setDate(mindlogDTO.getDate());
        // mindlog.setMoods(Collections.singletonList(String.join(", ", mindlogDTO.getMoods())));
        mindlog.setMoods(mindlogDTO.getMoods());
        mindlog.setMoodColor(mindlogDTO.getMoodColor());
        mindlog.setTitle(mindlogDTO.getTitle());
        mindlog.setEmotionRecord(mindlogDTO.getEmotionRecord());
        mindlog.setEventRecord(mindlogDTO.getEventRecord());
        mindlog.setQuestionRecord(mindlogDTO.getQuestionRecord());
        return mindlog;
    }
}
