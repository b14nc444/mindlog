package com.mindbridge.server.repository;

import com.mindbridge.server.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

// 진료 일정 CRUD 클래스
@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    @Query("SELECT a FROM Appointment a WHERE a.date = :date")
    List<Appointment> findByDate(@Param("date") String date);

}
