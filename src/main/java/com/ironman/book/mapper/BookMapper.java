package com.ironman.book.mapper;

import com.ironman.book.dto.book.*;
import com.ironman.book.entity.Book;
import com.ironman.book.util.StatusEnum;
import org.mapstruct.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING,
        imports = {StatusEnum.class, PublisherMapper.class},
        injectionStrategy = InjectionStrategy.CONSTRUCTOR
)
public interface BookMapper {
    BookDetailResponse toDetailResponse(Book book);

    BookOverviewResponse toOverviewResponse(Book book);

    BookSummaryResponse toSummaryResponse(Book book);

    BookResponse toResponse(Book book);

    @Mapping(target = "status", expression = "java(StatusEnum.ENABLED.getValue())")
    Book toEntity(BookRequest request);

    void updateEntity(@MappingTarget Book book, BookRequest request);
}
