package com.mindbridge.server.service;

import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

// 기능 나타내는 클래스
@Service
public class AppointmentService {

    @Autowired
    private AppointmentRepository appointmentRepository;

    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }

    public Appointment getAppointmentById(Long id) {
        return appointmentRepository.findById(id).orElse(null);
    }

    public Appointment addAppointment(Appointment appointment) {
        // 여기서 데이터 유효성 검사 등을 수행할 수 있습니다.
        return appointmentRepository.save(appointment);
    }

    public Appointment updateAppointment(Long id, Appointment appointment) {
        // id에 해당하는 진료 일정이 존재하는지 먼저 확인하는 등의 로직을 추가할 수 있습니다.
        appointment.setId(id);
        return appointmentRepository.save(appointment);
    }

    public void deleteAppointment(Long id) {
        // id에 해당하는 진료 일정이 존재하는지 먼저 확인하는 등의 로직을 추가할 수 있습니다.
        appointmentRepository.deleteById(id);
    }
}