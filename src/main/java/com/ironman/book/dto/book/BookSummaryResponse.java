package com.ironman.book.dto.book;

import lombok.*;

import java.io.Serializable;

// Lombok annotations to reduce boilerplate code
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookSummaryResponse implements Serializable {
    private Integer id;
    private String isbn;
    private String title;
    private Integer publisherId;
}
