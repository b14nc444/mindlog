package com.mindbridge.server.dto;

import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.model.Mindlog;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.util.Date;

//lombok dependency추가
@Getter
@Setter
@Accessors(chain = true)
@NoArgsConstructor
@ToString
public class MindlogDTO {

    private Long id;
    private Date date;
    private String moodColor;
    private String title;
    private String emotionRecord;
    private String eventRecord;
    private String questionRecord;

    // 생성자, 게터, 세터 메서드는 생략


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getMoodColor() {
        return moodColor;
    }

    public void setMoodColor(String moodColor) {
        this.moodColor = moodColor;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getEmotionRecord() {
        return emotionRecord;
    }

    public void setEmotionRecord(String emotionRecord) {
        this.emotionRecord = emotionRecord;
    }

    public String getEventRecord() {
        return eventRecord;
    }

    public void setEventRecord(String eventRecord) {
        this.eventRecord = eventRecord;
    }

    public String getQuestionRecord() {
        return questionRecord;
    }

    public void setQuestionRecord(String questionRecord) {
        this.questionRecord = questionRecord;
    }
}
