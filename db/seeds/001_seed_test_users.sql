INSERT INTO users (id, display_name, created_at) VALUES
(1, 'User_1', '2024-05-20T04:37:23Z'),
(2, 'User_2', '2025-12-12T11:48:43Z'),
(3, 'User_3', '2026-03-05T03:12:57Z'),
(4, 'User_4', '2026-04-09T12:05:12Z');

INSERT INTO user_auth_local (user_id, username, email, password_hash, password_changed_at, failed_attempts, locked_until) VALUES
(1, 'user_1', 'user_1@example.com', '$2b$12$8N7oBfP/JQhElr7hMynRzeARr5P6oQm06ZtR6su6z93TrjvQ6g5jS', '2024-05-20T04:37:23Z', 0, NULL),
(2, 'user_2', 'user_2@example.com', '$2b$12$8N7oBfP/JQhElr7hMynRzeARr5P6oQm06ZtR6su6z93TrjvQ6g5jS', '2025-12-12T11:48:43Z', 1, NULL),
(3, 'user_3', 'user_3@example.com', '$2b$12$8N7oBfP/JQhElr7hMynRzeARr5P6oQm06ZtR6su6z93TrjvQ6g5jS', '2026-03-05T03:12:57Z', 0, NULL),
(4, 'user_4', 'user_4@example.com', '$2b$12$8N7oBfP/JQhElr7hMynRzeARr5P6oQm06ZtR6su6z93TrjvQ6g5jS', '2026-04-09T12:05:12Z', 0, NULL);
