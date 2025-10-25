package com.ironman.book.repository;

import com.ironman.book.entity.Publisher;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface PublisherRepository {
    Flux<Publisher> findAll();

    Mono<Publisher> findById(Integer id);
}
