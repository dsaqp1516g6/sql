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
	name VARCHAR(50) NOT NULL,
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


-- Users and Some Tokens

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Bean", unhex(md5("beanpass")), "beanandbybear@gmail.com", "Mr Bean");
SELECT @beanid:= id from users where username="Bean";
INSERT INTO user_roles (userid, role) values (@beanid, 'registered');

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Willis", unhex(md5("willispass")), "willisandcristaljungle@gmail.com", "Bruce Willis");
SELECT @bruceid:= id from users where username="Willis";
INSERT INTO user_roles (userid, role) values (@bruceid, 'registered');

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Spidi", unhex(md5("spidipass")), "spidiandhisnet@gmail.com", "Peter Parker");
SELECT @id:= id from users where username="Spidi";
INSERT INTO user_roles (userid, role) values (@id, 'registered');

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Kevin", unhex(md5("kevinpass")), "americanbeauty@gmail.com", "Kevin Spacey");
SELECT @kevinid:= id from users where username="Kevin";
INSERT INTO user_roles (userid, role) values (@kevinid, 'registered');
INSERT INTO auth_tokens (userid, token) values (@kevinid, unhex(REPLACE(UUID(),'-','')));

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Jimmy", unhex(md5("jimmypass")), "LikeGod@gmail.com", "Jim Carrey");
SELECT @id:= id from users where username="Jimmy";
INSERT INTO user_roles (userid, role) values (@id, 'registered');

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Greg", unhex(md5("gregpass")), "everybodylies@gmail.com", "Gregory House");
SELECT @houseid:= id from users where username="Greg";
INSERT INTO user_roles (userid, role) values (@houseid, 'registered');
INSERT INTO auth_tokens (userid, token) values (@houseid, unhex(REPLACE(UUID(),'-','')));

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "John", unhex(md5("johnpass")), "bastarddied_ornot@gmail.com", "John Snow");
SELECT @id:= id from users where username="John";
INSERT INTO user_roles (userid, role) values (@id, 'registered');

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Teddy", unhex(md5("teddypass")), "youwhantmarrieme@gmail.com", "Ted Mosby");
SELECT @id:= id from users where username="Teddy";
INSERT INTO user_roles (userid, role) values (@id, 'registered');
INSERT INTO auth_tokens (userid, token) values (@id, unhex(REPLACE(UUID(),'-','')));

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Heisenberg", unhex(md5("metapass")), "bluemeta@gmail.com", "Walter White");
SELECT @whiteid:= id from users where username="Heisenberg";
INSERT INTO user_roles (userid, role) values (@whiteid, 'registered');
INSERT INTO auth_tokens (userid, token) values (@whiteid, unhex(REPLACE(UUID(),'-','')));

insert into users (id, username, password, email, fullname)
values (unhex(REPLACE(UUID(),'-','')), "Barney_TheAdmin", unhex(md5("barneypass")), "ThisgonnabeLegenWhaitForIt@dary.com", "Barney Stinson");
SELECT @barneyid:= id from users where username="Barney_TheAdmin";
INSERT INTO user_roles (userid, role) values (@barneyid, 'administrator');
INSERT INTO auth_tokens (userid, token) values (@barneyid, unhex(REPLACE(UUID(),'-','')));


insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "California", -84.902344, 30.059586);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Sidney", 140.097656, -35.254591);
SELECT @sidneyid:= id from interestpoints where name="Sidney";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Madagascar", 46.582031, -21.053744);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Argentina", -73.300781, -49.217597);
SELECT @argentinaid:= id from interestpoints where name="Argentina";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "New York", -72.246094, 40.638967);
SELECT @nyid:= id from interestpoints where name="New York";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Japan", 137.636719, 36.518466);
SELECT @japanid:= id from interestpoints where name="Japan";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Alaska", -150.996094, 65.906139);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Oslo", 7.207031, 60.538372);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Mexico", -102.480469, 22.826820);
SELECT @mexicoid:= id from interestpoints where name="Mexico";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Indian", 78.574219, 19.549437);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Las Vegas", -120.761719, 37.640335);
SELECT @lasvegasid:= id from interestpoints where name="Las Vegas";

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "Ontario", -69.785156, 53.061025);

insert into interestpoints (id, name, longitude, latitude) 
values (unhex(REPLACE(UUID(),'-','')), "London", -1.933594, 52.422523);
SELECT @londonid:= id from interestpoints where name="London";


-- Comments

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @sidneyid, @kevinid, "What is that shit? I prefer washinton and white house");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @londonid, @beanid, "Me and my bear always walk for the city, and it's so cool");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @nyid, @barneyid, "This city is legen wait for it dary, legendary!");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @nyid, @houseid, "Everybody lies in new york too...");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @japanid, @bruceid, "I like go to japan destroy all and shoting to the bad gays");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @mexicoid, @whiteid, "If you whant to cook meta better go to new mexico");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @argentinaid, @bruceid, "Its so nice shoting people and destroy everything");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @lasvegasid, @barneyid, "With my duckie toe I win a lot in las vegas!");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @londonid, @kevinid, "This sucks too because is not DC");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @lasvegasid, @beanid, "I do not like bet!");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @argentinaid, @whiteid, "I hope my blue meta is already here");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @japanid, @houseid, "People do not change");

insert into comments (id, pointid, userid, text) 
values (unhex(REPLACE(UUID(),'-','')), @nyid, @kevinid, "This is better, in NY you can smell the power closer");


-- Photos

insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @nyid, @kevinid);
SELECT @p1:= id from photos where pointid=@nyid and userid=@kevinid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @londonid, @beanid);
SELECT @p2:= id from photos where pointid=@londonid and userid=@beanid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @nyid, @barneyid);
SELECT @p3:= id from photos where pointid=@nyid and userid=@barneyid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @mexicoid, @whiteid);
SELECT @p4:= id from photos where pointid=@mexicoid and userid=@whiteid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @sidneyid, @bruceid);
SELECT @p5:= id from photos where pointid=@sidneyid and userid=@bruceid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @nyid, @houseid);
SELECT @p6:= id from photos where pointid=@nyid and userid=@houseid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @lasvegasid, @beanid);
SELECT @p7:= id from photos where pointid=@lasvegasid and userid=@beanid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @japanid, @kevinid);
SELECT @p8:= id from photos where pointid=@japanid and userid=@kevinid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @argentinaid, @houseid);
SELECT @p9:= id from photos where pointid=@argentinaid and userid=@houseid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @lasvegasid, @barneyid);
SELECT @p10:= id from photos where pointid=@lasvegasid and userid=@barneyid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @londonid, @bruceid);
SELECT @p11:= id from photos where pointid=@londonid and userid=@bruceid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @argentinaid, @whiteid);
SELECT @p12:= id from photos where pointid=@argentinaid and userid=@whiteid;
insert into photos (id, pointid, userid) values (unhex(REPLACE(UUID(),'-','')), @nyid, @beanid);
SELECT @p13:= id from photos where pointid=@nyid and userid=@beanid;


-- Rating Points

insert into rating_points (pointid, userid, rating) values (@nyid, @kevinid, 5);
insert into rating_points (pointid, userid, rating) values (@londonid, @beanid, 5);
insert into rating_points (pointid, userid, rating) values (@nyid, @barneyid, 5);
insert into rating_points (pointid, userid, rating) values (@sidneyid, @bruceid, 2.5);
insert into rating_points (pointid, userid, rating) values (@nyid, @houseid, 1);
insert into rating_points (pointid, userid, rating) values (@lasvegasid, @beanid, 0.5);
insert into rating_points (pointid, userid, rating) values (@japanid, @kevinid, 1);
insert into rating_points (pointid, userid, rating) values (@argentinaid, @houseid, 1.5);
insert into rating_points (pointid, userid, rating) values (@lasvegasid, @barneyid, 5);
insert into rating_points (pointid, userid, rating) values (@londonid, @bruceid, 4);
insert into rating_points (pointid, userid, rating) values (@argentinaid, @whiteid, 3);
insert into rating_points (pointid, userid, rating) values (@nyid, @beanid, 3);



-- Rating Photos

insert into rating_photos (photoid, userid, rating) values (@p1, @kevinid, 5);
insert into rating_photos (photoid, userid, rating) values (@p2, @beanid, 5);
insert into rating_photos (photoid, userid, rating) values (@p3, @barneyid, 5);
insert into rating_photos (photoid, userid, rating) values (@p4, @whiteid, 4);
insert into rating_photos (photoid, userid, rating) values (@p5, @bruceid, 2.5);
insert into rating_photos (photoid, userid, rating) values (@p6, @houseid, 1);
insert into rating_photos (photoid, userid, rating) values (@p7, @beanid, 0.5);
insert into rating_photos (photoid, userid, rating) values (@p8, @kevinid, 1);
insert into rating_photos (photoid, userid, rating) values (@p9, @houseid, 1.5);
insert into rating_photos (photoid, userid, rating) values (@p10, @barneyid, 5);
insert into rating_photos (photoid, userid, rating) values (@p1, @bruceid, 4);
insert into rating_photos (photoid, userid, rating) values (@p1, @whiteid, 3);
insert into rating_photos (photoid, userid, rating) values (@p3, @beanid, 3);



-- User Points 

insert into user_points (pointid, userid, status) values (@nyid, @kevinid, "visited");
insert into user_points (pointid, userid, status) values (@lasvegasid, @beanid, "pendent");
insert into user_points (pointid, userid, status) values (@lasvegasid, @barneyid, "visited");
insert into user_points (pointid, userid, status) values (@lasvegasid, @whiteid, "pendent");
insert into user_points (pointid, userid, status) values (@londonid, @bruceid, "visited");
insert into user_points (pointid, userid, status) values (@nyid, @houseid, "pendent");
insert into user_points (pointid, userid, status) values (@sidneyid, @beanid, "visited");
insert into user_points (pointid, userid, status) values (@japanid, @kevinid, "pendent");
insert into user_points (pointid, userid, status) values (@argentinaid, @houseid, "visited");
insert into user_points (pointid, userid, status) values (@nyid, @barneyid, "pendent");
insert into user_points (pointid, userid, status) values (@japanid, @bruceid, "visited");
insert into user_points (pointid, userid, status) values (@argentinaid, @whiteid, "pendent");
insert into user_points (pointid, userid, status) values (@londonid, @beanid, "visited");