package com.ironman.book.service;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.dto.publisher.PublisherResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface PublisherService {

    Flux<PublisherOverviewResponse> findAll();

    Mono<PublisherDetailResponse> findById(Integer id);

    Mono<PublisherResponse> create(PublisherRequest publisherRequest);

    Mono<PublisherResponse> update(Integer id, PublisherRequest publisherRequest);

    Mono<PublisherResponse> deleteById(Integer id);

}
