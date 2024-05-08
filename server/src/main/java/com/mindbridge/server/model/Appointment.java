package com.mindbridge.server.model;// import jakarta.persistence.EntityManager;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.util.Date;

// 진료 일정 속성 모델 클래스
@Entity
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // 진료 아이디
    private Long id;

    // 진료 일정
    private String date;

    // 시작 시간
    private String startTime;

    // 종료 시간
    private String endTime;

    // 주치의
    private String doctorName;

    // 병원
    private String hospital;

    // 매개변수가 없는(default) 생성자
    public Appointment() {
    }

    // 생성자 함수


    public Appointment(Long id, String date, String startTime, String endTime, String doctorName, String hospital) {
        this.id = id;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.doctorName = doctorName;
        this.hospital = hospital;
    }

    // getter setter
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

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getHospital() {
        return hospital;
    }

    public void setHospital(String hospital) {
        this.hospital = hospital;
    }
}