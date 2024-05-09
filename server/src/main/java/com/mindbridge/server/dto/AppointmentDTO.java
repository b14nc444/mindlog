package com.mindbridge.server.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.time.LocalTime;

@Getter
@Setter
@ToString
public class AppointmentDTO {

    private Long id;
    private String date;
    private LocalTime startTime;
    private LocalTime endTime;
    private String doctorName;
    private String hospital;
}
