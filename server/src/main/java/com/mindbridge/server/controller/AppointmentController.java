package com.mindbridge.server.controller;

import com.mindbridge.server.dto.AppointmentDTO;
import com.mindbridge.server.dto.MindlogDTO;
import com.mindbridge.server.model.Appointment;
import com.mindbridge.server.service.AppointmentService;
import com.mindbridge.server.util.AppointmentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

//@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/appointment")
public class AppointmentController {

    private final AppointmentService appointmentService;
    private final AppointmentMapper appointmentMapper;

    // 생성자 추가
    public AppointmentController(AppointmentService appointmentService, AppointmentMapper appointmentMapper) {
        this.appointmentService = appointmentService;
        this.appointmentMapper = appointmentMapper;
    }
    @GetMapping
    public List<AppointmentDTO> getAllAppointments() { return appointmentService.getAllAppointments(); }

     // 진료 일정 추가
//    @PostMapping()
//    public AppointmentDTO addAppointment(@RequestBody AppointmentDTO appointmentDTO) {
//        AppointmentDTO addedAppointment = appointmentService.addAppointment(appointmentDTO);
//        // System.out.println("진료 일정 추가" + appointmentDTO);
//        return addedAppointment;
//    }

    // 진료 일정 추가
    @PostMapping()
    public ResponseEntity<AppointmentDTO> addAppointment(@RequestBody AppointmentDTO appointmentDTO) {
        AppointmentDTO addedAppointment = appointmentService.addAppointment(appointmentDTO);
        if (addedAppointment != null) {
            // 새로운 진료 일정이 성공적으로 추가되었을 때
            System.out.println("진료 일정 추가 성공 " + addedAppointment.getDate() +
                    addedAppointment.getStartTime() + " ~ " + addedAppointment.getEndTime() + addedAppointment.getHospital());
            return ResponseEntity.ok(addedAppointment);
        } else {
            // 진료 일정 추가에 실패했을 때
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    // 진료 일정 조회 (개별)
    @GetMapping("/{id}")
    public AppointmentDTO getAppointmentById(@PathVariable Long id) {
        AppointmentDTO appointmentDTO = appointmentService.getAppointmentById(id);
        System.out.println("진료 일정 조회(개별) ID: " + appointmentDTO.getId());
        return appointmentDTO != null ? appointmentDTO : null;
    }

    // 진료 일정 조회 by Date
    @GetMapping("/by-date/{date}")
    public List<AppointmentDTO> getAppointmentsByDate(@PathVariable String date) {
        List<AppointmentDTO> appointmentDTOs = appointmentService.getAppointmentsByDate(date);
        System.out.println("진료 일정 조회(날짜): " + date);
        for (AppointmentDTO appointmentDTO : appointmentDTOs) {
            System.out.println("진료 ID: " + appointmentDTO.getId());
        }
        return appointmentDTOs;
    }


    // 진료 일정 수정
    @PutMapping("/{id}")
    public AppointmentDTO updateAppointment(@PathVariable Long id, @RequestBody AppointmentDTO appointmentDTO) {
        AppointmentDTO updatedAppointment = appointmentService.updateAppointment(id, appointmentDTO);
        System.out.println("진료 일정 수정 후 ");

        System.out.println(updatedAppointment.getId() + updatedAppointment.getHospital() + updatedAppointment.getDoctorName() +
                updatedAppointment.getStartTime() + " ~ " + updatedAppointment.getEndTime());

        return updatedAppointment;
    }

    // 진료 일정 삭제
    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Long id) {
        System.out.println("진료 일정 삭제 " + id);
        appointmentService.deleteAppointment(id);
    }
}
