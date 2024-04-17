package com.mindbridge.server.repository;

import com.mindbridge.server.model.Mindlog;
import org.springframework.data.jpa.repository.JpaRepository;

// 감정 기록 CRUD 클래스
public interface MindlogRepository extends JpaRepository<Mindlog, Long> {
}