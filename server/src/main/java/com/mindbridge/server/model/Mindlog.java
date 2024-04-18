package com.mindbridge.server.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.util.Date;

// 감정 기록 속성 모델 클래스
@Entity
public class Mindlog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 날짜
    private Date date;

    // 기분 색깔 -> 인공지능 내용이라.. 상의하기!
    private String moodColor;

    // 제목
    private String title;

    // 감정 기록 내용
    private String emotionRecord;

    // 이벤트 기록 내용
    private String eventRecord;

    // 질문 기록 내용
    private String questionRecord;

    // 생성자 함수
    public Mindlog() {
    }

    public Mindlog(Date date, String moodColor, String title, String emotionRecord, String eventRecord, String questionRecord) {
        this.date = date;
        this.moodColor = moodColor;
        this.title = title;
        this.emotionRecord = emotionRecord;
        this.eventRecord = eventRecord;
        this.questionRecord = questionRecord;
    }

    // 게터 및 세터 메서드
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

    public String getTitle() {return title;}

    public void setTitle(String title) {this.title = title;}

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