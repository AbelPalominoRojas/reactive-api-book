package com.ironman.book.controller;

import com.ironman.book.dto.publisher.PublisherDetailResponse;
import com.ironman.book.dto.publisher.PublisherOverviewResponse;
import com.ironman.book.dto.publisher.PublisherRequest;
import com.ironman.book.dto.publisher.PublisherResponse;
import com.ironman.book.exception.ExceptionResponse;
import com.ironman.book.service.PublisherService;
import com.ironman.book.util.HttpStatusCode;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

    @ApiResponse(
            responseCode = HttpStatusCode.OK,
            description = "Successfully retrieved list of publishers",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    array = @ArraySchema(
                            schema = @Schema(
                                    implementation = PublisherOverviewResponse.class
                            )
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.INTERNAL_SERVER_ERROR,
            description = "Internal server error occurred while retrieving publishers",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @GetMapping
    Mono<ResponseEntity<Flux<PublisherOverviewResponse>>> findAll() {
        return Mono.just(
                ResponseEntity
                        .status(HttpStatus.OK)
                        .body(publisherService.findAll())
        );
    }


    @ApiResponse(
            responseCode = HttpStatusCode.OK,
            description = "Successfully retrieved publisher details",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = PublisherDetailResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.NOT_FOUND,
            description = "Publisher not found with the given ID",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.INTERNAL_SERVER_ERROR,
            description = "Internal server error occurred while retrieving publisher details",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @GetMapping("/{id}")
    Mono<ResponseEntity<PublisherDetailResponse>> findById(@PathVariable("id") Integer id) {
        return publisherService.findById(id)
                .map(publisherDetailResponse ->
                        ResponseEntity
                                .status(HttpStatus.OK)
                                .body(publisherDetailResponse)
                );
    }


    @ApiResponse(
            responseCode = HttpStatusCode.CREATED,
            description = "Successfully created a new publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = PublisherResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.BAD_REQUEST,
            description = "Invalid input data for creating a publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.CONFLICT,
            description = "Publisher with the given code already exists",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.INTERNAL_SERVER_ERROR,
            description = "Internal server error occurred while creating a publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @PostMapping
    Mono<ResponseEntity<PublisherResponse>> create(@RequestBody @Valid PublisherRequest publisherRequest) {
        return publisherService.create(publisherRequest)
                .map(publisherResponse ->
                        ResponseEntity
                                .status(HttpStatus.CREATED)
                                .body(publisherResponse)
                );
    }


    @ApiResponse(
            responseCode = HttpStatusCode.OK,
            description = "Successfully updated the publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = PublisherResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.BAD_REQUEST,
            description = "Invalid input data for updating the publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.NOT_FOUND,
            description = "Publisher not found with the given ID",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.INTERNAL_SERVER_ERROR,
            description = "Internal server error occurred while updating the publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @PutMapping("/{id}")
    Mono<ResponseEntity<PublisherResponse>> update(
            @PathVariable("id") Integer id,
            @RequestBody @Valid PublisherRequest publisherRequest
    ) {
        return publisherService.update(id, publisherRequest)
                .map(publisherResponse ->
                        ResponseEntity
                                .status(HttpStatus.OK)
                                .body(publisherResponse)
                );
    }

    @ApiResponse(
            responseCode = HttpStatusCode.OK,
            description = "Successfully deleted the publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = PublisherResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.NOT_FOUND,
            description = "Publisher not found with the given ID",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @ApiResponse(
            responseCode = HttpStatusCode.INTERNAL_SERVER_ERROR,
            description = "Internal server error occurred while deleting the publisher",
            content = @Content(
                    mediaType = MediaType.APPLICATION_JSON_VALUE,
                    schema = @Schema(
                            implementation = ExceptionResponse.class
                    )
            )
    )
    @DeleteMapping("/{id}")
    Mono<ResponseEntity<PublisherResponse>> deleteById(@PathVariable("id") Integer id) {
        return publisherService.deleteById(id)
                .map(publisherResponse ->
                        ResponseEntity
                                .status(HttpStatus.OK)
                                .body(publisherResponse)
                );
    }


}
