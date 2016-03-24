drop user 'secretsites'@'localhost';
create user 'secretsites'@'localhost' identified by 'secretsites';
grant all privileges on secretsitesdb.* to 'secretsites'@'localhost';
flush privileges;