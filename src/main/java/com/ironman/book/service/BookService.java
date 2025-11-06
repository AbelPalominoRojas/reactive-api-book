package com.ironman.book.service;

import com.ironman.book.dto.book.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface BookService {

    Flux<BookSummaryResponse> findAll();

    Mono<BookDetailResponse> findById(Integer id);

    Mono<BookResponse> create(BookRequest bookRequest);

    Mono<BookResponse> update(Integer id, BookRequest bookRequest);

    Mono<BookResponse> deleteById(Integer id);

}
