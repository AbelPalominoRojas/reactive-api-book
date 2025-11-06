package com.ironman.book.repository.impl;

import com.ironman.book.entity.Book;
import com.ironman.book.repository.BookRepository;
import com.ironman.book.repository.jpa.BookJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.Optional;

// Lombok annotations
@RequiredArgsConstructor

// Spring Stereotype
@Repository
public class BookRepositoryImpl implements BookRepository {
    private final BookJpaRepository bookJpaRepository;


    @Override
    public Flux<Book> findAll() {
        return Mono.fromCallable(bookJpaRepository::findAll)
                .subscribeOn(Schedulers.boundedElastic())
                .flatMapMany(Flux::fromIterable);
    }

    @Override
    public Mono<Book> findById(Integer id) {
        return Mono.fromCallable(() -> bookJpaRepository.findById(id))
                .subscribeOn(Schedulers.boundedElastic())
                .filter(Optional::isPresent)
                .map(Optional::get)
                .switchIfEmpty(Mono.empty());
    }

    @Override
    public Mono<Book> save(Book book) {
        return Mono.fromCallable(() -> bookJpaRepository.save(book))
                .subscribeOn(Schedulers.boundedElastic());
    }
}
