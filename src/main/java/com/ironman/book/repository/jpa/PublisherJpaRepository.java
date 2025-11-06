package com.ironman.book.repository.jpa;

import com.ironman.book.entity.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PublisherJpaRepository extends JpaRepository<Publisher, Integer> {
    Optional<Publisher> findByPublisherCode(String publisherCode);
}
