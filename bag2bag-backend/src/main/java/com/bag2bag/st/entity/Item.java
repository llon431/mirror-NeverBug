package com.bag2bag.st.entity;

import com.bag2bag.st.enums.ItemsCondition;
import com.bag2bag.st.enums.ItemsStatus;
import com.bag2bag.st.enums.TransactionType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Item implements Serializable {
    private Long id;
    private Long ownerId;
    private String title;
    private String description;
    private Integer categoryId;

    private ItemsCondition condition;        // ENUM
    private TransactionType transactionType; // ENUM

    private BigDecimal price;
    private BigDecimal originalPrice;
    private BigDecimal expectedPrice;

    private java.time.LocalDate boughtDate;
    private ItemsStatus status;              // ENUM

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedAt;

    // 額外給前端的封面圖（如果你有 item_photos 表）
    private String coverUrl;
}