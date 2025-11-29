package com.ironman.book.exception;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

// Lombok annotations
@Getter
@Builder
public class ApplicationException extends RuntimeException {
    private ExceptionType exceptionType;
    private String component;
    private String message;


    @RequiredArgsConstructor
    @Getter
    public enum ExceptionType {
        BAD_REQUEST(400),
        NOT_FOUND(404),
        CONFLICT(409),
        INTERNAL_SERVER_ERROR(500);

        private final int statusCode;
    }
}
