package com.ironman.book.repository.jpa;

import com.ironman.book.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookJpaRepository extends JpaRepository<Book, Integer> {
}
