package com.ironman.book.dto.publisher;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.io.Serializable;

// Lombok annotations
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PublisherRequest implements Serializable {

    @NotEmpty(message = "Publisher code must not be empty")
    @Size(min=5, max=10, message = "Publisher code must be between 5 and 10 characters")
    @Pattern(regexp = "^[A-Z0-9]+$", message = "Publisher code must be alphanumeric and uppercase")
    private String code;

    @NotEmpty(message = "Publisher name must not be empty")
    @Size(min=3, max=50, message = "Publisher name must be between 3 and 50 characters")
    @Pattern(regexp = "^[A-Za-z0-9 .,'-ñÑ´]+$", message = "Publisher name contains invalid characters")
    private String name;
}