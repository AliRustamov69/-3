CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    category_id INT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

CREATE TABLE Notes (
    note_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted_at DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

CREATE TABLE DeletedNotes (
    deleted_note_id INT PRIMARY KEY IDENTITY(1,1),
    note_id INT NOT NULL,
    deleted_by_user_id INT NULL,
    deleted_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (note_id) REFERENCES Notes(note_id) ON DELETE CASCADE,
    FOREIGN KEY (deleted_by_user_id) REFERENCES Users(user_id) ON DELETE NO ACTION
);

-- Заполнение таблицы Users
INSERT INTO Users (username, password_hash, email, created_at, updated_at)
VALUES 
('user1', 'hashed_password1', 'user1@example.com', GETDATE(), GETDATE()),
('user2', 'hashed_password2', 'user2@example.com', GETDATE(), GETDATE()),
('user3', 'hashed_password3', 'user3@example.com', GETDATE(), GETDATE());

-- Заполнение таблицы Categories
INSERT INTO Categories (name, description, created_at, updated_at)
VALUES 
('Fiction', 'Fictional books', GETDATE(), GETDATE()),
('Non-Fiction', 'Non-Fictional books', GETDATE(), GETDATE()),
('Science', 'Books related to science', GETDATE(), GETDATE());

-- Заполнение таблицы Books
INSERT INTO Books (title, author, category_id, created_at, updated_at)
VALUES 
('Book One', 'Author One', 1, GETDATE(), GETDATE()),
('Book Two', 'Author Two', 2, GETDATE(), GETDATE()),
('Book Three', 'Author Three', 3, GETDATE(), GETDATE());

-- Заполнение таблицы Notes
INSERT INTO Notes (user_id, book_id, content, created_at, updated_at, deleted_at)
VALUES 
(1, 1, 'This is a note for Book One by User One.', GETDATE(), GETDATE(), NULL),
(2, 2, 'This is a note for Book Two by User Two.', GETDATE(), GETDATE(), NULL),
(3, 3, 'This is a note for Book Three by User Three.', GETDATE(), GETDATE(), NULL);

-- Заполнение таблицы DeletedNotes
INSERT INTO DeletedNotes (note_id, deleted_by_user_id, deleted_at)
VALUES 
(1, 1, GETDATE()),  -- Удаление заметки 1 пользователем 1
(2, 2, GETDATE());  -- Удаление заметки 2 пользователем 2
