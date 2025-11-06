package com.ironman.book.dto.book;

import lombok.*;

import java.io.Serializable;

// Lombok annotations to reduce boilerplate code
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookResponse implements Serializable {
    private Integer id;
    private Integer publisherId;
    private Integer status;
}