package com.ironman.book.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;

// Lombok annotations
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

// JPA Entity
@Entity
@Table(name = "books")
public class Book implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "isbn", length = 100)
    private String isbn;

    @Column(name = "title", length = 300)
    private String title;

    @Column(name = "authors", length = 300)
    private String authors;

    @Column(name = "edition", length = 100)
    private String edition;

    @Column(name = "publication_year")
    private Integer publicationYear;

    @Column(name = "publisher_id", nullable = false)
    private Integer publisherId;

    @ManyToOne
    @JoinColumn(name = "publisher_id", insertable = false, updatable = false)
    private Publisher publisher;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false, insertable = false)
    private LocalDateTime createdAt;

    @Column(name = "status", nullable = false)
    private Integer status;

}