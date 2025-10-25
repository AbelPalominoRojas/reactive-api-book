package com.ironman.book.controller;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.service.PublisherService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

// Lombok annotations
@RequiredArgsConstructor

// Spring annotations
@RestController
@RequestMapping("/publishers")
public class PublisherController {

    private final PublisherService publisherService;

    @GetMapping
    Flux<PublisherOverviewResponse> findAll() {
        return publisherService.findAll();
    }


    @GetMapping("/{id}")
    Mono<PublisherDetailResponse> findById(@PathVariable("id") Integer id) {
        return publisherService.findById(id);
    }
}
