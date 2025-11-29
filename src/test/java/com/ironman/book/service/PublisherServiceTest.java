package com.ironman.book.service;

import com.ironman.book.entity.Publisher;
import com.ironman.book.mapper.PublisherMapperImpl;
import com.ironman.book.mock.PublisherMock;
import com.ironman.book.repository.PublisherRepository;
import com.ironman.book.service.impl.PublisherServiceImpl;
import com.ironman.book.util.StatusEnum;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
class PublisherServiceTest {

    @Mock
    private PublisherRepository publisherRepository;

    @Spy
    private PublisherMapperImpl publisherMapper;

    @InjectMocks
    private PublisherServiceImpl publisherService;

    @Captor
    private ArgumentCaptor<Publisher> publisherCaptor;

    @Test
    void findAllPublishers() {
        // Given
        var expectedPublisher = PublisherMock.getPublisher();

        given(publisherRepository.findAll()).willReturn(Flux.just(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherService.findAll())
                .expectNextMatches(publisherOverviewResponse -> {
                    assertEquals(expectedPublisher.getId(), publisherOverviewResponse.getId());
                    assertEquals(expectedPublisher.getPublisherCode(), publisherOverviewResponse.getCode());
                    assertEquals(expectedPublisher.getPublisherName(), publisherOverviewResponse.getName());
                    return true;
                })
                .verifyComplete();
    }

    @Test
    void findPublisherById() {
        // Given
        var expectedPublisher = PublisherMock.getPublisher();

        given(publisherRepository.findById(expectedPublisher.getId())).willReturn(Mono.just(expectedPublisher));


        // When & Then
        StepVerifier.create(publisherService.findById(expectedPublisher.getId()))
                .assertNext(publisherDetailResponse -> {
                    assertEquals(expectedPublisher.getId(), publisherDetailResponse.getId());
                    assertEquals(expectedPublisher.getPublisherCode(), publisherDetailResponse.getCode());
                    assertEquals(expectedPublisher.getPublisherName(), publisherDetailResponse.getName());
                    assertEquals(expectedPublisher.getStatus(), publisherDetailResponse.getStatus());
                    assertNotNull(publisherDetailResponse.getCreatedAt());
                })
                .verifyComplete();

    }

    @Test
    void softDeletePublisherById() {
        // Given
        var expectedPublisher = PublisherMock.getPublisher();

        given(publisherRepository.findById(anyInt())).willReturn(Mono.just(expectedPublisher));
        given(publisherRepository.save(isA(Publisher.class))).willReturn(Mono.just(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherService.deleteById(expectedPublisher.getId()))
                .assertNext(publisherResponse -> {
                    assertEquals(expectedPublisher.getId(), publisherResponse.getId());
                    assertEquals(StatusEnum.DISABLED.getValue(), publisherResponse.getStatus());
                })
                .verifyComplete();
    }

    @Test
    void createPublisher() {
        // Given
        var publisherRequest = PublisherMock.getPublisherRequest();
        var expectedPublisher = PublisherMock.getPublisher();
        given(publisherRepository.findByPublisherCode(anyString())).willReturn(Mono.empty());
        given(publisherRepository.save(isA(Publisher.class))).willReturn(Mono.just(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherService.create(publisherRequest))
                .assertNext(publisherResponse -> {
                    assertNotNull(publisherResponse.getId());
                    assertEquals(expectedPublisher.getPublisherName(), publisherResponse.getName());
                    assertEquals(expectedPublisher.getStatus(), publisherResponse.getStatus());
                })
                .verifyComplete();
    }

    @Test
    void createPublisherCaptor() {
        // Given
        var publisherRequest = PublisherMock.getPublisherRequest();

        given(publisherRepository.findByPublisherCode(anyString())).willReturn(Mono.empty());
        given(publisherRepository.save(publisherCaptor.capture()))
                .willAnswer(invocation -> {
                    Publisher publisher = invocation.getArgument(0);
                    publisher.setId(1);
                    publisher.setCreatedAt(LocalDateTime.now());
                    return Mono.just(publisher);
                });

        // When & Then
        StepVerifier.create(publisherService.create(publisherRequest))
                .assertNext(publisherResponse -> {
                    assertNotNull(publisherResponse.getId());
                    assertEquals(publisherRequest.getName(), publisherResponse.getName());
                    assertEquals(StatusEnum.ENABLED.getValue(), publisherResponse.getStatus());
                })
                .verifyComplete();
    }

    @Test
    void updatePublisher() {
        // Given
        Integer id = 10;
        var expectedPublisher = PublisherMock.getPublisherById(id);
        var publisherRequest = PublisherMock.getPublisherRequest();

        given(publisherRepository.findById(anyInt())).willReturn(Mono.just(expectedPublisher));
        given(publisherRepository.save(isA(Publisher.class))).willReturn(Mono.just(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherService.update(id, publisherRequest))
                .assertNext(publisherResponse -> {
                    assertEquals(id, publisherResponse.getId());
                    assertEquals(expectedPublisher.getPublisherName(), publisherResponse.getName());
                    assertEquals(expectedPublisher.getStatus(), publisherResponse.getStatus());
                })
                .verifyComplete();
    }

}