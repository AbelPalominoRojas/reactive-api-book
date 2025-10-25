package com.ironman.book.service;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface PublisherService {

    Flux<PublisherOverviewResponse> findAll();

    Mono<PublisherDetailResponse> findById(Integer id);
}
