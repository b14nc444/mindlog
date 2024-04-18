package com.mindbridge.server.repository;

import com.mindbridge.server.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

// 진료 일정 CRUD 클래스
@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    // 추가적인 메서드가 필요한 경우 여기에 작성할 수 있습니다.
}
