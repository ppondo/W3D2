PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    reply_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (reply_id) REFERENCES replies(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
    users (fname, lname)
VALUES
    ('awawawawawa', 'gbgbgbgbgbg'),
    ('bhbhbhbhbh', 'yfyfyfyfyfy'),
    ('ytytytytyt', 'uuhuhuhuhuh');

INSERT INTO 
    questions (title, body, user_id)
VALUES
    ('courage', 'What did you always wanted to try but never found the courage to do',(SELECT users.id FROM users WHERE users.fname = 'awawawawawa')),
    ('nature', 'Do you enjoy being out in nature',(SELECT users.id FROM users WHERE users.fname = 'bhbhbhbhbh')),
    ('fighting', 'fight with someone',(SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'));

INSERT INTO 
    questions_follows (user_id ,question_id)
VALUES
    ((SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'),(SELECT questions.id FROM questions WHERE questions.title = 'courage')),
    ((SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'),(SELECT questions.id FROM questions WHERE questions.title = 'nature')),
    ((SELECT users.id FROM users WHERE users.fname = 'awawawawawa'),(SELECT questions.id FROM questions WHERE questions.title = 'fighting'));


INSERT INTO
    replies (question_id, reply_id, user_id, body)
VALUES
    ((SELECT questions.id FROM questions WHERE questions.title = 'courage'), NULL, (SELECT users.id FROM users WHERE users.fname = 'awawawawawa'),'you should try to jump ff a cliff'),
    ((SELECT questions.id FROM questions WHERE questions.title = 'courage'), (SELECT id FROM replies WHERE body ='you should try to jump ff a cliff'), (SELECT users.id FROM users WHERE users.fname = 'awawawawawa'), 'I never found it'),
    ((SELECT questions.id FROM questions WHERE questions.title = 'nature'), NULL, (SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'), 'you''re a hippy'),
    ((SELECT questions.id FROM questions WHERE questions.title = 'nature'), (SELECT id FROM replies WHERE body ='you''re a hippy'), (SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'), 'this is a body');

INSERT INTO 
    question_likes (user_id, question_id)
VALUES
    ((SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'),(SELECT questions.id FROM questions WHERE questions.title = 'fighting')),
    ((SELECT users.id FROM users WHERE users.fname = 'ytytytytyt'),(SELECT questions.id FROM questions WHERE questions.title = 'nature')),
    ((SELECT users.id FROM users WHERE users.fname = 'awawawawawa'),(SELECT questions.id FROM questions WHERE questions.title = 'courage'));


