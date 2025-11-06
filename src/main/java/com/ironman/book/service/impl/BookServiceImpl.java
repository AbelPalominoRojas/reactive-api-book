package com.ironman.book.service.impl;

import com.ironman.book.dto.book.BookDetailResponse;
import com.ironman.book.dto.book.BookRequest;
import com.ironman.book.dto.book.BookResponse;
import com.ironman.book.dto.book.BookSummaryResponse;
import com.ironman.book.entity.Book;
import com.ironman.book.mapper.BookMapper;
import com.ironman.book.repository.BookRepository;
import com.ironman.book.service.BookService;
import com.ironman.book.util.StatusEnum;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

// Lombok annotations
@RequiredArgsConstructor

//Spring Stereotype annotation
@Service
public class BookServiceImpl implements BookService {
    private final BookRepository bookRepository;
    private final BookMapper bookMapper;

    @Override
    public Flux<BookSummaryResponse> findAll() {
        return bookRepository.findAll()
                .map(bookMapper::toSummaryResponse);
    }

    @Override
    public Mono<BookDetailResponse> findById(Integer id) {
        return getBookOrElseThrow(id)
                .map(bookMapper::toDetailResponse);
    }

    @Override
    public Mono<BookResponse> create(BookRequest bookRequest) {
        Book book = bookMapper.toEntity(bookRequest);

        return bookRepository.save(book)
                .map(bookMapper::toResponse);
    }

    @Override
    public Mono<BookResponse> update(Integer id, BookRequest bookRequest) {
        return getBookOrElseThrow(id)
                .flatMap(existingBook -> {
                    bookMapper.updateEntity(existingBook, bookRequest);
                    return bookRepository.save(existingBook);
                })
                .map(bookMapper::toResponse);
    }

    @Override
    public Mono<BookResponse> deleteById(Integer id) {
        return getBookOrElseThrow(id)
                .flatMap(existingBook -> {
                    existingBook.setStatus(StatusEnum.DISABLED.getValue());
                    return bookRepository.save(existingBook);
                })
                .map(bookMapper::toResponse);
    }

    Mono<Book> getBookOrElseThrow(Integer id) {
        return bookRepository.findById(id)
                .switchIfEmpty(Mono.error(new RuntimeException("Book not found with id: " + id)));
    }

}
