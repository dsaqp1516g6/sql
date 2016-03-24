drop database if exists secretsitesdb;
create database secretsitesdb;

use secretsitesdb;

CREATE TABLE users (
    id BINARY(16) NOT NULL,
    username VARCHAR(15) NOT NULL UNIQUE,
    password BINARY(16) NOT NULL,
    email VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE user_roles (
    userid BINARY(16) NOT NULL,
    role ENUM ('registered','administrator'),
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (userid, role)
);

CREATE TABLE auth_tokens (
    userid BINARY(16) NOT NULL,
    token BINARY(16) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (token)
);

CREATE TABLE interestpoints (
    id BINARY(16) NOT NULL,
	name VARCHAR(15) NOT NULL,
    longitude REAL NOT NULL,
    latitude REAL NOT NULL,
    creation_timestamp DATETIME not null default current_timestamp,
    PRIMARY KEY (id)
);

CREATE TABLE comments (
    id BINARY(16) NOT NULL,
	pointid BINARY(16) NOT NULL,
	userid BINARY(16) NOT NULL,
    text VARCHAR(500) NOT NULL,
    last_modified TIMESTAMP NOT NULL,
    creation_timestamp DATETIME not null default current_timestamp,
	FOREIGN KEY (pointid) REFERENCES interestpoints(id) on delete cascade,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (id)
);

CREATE TABLE photos (
    id BINARY(16) NOT NULL,
	pointid BINARY(16) NOT NULL,
    userid BINARY(16) NOT NULL,
    upload_timestamp DATETIME not null default current_timestamp,
	FOREIGN KEY (pointid) REFERENCES interestpoints(id) on delete cascade,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (id)
);

CREATE TABLE rating_points (
	pointid BINARY(16) NOT NULL,
    userid BINARY(16) NOT NULL,
    rating REAL NOT NULL,
	FOREIGN KEY (pointid) REFERENCES interestpoints(id) on delete cascade,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (pointid, userid)
);

CREATE TABLE rating_photos (
	photoid BINARY(16) NOT NULL,
    userid BINARY(16) NOT NULL,
    rating REAL NOT NULL,
	FOREIGN KEY (photoid) REFERENCES photos(id) on delete cascade,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (photoid, userid)
);

CREATE TABLE user_points (
	pointid BINARY(16) NOT NULL,
    userid BINARY(16) NOT NULL,
	status ENUM ('visited','pendent'),
	FOREIGN KEY (pointid) REFERENCES interestpoints(id) on delete cascade,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (pointid, userid)
);