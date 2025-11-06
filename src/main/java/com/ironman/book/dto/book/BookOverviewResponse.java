package com.ironman.book.dto.book;

import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import lombok.*;

import java.io.Serializable;

// Lombok annotations to reduce boilerplate code
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookOverviewResponse implements Serializable {
    private Integer id;
    private String isbn;
    private String title;
    private String authors;
    private String edition;
    private Integer publicationYear;
    private Integer publisherId;
    private PublisherOverviewResponse publisher;
}
