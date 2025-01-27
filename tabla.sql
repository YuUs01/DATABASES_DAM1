
CREATE DATABASE ejercicio;
use ejercicio;

CREATE TABLE match_participants (
    match_id int8 NOT NULL,
    avatar_id int8 NOT NULL
);

CREATE TABLE confrontations (
    id INT8 NOT NULL,
    match_id INT8 NOT NULL,
    avatar1_id INT8 NOT NULL,
    avatar2_id INT8 NOT NULL,
    result TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE matches (
    id int8 NOT NULL,
    game_id int8 NOT NULL,
    name text not null,
    password text not null,
    created_at date not null,
    status text not null,
    creator_avatar_id int8 not null,
    PRIMARY KEY(id)
);

CREATE TABLE avatars (
    id int8 not null,
    user_id int8 not null,
    game_id int8 not null,
    appearance text not null,
    level int4 not null,
    PRIMARY KEY (id)
);

CREATE TABLE users (
    id int8 not null,
    name text not null,
    email text not null,
    nick text not null,
    login text not null,
    password text not null,
    birthdate date not null,
    PRIMARY KEY (id)
);

CREATE TABLE games (
    id int8 not null,
    code text not null,
    name text not null,
    PRIMARY KEY (id)
);

SELECT mp.match_id
FROM match_participants mp
JOIN confrontations c ON mp.match_id = c.match_id;

SELECT c.avatar1_id, c.avatar2_id
FROM confrontations c
JOIN matches m ON m.id = c.match_id;

SELECT mp.avatar_id
FROM match_participants mp
JOIN matches m ON mp.match_id = m.id;

SELECT m.creator_avatar_id
FROM matches m
JOIN avatars a ON m.creator_avatar_id = a.id;
