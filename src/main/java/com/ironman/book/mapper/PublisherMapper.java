package com.ironman.book.mapper;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.dto.publisher.PublisherResponse;
import com.ironman.book.entity.Publisher;
import com.ironman.book.util.StatusEnum;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import static org.mapstruct.MappingConstants.ComponentModel;

@Mapper(
        componentModel = ComponentModel.SPRING,
        imports = {StatusEnum.class}
)
public interface PublisherMapper {

    @Mapping(target = "code", source = "publisherCode")
    @Mapping(target = "name", source = "publisherName")
    PublisherOverviewResponse toOverviewResponse(Publisher publisher);

    @Mapping(target = "code", source = "publisherCode")
    @Mapping(target = "name", source = "publisherName")
    PublisherDetailResponse toDetailResponse(Publisher publisher);

    @Mapping(target = "name", source = "publisherName")
    PublisherResponse toResponse(Publisher publisher);

    @Mapping(target = "publisherCode", source = "code")
    @Mapping(target = "publisherName", source = "name")
    @Mapping(target = "status", expression = "java(StatusEnum.ENABLED.getValue())")
    Publisher toEntity(PublisherRequest publisherRequest);

    @Mapping(target = "publisherCode", source = "code")
    @Mapping(target = "publisherName", source = "name")
    void updateEntity(@MappingTarget Publisher publisher, PublisherRequest publisherRequest);
}