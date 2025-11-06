package com.ironman.book.dto.book;

import lombok.*;

import java.io.Serializable;


// Lombok annotations to reduce boilerplate code
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookRequest implements Serializable {
    private String isbn;
    private String title;
    private String authors;
    private String edition;
    private Integer publicationYear;
    private Integer publisherId;
}
