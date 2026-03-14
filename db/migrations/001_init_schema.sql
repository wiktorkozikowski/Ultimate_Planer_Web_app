CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

Create TABLE IF NOT EXISTS user_auth_local (
    userid INTIGER PRYMERY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHER(255) NOT NULL,
    password_change_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

)
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
        CHECK (user_id <> friend_id)
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
    priority VARCHAR(50) NOT NULL,
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
    priority VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP WITH TIME ZONE,

    CONSTRAINT fk_subtasks_task
        FOREIGN KEY (task_id)
        REFERENCES tasks(id)
        ON DELETE CASCADE
);