package com.ironman.book.dto.book;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

// Lombok annotations to reduce boilerplate code
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookDetailResponse implements Serializable {

    private Integer id;
    private String isbn;
    private String title;
    private String authors;
    private String edition;
    private Integer publicationYear;
    private Integer publisherId;
    private LocalDateTime createdAt;
    private Integer status;
}