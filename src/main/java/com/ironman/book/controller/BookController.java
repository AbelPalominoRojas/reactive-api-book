package com.ironman.book.controller;

import com.ironman.book.dto.book.BookDetailResponse;
import com.ironman.book.dto.book.BookRequest;
import com.ironman.book.dto.book.BookResponse;
import com.ironman.book.dto.book.BookSummaryResponse;
import com.ironman.book.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    Mono<ResponseEntity<Flux<BookSummaryResponse>>> findAll() {
        return Mono.just(ResponseEntity
                .status(HttpStatus.OK)
                .body(bookService.findAll())
        );
    }

    @GetMapping("/{id}")
    Mono<ResponseEntity<BookDetailResponse>> findById(@PathVariable("id") Integer id) {
        return bookService.findById(id)
                .map(bookDetailResponse -> ResponseEntity
                        .status(HttpStatus.OK)
                        .body(bookDetailResponse)
                );
    }

    @PostMapping
    Mono<ResponseEntity<BookResponse>> create(@RequestBody BookRequest bookRequest) {
        return bookService.create(bookRequest)
                .map(bookResponse -> ResponseEntity
                        .status(HttpStatus.CREATED)
                        .body(bookResponse)
                );
    }

    @PutMapping("/{id}")
    Mono<ResponseEntity<BookResponse>> update(@PathVariable("id") Integer id, @RequestBody BookRequest bookRequest) {
        return bookService.update(id, bookRequest)
                .map(bookResponse -> ResponseEntity
                        .status(HttpStatus.OK)
                        .body(bookResponse)
                );
    }

    @DeleteMapping("/{id}")
    Mono<ResponseEntity<BookResponse>> deleteById(@PathVariable("id") Integer id) {
        return bookService.deleteById(id)
                .map(bookResponse -> ResponseEntity
                        .status(HttpStatus.OK)
                        .body(bookResponse)
                );
    }

}
