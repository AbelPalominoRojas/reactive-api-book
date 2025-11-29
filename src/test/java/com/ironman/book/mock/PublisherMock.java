package com.ironman.book.mock;

import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.entity.Publisher;
import com.ironman.book.util.StatusEnum;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class PublisherMock {

    public static Publisher buildPublisher(Integer id, String publisherCode ) {
        return Publisher.builder()
                .id(id)
                .publisherCode(publisherCode)
                .publisherName("Publisher " + id)
                .status(StatusEnum.ENABLED.getValue())
                .createdAt(LocalDateTime.now())
                .build();
    }

    public static Publisher getPublisherById(Integer id) {
        return buildPublisher(id, "EDI00364");
    }

    public static Publisher getPublisherByCode(String publisherCode) {
        return buildPublisher(1, publisherCode);
    }

    public static Publisher getPublisher() {
        return getPublisherById(1);
    }

    public static Publisher getCreatePublisher() {
        return getPublisherById(null);
    }

    public static PublisherRequest getPublisherRequest() {
        return PublisherRequest.builder()
                .code("MARV001")
                .name("Marvel Comics")
                .build();
    }

}
