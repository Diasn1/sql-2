CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE newspapers (
    newspaper_id SERIAL PRIMARY KEY,
    newspaper_name VARCHAR(100) NOT NULL
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    newspaper_id INT REFERENCES newspapers(newspaper_id),
    subscribe_date DATE NOT NULL
);

INSERT INTO users (username, email) VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@example.com'),
    ('user3', 'user3@example.com');

INSERT INTO newspapers (newspaper_name) VALUES
    ('Newspaper A'),
    ('Newspaper B'),
    ('Newspaper C');

INSERT INTO subscriptions (user_id, newspaper_id, subscribe_date) VALUES
    (1, 1, '2023-01-01'),
    (1, 2, '2023-02-01'),
    (2, 1, '2023-02-15'),
    (3, 3, '2023-03-01');

--подписанные пользователи
SELECT
    n.newspaper_name,
    COUNT(s.user_id) AS subscribed_users
FROM
    newspapers n
LEFT JOIN
    subscriptions s ON n.newspaper_id = s.newspaper_id
GROUP BY
    n.newspaper_name;

--неподписанные пользователи
SELECT
    n.newspaper_name,
    (SELECT COUNT(*) FROM users) - COUNT(s.user_id) AS unsubscribed_users
FROM
    newspapers n
LEFT JOIN
    subscriptions s ON n.newspaper_id = s.newspaper_id
GROUP BY
    n.newspaper_name;