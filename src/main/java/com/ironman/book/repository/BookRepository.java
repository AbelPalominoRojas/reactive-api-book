package com.ironman.book.repository;

import com.ironman.book.entity.Book;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface BookRepository {

    Flux<Book> findAll();

    Mono<Book> findById(Integer id);

    Mono<Book> save(Book book);
}
