package com.mindbridge.server.dto;

import java.util.Date;

import com.mindbridge.server.model.Appointment;
import lombok.*;
import lombok.experimental.Accessors;

//lombok dependency추가

@Getter // 왜 안 돼 ㅅ발
@Setter
@Accessors(chain = true)
@NoArgsConstructor
@ToString
public class AppointmentDTO {

    private Long id;
    private String date;
    private String startTime;
    private String endTime;
    private String doctorName;
    private String hospital;

    // 생성자, 게터, 세터 메서드는 생략

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
