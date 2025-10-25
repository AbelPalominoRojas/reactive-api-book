package com.ironman.book.controller;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.dto.publisher.PublisherResponse;
import com.ironman.book.service.PublisherService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
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

    @PostMapping
    Mono<PublisherResponse> create(@RequestBody @Valid PublisherRequest publisherRequest) {
        return publisherService.create(publisherRequest);
    }

    @PutMapping("/{id}")
    Mono<PublisherResponse> update(
            @PathVariable("id") Integer id,
            @RequestBody @Valid PublisherRequest publisherRequest
    ) {
        return publisherService.update(id, publisherRequest);
    }

    @DeleteMapping("/{id}")
    Mono<PublisherResponse> deleteById(@PathVariable("id") Integer id) {
        return publisherService.deleteById(id);
    }


}
