package com.mindbridge.server.controller;

import com.mindbridge.server.dto.AppointmentDTO;
import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.service.AppointmentService;
import com.mindbridge.server.util.AppointmentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

//@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/appointment")
public class AppointmentController {

    // 생성자 추가
    public AppointmentController(AppointmentService appointmentService, AppointmentMapper appointmentMapper) {
        this.appointmentService = appointmentService;
        this.appointmentMapper = appointmentMapper;
    }

    private final AppointmentService appointmentService;
    private final AppointmentMapper appointmentMapper;

    @GetMapping
    public List<AppointmentDTO> getAllAppointments() { return appointmentService.getAllAppointments(); }

    // 진료 일정 추가
    @PostMapping("/plus")
    public AppointmentDTO addAppointment(@RequestBody AppointmentDTO appointmentDTO) {
        AppointmentDTO addedAppointment = appointmentService.addAppointment(appointmentDTO);
        System.out.println("진료 일정 추가" + appointmentDTO);
        return addedAppointment;
    }

    // 진료 일정 조회
    @GetMapping("/{id}")
    public AppointmentDTO getAppointmentById(@PathVariable Long id) {
        AppointmentDTO appointmentDTO = appointmentService.getAppointmentById(id);
        System.out.println("진료 일정 조회" + appointmentDTO);
        return appointmentDTO != null ? appointmentDTO : null;
    }

    // 진료 일정 수정
    @PutMapping("/{id}")
    public AppointmentDTO updateAppointment(@PathVariable Long id, @RequestBody AppointmentDTO appointmentDTO) {
        AppointmentDTO updatedAppointment = appointmentService.updateAppointment(id, appointmentDTO);
        System.out.println("진료 일정 수정" + appointmentDTO);
        return updatedAppointment;
    }

    // 진료 일정 삭제
    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Long id) {
        System.out.println("진료 일정 삭제" + id);
        appointmentService.deleteAppointment(id);
    }
}
