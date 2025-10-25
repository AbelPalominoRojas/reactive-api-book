package com.ironman.book.repository.impl;

import com.ironman.book.entity.Publisher;
import com.ironman.book.repository.PublisherRepository;
import com.ironman.book.repository.jpa.PublisherJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.Optional;

// Lombok annotations
@RequiredArgsConstructor

// Spring Stereotype annotation
@Repository
public class PublisherRepositoryImpl implements PublisherRepository {
    private final PublisherJpaRepository publisherJpaRepository;

    @Override
    public Flux<Publisher> findAll() {
        return Mono.fromCallable(publisherJpaRepository::findAll)
                .subscribeOn(Schedulers.boundedElastic())
                .flatMapIterable(publishers -> publishers);
    }

    @Override
    public Mono<Publisher> findById(Integer id) {
        return Mono.fromCallable(() -> publisherJpaRepository.findById(id))
                .subscribeOn(Schedulers.boundedElastic())
                .filter(Optional::isPresent)
                .map(Optional::get)
                .switchIfEmpty(Mono.empty());
    }

    @Override
    public Mono<Publisher> save(Publisher publisher) {
        return Mono.fromCallable(() -> publisherJpaRepository.save(publisher))
                .subscribeOn(Schedulers.boundedElastic());
    }
}
