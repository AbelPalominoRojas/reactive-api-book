package com.ironman.book.controller;

import com.ironman.book.dto.book.BookDetailResponse;
import com.ironman.book.dto.book.BookRequest;
import com.ironman.book.dto.book.BookResponse;
import com.ironman.book.dto.book.BookSummaryResponse;
import com.ironman.book.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

// Lombok annotations
@RequiredArgsConstructor

// Spring annotations
@RestController
@RequestMapping("/books")
public class BookController {
    private final BookService bookService;

    @GetMapping
    Flux<BookSummaryResponse> findAll() {
        return bookService.findAll();
    }

    @GetMapping("/{id}")
    Mono<BookDetailResponse> findById(@PathVariable("id") Integer id) {
        return bookService.findById(id);
    }

    @PostMapping
    Mono<BookResponse> create(@RequestBody BookRequest bookRequest) {
        return bookService.create(bookRequest);
    }

    @PutMapping("/{id}")
    Mono<BookResponse> update(@PathVariable("id") Integer id, @RequestBody BookRequest bookRequest) {
        return bookService.update(id, bookRequest);
    }

    @DeleteMapping("/{id}")
    Mono<BookResponse> deleteById(@PathVariable("id") Integer id) {
        return bookService.deleteById(id);
    }

}
