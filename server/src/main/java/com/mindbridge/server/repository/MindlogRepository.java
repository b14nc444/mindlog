package com.mindbridge.server.repository;

import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.model.Mindlog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

// 감정 기록 CRUD 클래스
public interface MindlogRepository extends JpaRepository<Mindlog, Long> {

    @Query("SELECT m FROM Mindlog m WHERE m.date = :date")
    List<Mindlog> findByDate(@Param("date") String date);
}