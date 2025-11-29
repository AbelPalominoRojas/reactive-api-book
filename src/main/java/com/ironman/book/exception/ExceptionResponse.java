package com.ironman.book.exception;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

// Lombok annotations
@Getter
@Builder
public class ExceptionResponse {
    private String message;
    List<ExceptionDetailResponse> details;

    @Getter
    @Builder
    public static class ExceptionDetailResponse {
        private String component;
        private String message;
    }
}
