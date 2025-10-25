package com.ironman.book.service.impl;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.dto.publisher.PublisherResponse;
import com.ironman.book.entity.Publisher;
import com.ironman.book.mapper.PublisherMapper;
import com.ironman.book.repository.PublisherRepository;
import com.ironman.book.service.PublisherService;
import com.ironman.book.util.StatusEnum;
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
        return getPublisherOrThrow(id)
                .map(publisherMapper::toDetailResponse);
    }

    @Override
    public Mono<PublisherResponse> create(PublisherRequest publisherRequest) {
        Publisher publisher = publisherMapper.toEntity(publisherRequest);

        return publisherRepository.save(publisher)
                .map(publisherMapper::toResponse);
    }

    @Override
    public Mono<PublisherResponse> update(Integer id, PublisherRequest publisherRequest) {
        return getPublisherOrThrow(id)
                .flatMap(existingPublisher -> {
                    publisherMapper.updateEntity(existingPublisher, publisherRequest);
                    return publisherRepository.save(existingPublisher);
                })
                .map(publisherMapper::toResponse);
    }

    @Override
    public Mono<PublisherResponse> deleteById(Integer id) {

        return getPublisherOrThrow(id)
                .flatMap(existingPublisher -> {
                    existingPublisher.setStatus(StatusEnum.DISABLED.getValue());
                    return publisherRepository.save(existingPublisher);
                })
                .map(publisherMapper::toResponse);
    }

    private Mono<Publisher> getPublisherOrThrow(Integer id) {
        return publisherRepository.findById(id)
                .switchIfEmpty(Mono.error(new RuntimeException("Publisher not found with id: " + id)));
    }
}
