package com.mindbridge.server.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Record {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 파일 위치
    private String filePath;

    // appointment 연관 관계 매핑
    @OneToOne(mappedBy = "record", fetch = FetchType.LAZY)
    private Appointment appointment;

    // default 생성자
    public Record() {
    }

    public Record(Long id, String filePath) {
        this.id = id;
        this.filePath = filePath;
    }

    // getter setter

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
