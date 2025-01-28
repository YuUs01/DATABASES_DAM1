-- Creacion y uso de la base de datos "ejercicio"
CREATE DATABASE ejercicio;
use ejercicio;

-- Creacion de las tablas con sus respectivos atributos
CREATE TABLE match_participants (
    match_id int8 NOT NULL,
    avatar_id int8 NOT NULL,
    PRIMARY KEY (match_id,avatar_id)
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
    email text not null unique,
    nick text not null unique,
    login text not null unique,
    password text not null,
    birthdate date not null,
    PRIMARY KEY (id)
);

CREATE TABLE games (
    id int8 not null,
    code text not null unique,
    name text not null,
    PRIMARY KEY (id)
);

-- Se selecciona el atributo match_id de la tabla match participants, donde se une a la tabla confrontations, con el atributo match_id
SELECT mp.match_id
FROM match_participants mp
JOIN confrontations c ON mp.match_id = c.match_id;

-- Se seleccionan los atributos avatar1_id y avatar2_id de la tabla confrontations, para unirla con la tabla matches, con el atributo creator_avatar_id
SELECT c.avatar1_id, c.avatar2_id
FROM confrontations c
JOIN matches m ON c.avatar1_id && avatar2_id = m.creator_avatar_id;

-- Se selecciona el atributo avatar_id de la tabla match participants, donde se une con la tabla matches
SELECT mp.avatar_id
FROM match_participants mp
JOIN matches m ;

-- Se selecciona el atributo creator_avatar_id de la tabla matches y se une con la tabla avatars, con el atributo id de esta
SELECT m.creator_avatar_id
FROM matches m
JOIN avatars a ON m.creator_avatar_id = a.id;

-- Se selecciona el atributo id de la tabla avatars y se une con la tabla matches, con el atributo creator_avatar_id de esta
SELECT a.id
FROM avatars a
JOIN matches m ON a.id = m.creator_avatar_id;

-- Se selecciona el atributo id de la tabla avatars y se une con la tabla matches, con el atributo creator_avatar_id
SELECT a.id
FROM avatars a
JOIN matches m ON a.id = m.creator_avatar_id;

-- Se selecciona el atributo user_id de la tabla avatars, donde se une con la tabla users mediante el atributo id de esta
SELECT a.user_id
FROM avatars a 
JOIN users u ON a.user_id = u.id;

-- Se selecciona el atributo game_id de la tabla avatars y se une con la tabla games mediante el atributo id de esta
Select a.game_id
FROM avatars a
JOIN games g ON a.game_id = g.id;

-- Se selecciona el atributo id de la tabla games y se une con la tabla matches mediante el atributo game_id
SELECT g.id
FROM games g
JOIN matches m ON g.id = m.game_id;