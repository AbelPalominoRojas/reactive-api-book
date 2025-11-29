package com.ironman.book.repository;

import com.ironman.book.entity.Publisher;
import com.ironman.book.mock.PublisherMock;
import com.ironman.book.repository.impl.PublisherRepositoryImpl;
import com.ironman.book.repository.jpa.PublisherJpaRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
class PublisherRepositoryTest {

    @Mock
    private PublisherJpaRepository publisherJpaRepository;

    @InjectMocks
    private PublisherRepositoryImpl publisherRepository;

    @Captor
    private ArgumentCaptor<Publisher> publisherCaptor;

    private static Stream<Arguments> provideSaveCasesPublisher() {
        return Stream.of(
                Arguments.of( // New Publisher creation
                        PublisherMock.getCreatePublisher(),
                        1, // Database generates ID
                        LocalDateTime.now() // Creation timestamp generated
                ),
                Arguments.of( // Existing Publisher update
                        PublisherMock.getPublisher(),
                        PublisherMock.getPublisher().getId(),
                        PublisherMock.getPublisher().getCreatedAt()
                )
        );
    }

    private static void expectedResult(Publisher publisher, Publisher expectedPublisher) {
        assertEquals(expectedPublisher.getId(), publisher.getId());
        assertEquals(expectedPublisher.getPublisherCode(), publisher.getPublisherCode());
        assertEquals(expectedPublisher.getPublisherName(), publisher.getPublisherName());
        assertEquals(expectedPublisher.getStatus(), publisher.getStatus());
        assertNotNull(publisher.getCreatedAt());
    }

    @Test
    void returnPublishersWhenExists() {
        // Given
        var expectedPublisher = PublisherMock.getPublisher();

        given(publisherJpaRepository.findAll()).willReturn(List.of(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherRepository.findAll())
                .expectNextMatches(publisher -> {
                    expectedResult(publisher, expectedPublisher);
                    return true;
                })
                .verifyComplete();
    }

    @Test
    void returnPublisherWhenExistingById() {
        // Given
        Integer id = 5;
        var expectedPublisher = PublisherMock.getPublisherById(id);

        given(publisherJpaRepository.findById(anyInt())).willReturn(Optional.of(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherRepository.findById(id))
                .expectNextMatches(publisher -> {
                    expectedResult(publisher, expectedPublisher);
                    return true;
                })
                .verifyComplete();
    }


    @Test
    void returnPublisherWhenExistingByPublisherCode() {
        // Given
        String publisherCode = "PUB123";
        var expectedPublisher = PublisherMock.getPublisherByCode(publisherCode);

        given(publisherJpaRepository.findByPublisherCode(publisherCode)).willReturn(Optional.of(expectedPublisher));

        // When & Then
        StepVerifier.create(publisherRepository.findByPublisherCode(publisherCode))
                .expectNextMatches(publisher -> {
                    expectedResult(publisher, expectedPublisher);
                    return true;
                })
                .verifyComplete();
    }

    @MethodSource("provideSaveCasesPublisher")
    @ParameterizedTest
    void returnPublishersWhenCreateSuccessful(Publisher expectedPublisher, Integer expectedId, LocalDateTime expectedCreatedAt) {
        // Given
        given(publisherJpaRepository.save(publisherCaptor.capture()))
                .willAnswer(invocation -> {
                    Publisher publisher = invocation.getArgument(0);
                    publisher.setId(expectedId);
                    publisher.setCreatedAt(expectedCreatedAt);
                    return publisher;
                });

        // When & Then
        StepVerifier.create(publisherRepository.save(expectedPublisher))
                .expectNextMatches(publisher -> {
                    assertNotNull(publisher.getId());
                    assertEquals(expectedPublisher.getPublisherCode(), publisher.getPublisherCode());
                    assertEquals(expectedPublisher.getPublisherName(), publisher.getPublisherName());
                    assertEquals(expectedPublisher.getStatus(), publisher.getStatus());
                    assertNotNull(publisher.getCreatedAt());

                    return true;
                })
                .verifyComplete();
    }


}