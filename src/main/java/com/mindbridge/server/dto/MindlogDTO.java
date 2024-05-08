package com.mindbridge.server.dto;

import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.model.Mindlog;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

//lombok dependency추가
@Getter
@Setter
@Accessors(chain = true)
@NoArgsConstructor
@ToString
public class MindlogDTO {

    private Long id;
    private String date;
    private List<String> moods = new ArrayList<>(); // 감정을 List 형식으로 변경
    // private String mood;
    private String moodColor;
    private String title;
    private String emotionRecord;
    private String eventRecord;
    private String questionRecord;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<String> getMoods() {
        return moods;
    }

//    public void setMoods(String mood) {
//        // 쉼표로 구분된 감정들을 리스트로 변환하여 저장
//        this.moods = Arrays.asList(mood.split(", "));
//    }
    public void setMoods(List<String> moods) {
        this.moods = moods;
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
