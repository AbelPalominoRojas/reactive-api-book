package com.ironman.book.service.impl;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.mapper.PublisherMapper;
import com.ironman.book.repository.PublisherRepository;
import com.ironman.book.service.PublisherService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

// Lombok annotation
@RequiredArgsConstructor

// Spring Service annotation
@Service
public class PublisherServiceImpl implements PublisherService {

    private final PublisherRepository publisherRepository;
    private final PublisherMapper publisherMapper;

    @Override
    public Flux<PublisherOverviewResponse> findAll() {
        return publisherRepository.findAll()
                .map(publisherMapper::toOverviewResponse);
    }

    @Override
    public Mono<PublisherDetailResponse> findById(Integer id) {
        return publisherRepository.findById(id)
                .switchIfEmpty(Mono.error(new RuntimeException("Publisher not found with id: " + id)))
                .map(publisherMapper::toDetailResponse);
    }
}
