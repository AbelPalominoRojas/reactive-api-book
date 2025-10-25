package com.ironman.book.util;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

// Lombok annotation
@Getter
@RequiredArgsConstructor
public enum StatusEnum {
    ENABLED(1),
    DISABLED(0);

    private final int value;

}
