package com.ironman.book.repository.impl;

import com.ironman.book.entity.Publisher;
import com.ironman.book.repository.PublisherRepository;
import com.ironman.book.repository.jpa.PublisherJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.Optional;

import static com.ironman.book.exception.ExceptionCatalog.DATABASE_UNEXPECTED_ERROR;

// Lombok annotations
@RequiredArgsConstructor
@Slf4j

// Spring Stereotype annotation
@Repository
public class PublisherRepositoryImpl implements PublisherRepository {
    private final PublisherJpaRepository publisherJpaRepository;

    @Override
    public Flux<Publisher> findAll() {
        return Mono.fromCallable(publisherJpaRepository::findAll)
                .subscribeOn(Schedulers.boundedElastic())
                .flatMapIterable(publishers -> publishers)
                .onErrorResume(throwable -> {
                    log.error("PublisherRepositoryImpl:findAll - Error: {}", throwable.getMessage(), throwable);

                    return Flux.error(DATABASE_UNEXPECTED_ERROR.buildException());
                });
    }

    @Override
    public Mono<Publisher> findById(Integer id) {
        return Mono.fromCallable(() -> publisherJpaRepository.findById(id))
                .subscribeOn(Schedulers.boundedElastic())
                .filter(Optional::isPresent)
                .map(Optional::get)
                .switchIfEmpty(Mono.empty())
                .onErrorResume(throwable -> {
                    log.error("PublisherRepositoryImpl:findById - Error: {}", throwable.getMessage(), throwable);

                    return Mono.error(DATABASE_UNEXPECTED_ERROR.buildException());
                });
    }

    @Override
    public Mono<Publisher> save(Publisher publisher) {
        return Mono.fromCallable(() -> publisherJpaRepository.save(publisher))
                .subscribeOn(Schedulers.boundedElastic())
                .onErrorResume(throwable -> {
                    log.error("PublisherRepositoryImpl:save - Error: {}", throwable.getMessage(), throwable);

                    return Mono.error(DATABASE_UNEXPECTED_ERROR.buildException());
                });
    }

    @Override
    public Mono<Publisher> findByPublisherCode(String publisherCode) {
        return Mono.fromCallable(() -> publisherJpaRepository.findByPublisherCode(publisherCode))
                .subscribeOn(Schedulers.boundedElastic())
                .filter(Optional::isPresent)
                .map(Optional::get)
                .switchIfEmpty(Mono.empty())
                .onErrorResume(throwable -> {
                    log.error("PublisherRepositoryImpl:findByPublisherCode - Error: {}", throwable.getMessage(), throwable);

                    return Mono.error(DATABASE_UNEXPECTED_ERROR.buildException());
                });
    }
}
