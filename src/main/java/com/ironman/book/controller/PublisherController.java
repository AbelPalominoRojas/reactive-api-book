package com.ironman.book.controller;

import com.ironman.book.entity.Publisher;
import com.ironman.book.repository.PublisherRepository;
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

    private final PublisherRepository publisherRepository;

    @GetMapping
    Flux<Publisher> findAll() {
        return publisherRepository.findAll();
    }


    @GetMapping("/{id}")
    Mono<Publisher> findById(@PathVariable("id") Integer id) {
        return publisherRepository.findById(id);
    }
}
