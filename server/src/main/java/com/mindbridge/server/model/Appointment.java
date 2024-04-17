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
    private Date date;

    // 주치의
    private String patientName;

    // 병원
    private String hospital;

    // 매개변수가 없는(default) 생성자
    public Appointment() {
    }

    // 생성자 함수
    public Appointment (Long id, Date date, String patientName, String hospital) {
        this.id = id;
        this.date = date;
        this.patientName = patientName;
        this.hospital = hospital;
    }

    // getter setter


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

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getHospital() {
        return hospital;
    }

    public void setHospital(String hospital) {
        this.hospital = hospital;
    }
}