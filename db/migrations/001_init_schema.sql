CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_auth_local (
    user_id INTEGER PRIMARY KEY
        REFERENCES users(id) ON DELETE CASCADE,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    password_changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    failed_attempts INTEGER NOT NULL DEFAULT 0,
    locked_until TIMESTAMP WITH TIME ZONE
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_user_auth_local_email_ci
    ON user_auth_local (LOWER(email));

CREATE TABLE IF NOT EXISTS planners (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('active', 'cancelled', 'completed')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS friends (
    user_id INTEGER NOT NULL,
    friend_id INTEGER NOT NULL,

    PRIMARY KEY (user_id, friend_id),
    CONSTRAINT fk_friends_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_friends_friend
        FOREIGN KEY (friend_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT chk_friends_not_same
        CHECK (user_id <> friend_id),
    CONSTRAINT chk_friends_order
        CHECK (user_id < friend_id)
);

CREATE TABLE IF NOT EXISTS planner_members (
    planner_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('creator', 'editor', 'viewer')),

    PRIMARY KEY (planner_id, user_id),
    CONSTRAINT fk_planner_members_planner
        FOREIGN KEY (planner_id)
        REFERENCES planners(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_planner_members_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    planner_id INTEGER NOT NULL,
    assigned_user_id INTEGER,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    status VARCHAR(50) NOT NULL CHECK (status IN ('active', 'cancelled', 'completed')),
    priority VARCHAR(50) NOT NULL CHECK (priority IN ('low', 'medium', 'high', 'critical')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP WITH TIME ZONE,

    CONSTRAINT fk_tasks_planner
        FOREIGN KEY (planner_id)
        REFERENCES planners(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_tasks_assigned_user
        FOREIGN KEY (assigned_user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS subtasks (
    id SERIAL PRIMARY KEY,
    task_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    status VARCHAR(50) NOT NULL CHECK (status IN ('active', 'cancelled', 'completed')),
    priority VARCHAR(50) NOT NULL CHECK (priority IN ('low', 'medium', 'high', 'critical')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP WITH TIME ZONE,

    CONSTRAINT fk_subtasks_task
        FOREIGN KEY (task_id)
        REFERENCES tasks(id)
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_planner_members_user_id
    ON planner_members (user_id);

CREATE INDEX IF NOT EXISTS idx_tasks_planner_id
    ON tasks (planner_id);

CREATE INDEX IF NOT EXISTS idx_tasks_assigned_user_id
    ON tasks (assigned_user_id);

CREATE INDEX IF NOT EXISTS idx_subtasks_task_id
    ON subtasks (task_id);