package com.mindbridge.server.util;

import com.mindbridge.server.dto.AppointmentDTO;
import com.mindbridge.server.model.Appointment;
import lombok.*;
import lombok.experimental.Accessors;
import org.springframework.stereotype.Component;

@Component
@Getter
@Setter
@Accessors(chain = true)
public class AppointmentMapper {

    // Appointment 엔티티를 AppointmentDTO로 변환
    public AppointmentDTO toDTO(Appointment appointment) {
        AppointmentDTO appointmentDTO = new AppointmentDTO();

        appointmentDTO.setId(appointment.getId());
        appointmentDTO.setDate(appointment.getDate());

        appointmentDTO.setStartTime(appointment.getStartTime());
        appointmentDTO.setEndTime(appointment.getEndTime());

        appointmentDTO.setDoctorName(appointment.getDoctorName());
        appointmentDTO.setHospital(appointment.getHospital());
        return appointmentDTO;
    }

    // AppointmentDTO를 Appointment 엔티티로 변환
    public Appointment toEntity(AppointmentDTO appointmentDTO) {
        Appointment appointment = new Appointment();

        appointment.setId(appointmentDTO.getId());
        appointment.setDate(appointmentDTO.getDate());

        appointment.setStartTime(appointmentDTO.getStartTime());
        appointment.setEndTime(appointmentDTO.getEndTime());

        appointment.setDoctorName(appointmentDTO.getDoctorName());
        appointment.setHospital(appointmentDTO.getHospital());
        return appointment;
    }
}
