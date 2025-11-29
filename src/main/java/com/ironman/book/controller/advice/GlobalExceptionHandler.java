package com.ironman.book.controller.advice;

import com.ironman.book.exception.ApplicationException;
import com.ironman.book.exception.ExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.bind.support.WebExchangeBindException;
import reactor.core.publisher.Mono;

import java.util.List;

import static com.ironman.book.exception.ExceptionResponse.ExceptionDetailResponse;
import static com.ironman.book.exception.ApplicationException.ExceptionType;
import static com.ironman.book.util.Constant.*;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(WebExchangeBindException.class)
    public Mono<ResponseEntity<ExceptionResponse>> handleValidationException(WebExchangeBindException ex) {
        var details = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(error -> ExceptionDetailResponse.builder()
                        .component(error.getField())
                        .message(error.getDefaultMessage())
                        .build())
                .toList();

        var exceptionResponse = createExceptionResponse(MESSAGE_INVALID_INPUT_DATA, details);

        return Mono.just(ResponseEntity.status(HttpStatus.BAD_REQUEST).body(exceptionResponse));
    }


    @ExceptionHandler(ApplicationException.class)
    public Mono<ResponseEntity<ExceptionResponse>> handleApplicationException(ApplicationException ex) {

        var detail = ExceptionDetailResponse.builder()
                .component(ex.getComponent())
                .message(ex.getMessage())
                .build();

        String message = messageFromExceptionType(ex.getExceptionType());
        HttpStatus status = mapExceptionTypeToHttpStatus(ex.getExceptionType());

        var exceptionResponse = createExceptionResponse(message, List.of(detail));

        return Mono.just(ResponseEntity.status(status).body(exceptionResponse));
    }


    private ExceptionResponse createExceptionResponse(String message, List<ExceptionDetailResponse> details) {
        return ExceptionResponse.builder()
                .message(message)
                .details(details)
                .build();
    }

    private String messageFromExceptionType(ExceptionType exceptionType) {
        return switch (exceptionType) {
            case BAD_REQUEST -> MESSAGE_INVALID_INPUT_DATA;
            case NOT_FOUND -> MESSAGE_RESOURCE_NOT_FOUND;
            case CONFLICT -> MESSAGE_BUSINESS_RULES_VIOLATION;
            default -> MESSAGE_UNEXPECTED_ERROR;
        };
    }

    private HttpStatus mapExceptionTypeToHttpStatus(ExceptionType exceptionType) {
        return switch (exceptionType) {
            case BAD_REQUEST -> HttpStatus.BAD_REQUEST;
            case NOT_FOUND -> HttpStatus.NOT_FOUND;
            case CONFLICT -> HttpStatus.CONFLICT;
            default -> HttpStatus.INTERNAL_SERVER_ERROR;
        };
    }
}
