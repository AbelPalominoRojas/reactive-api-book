package com.ironman.book.dto.publisher;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

// Lombok annotations
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PublisherDetailResponse implements Serializable {
    private Integer id;
    private String code;
    private String name;
    private LocalDateTime createdAt;
    private Integer status;
}