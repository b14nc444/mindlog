package com.mindbridge.server.util;

import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Mindlog;
import lombok.*;
import lombok.experimental.Accessors;
import org.springframework.stereotype.Component;

@Component
@Getter
@Setter
@Accessors(chain = true)
public class MindlogMapper {

    // Mindlog 엔티티를 MindlogDTO로 변환
    public MindlogDTO toDTO(Mindlog mindlog) {
        MindlogDTO mindlogDTO = new MindlogDTO();
        mindlogDTO.setId(mindlog.getId());
        mindlogDTO.setDate(mindlog.getDate());
        mindlogDTO.setMoodColor(mindlog.getMoodColor());
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
        mindlog.setMoodColor(mindlogDTO.getMoodColor());
        mindlog.setTitle(mindlogDTO.getTitle());
        mindlog.setEmotionRecord(mindlogDTO.getEmotionRecord());
        mindlog.setEventRecord(mindlogDTO.getEventRecord());
        mindlog.setQuestionRecord(mindlogDTO.getQuestionRecord());
        return mindlog;
    }
}