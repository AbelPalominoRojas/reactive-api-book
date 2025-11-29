package com.ironman.book.util;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class Constant {
    public static final String MESSAGE_INVALID_INPUT_DATA = "Invalid input data. Verify format and values.";
    public static final String MESSAGE_INTERNAL_ERROR = "Internal server error. Contact administrator.";
    public static final String MESSAGE_UNEXPECTED_ERROR = "Unexpected error. Please try again later.";
    public static final String MESSAGE_BUSINESS_RULES_VIOLATION = "Business rule violation detected. Validate and resubmit your request.";
    public static final String MESSAGE_RESOURCE_NOT_FOUND = "Requested resource not found. Verify the identifier and try again.";
}
