-- 1) 建庫並選中（已存在就跳過）
CREATE DATABASE IF NOT EXISTS bag2bag_trade
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
USE bag2bag_trade;

-- 為確保乾淨，先關外鍵檢查，刪舊表（若存在）
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS item_photos;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

-- 2) 依賴順序：users → user_profiles → categories → items → item_photos → favorites → messages

-- 使用者（登入）
CREATE TABLE users (
                       id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       upi VARCHAR(64) UNIQUE,
                       username VARCHAR(64) UNIQUE,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 使用者個資
CREATE TABLE user_profiles (
                               user_id BIGINT PRIMARY KEY,
                               picture_url VARCHAR(512),
                               major VARCHAR(128),
                               study_year TINYINT,
                               nationality VARCHAR(64),
                               phone VARCHAR(32),
                               age TINYINT,
                               CONSTRAINT fk_profile_user
                                   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 類別
CREATE TABLE categories (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(64) UNIQUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 物品
CREATE TABLE items (
                       id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       owner_id BIGINT NOT NULL,
                       title VARCHAR(128) NOT NULL,
                       description TEXT,
                       category_id INT,
                       `condition` ENUM('new','like_new','good','fair','poor') DEFAULT 'good',
                       transaction_type ENUM('sell','exchange','both') NOT NULL,
                       price DECIMAL(10,2),
                       original_price DECIMAL(10,2),
                       expected_price DECIMAL(10,2),
                       bought_date DATE,
                       status ENUM('active','reserved','sold','removed') DEFAULT 'active',
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       CONSTRAINT fk_item_owner
                           FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE,
                       CONSTRAINT fk_item_category
                           FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 物品圖片
CREATE TABLE item_photos (
                             id BIGINT PRIMARY KEY AUTO_INCREMENT,
                             item_id BIGINT NOT NULL,
                             url VARCHAR(512) NOT NULL,
                             sort_order INT DEFAULT 0,
                             CONSTRAINT fk_photo_item
                                 FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 收藏（去重）
CREATE TABLE favorites (
                           user_id BIGINT NOT NULL,
                           item_id BIGINT NOT NULL,
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (user_id, item_id),
                           CONSTRAINT fk_fav_user
                               FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                           CONSTRAINT fk_fav_item
                               FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 私訊 / 貼文留言（可 Thread）
CREATE TABLE messages (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          sender_id BIGINT NOT NULL,
                          receiver_id BIGINT NOT NULL,
                          item_id BIGINT NULL,
                          content TEXT NOT NULL,
                          parent_message_id BIGINT NULL,
                          created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          read_at DATETIME NULL,
                          CONSTRAINT fk_msg_sender
                              FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
                          CONSTRAINT fk_msg_receiver
                              FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
                          CONSTRAINT fk_msg_item
                              FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
                          CONSTRAINT fk_msg_parent
                              FOREIGN KEY (parent_message_id) REFERENCES messages(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
