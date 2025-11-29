package com.ironman.book.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.ironman.book.exception.ApplicationException.ExceptionType;

// Lombok annotations
@Getter
@RequiredArgsConstructor
public enum ExceptionCatalog {
    DATABASE_UNEXPECTED_ERROR(
            ExceptionType.INTERNAL_SERVER_ERROR,
            "Database",
            "An unexpected error occurred in the database service."
    ),
    UNEXPECTED_ERROR(
            ExceptionType.INTERNAL_SERVER_ERROR,
            "Application",
            "An unexpected error occurred, please try again later."
    ),
    PUBLISHER_NOT_FOUND(
            ExceptionType.NOT_FOUND,
            "Publisher Service",
            "Publisher not found with id: %s"
    ),
    PUBLISHER_CODE_CONFLICT(
            ExceptionType.CONFLICT,
            "Publisher Service",
            "Publisher code already exists: %s"
    ),
    BOOK_NOT_FOUND(
            ExceptionType.NOT_FOUND,
            "Book Service",
            "Book not found with id: %s"
    );

    private final ExceptionType exceptionType;
    private final String component;
    private final String message;

    public ApplicationException buildException(Object... args) {
        String formattedMessage = String.format(this.message, args);

        return ApplicationException.builder()
                .exceptionType(this.exceptionType)
                .component(this.component)
                .message(formattedMessage)
                .build();
    }
}
