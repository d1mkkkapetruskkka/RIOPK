-- Создание таблицы Users
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Создание таблицы ролей пользователей
CREATE TABLE users_role (
    users_id BIGINT NOT NULL,
    role ENUM('CLIENT', 'MANAGER') NOT NULL,
    PRIMARY KEY (users_id),
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы клининговых услуг (Ads)
CREATE TABLE ads (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    img LONGBLOB,
    users_id BIGINT NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Создание таблицы бронирований (Reservations)
CREATE TABLE reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    book_date DATETIME NOT NULL,
    reservation_status TINYINT NOT NULL DEFAULT 0 COMMENT '0-ожидает, 1-подтвержден, 2-выполняется, 3-завершен, 4-отменен',
    review_status TINYINT NOT NULL DEFAULT 0 COMMENT '0-нет отзыва, 1-есть отзыв',
    ad_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id) ON DELETE CASCADE
);

-- Создание таблицы связи клиентов и менеджеров для заказов
CREATE TABLE reservation_users (
    client_id BIGINT NOT NULL,
    company_id BIGINT NOT NULL,
    reservation_id BIGINT NOT NULL,
    PRIMARY KEY (client_id, company_id, reservation_id),
    FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы отзывов (Reviews)
CREATE TABLE reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    review_date DATETIME NOT NULL,
    ad_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);