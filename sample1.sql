(base) thomas@HP-EliteBook-8440p-66d29261:~$ sudo -i -u postgres
[sudo] password for thomas:            
postgres@HP-EliteBook-8440p-66d29261:~$ psql
psql (14.12 (Ubuntu 14.12-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# CREATE DATABASE mgm;
CREATE DATABASE
postgres=# /c mgm
postgres-# \dt
Did not find any relations.
postgres-# \du
postgres-# \l
postgres-# \c mgm
You are now connected to database "mgm" as user "postgres".

mgm=# CREATE TABLE x(id SERIAL,x_name VARCHAR  ,x_password VARCHAR  );
CREATE TABLE
mgm=# SELECT * FROM x;
 id | x_name | x_password 
----+--------+------------
(0 rows)


mgm=# CREATE TABLE x(id SERIAL,x_name VARCHAR UNIQUE  ,x_password VARCHAR UNIQUE  );
CREATE TABLE
mgm=# CREATE TABLE y(id SERIAL ,y_name VARCHAR  REFERENCES x(x_name) ,y_pass VARCHAR  REFERENCES x(x_password));
CREATE TABLE
mgm=# SELECT * FROM y;
 id | y_name | y_pass 
----+--------+--------
(0 rows)


mgm=# INSERT INTO x (x_name, x_password) VALUES ('brian', 'brianMars2020');
INSERT 0 1
mgm=# SELECT * FROM y;
 id | y_name | y_pass 
----+--------+--------
(0 rows)

mgm=# SELECT * FROM y;
 id | y_name | y_pass 
----+--------+--------
(0 rows)

mgm=# INSERT INTO y (y_name,y_pass) VALUES ('brian', 'brianMars2020');
INSERT 0 1

mgm=# CREATE TABLE z (id SERIAL ,z_name TEXT   UNIQUE REFERENCES x(x_name),z_pass TEXT);
CREATE TABLE

mgm=# INSERT INTO z(z_name,z_pass) VALUES('brian','wea223sd');
INSERT 0 1
mgm=# SELECT * FROM z;
 id | z_name |  z_pass  
----+--------+----------
  1 | brian  | wea223sd
(1 row)


mgm=# CREATE TABLE x_y_z(x_y_z_name VARCHAR REFERENCES z(z_name),x_y_z_pass VARCHAR REFERENCES x(x_password),PRIMARY KEY(x_y_z_name,x_y_z_pass));
CREATE TABLE

mgm=# SELECT * FROM x_y_z;
 x_y_z_name | x_y_z_pass 
------------+------------
(0 rows)


mgm=# DROP TABLE x_y_z;
DROP TABLE
mgm=# CREATE TABLE x_y_z(x_y_z_name VARCHAR REFERENCES z(z_name),x_y_z_pass VARCHAR REFERENCES x(x_password),PRIMARY KEY(x_y_z_name,x_y_z_pass));
CREATE TABLE
mgm=# INSERT INTO x_y_z (x_y_z_name,x_y_z_pass) VALUES('brian','brianMars2020');
INSERT 0 1
mgm=# SELECT * FROM x_y_z ;
 x_y_z_name |  x_y_z_pass   
------------+---------------
 brian      | brianMars2020
(1 row)

mgm=# CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE
);

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE
);

CREATE TABLE user_projects (
    user_id INT REFERENCES users(id),
    project_id INT REFERENCES projects(id),
    PRIMARY KEY (user_id, project_id)
);
CREATE TABLE
CREATE TABLE
CREATE TABLE
mgm=# SELECT u.name AS user_name, p.name AS project_name
FROM users u
JOIN user_projects up ON u.id = up.user_id
JOIN projects p ON p.id = up.project_id
WHERE u.id = 1;
 user_name | project_name 
-----------+--------------
(0 rows)

mgm=# INSERT INTO users (name) VALUES ('Alice'), ('Bob');
INSERT INTO projects (name) VALUES ('Project1'), ('Project2');
INSERT INTO user_projects (user_id, project_id) VALUES (1, 1), (1, 2), (2, 1);
INSERT 0 2
INSERT 0 2
INSERT 0 3
mgm=# SELECT * FROM user_projects;
 user_id | project_id 
---------+------------
       1 |          1
       1 |          2
       2 |          1
(3 rows)

mgm=# SELECT u.name AS user_name, p.name AS project_name
FROM users u
JOIN user_projects up ON u.id = up.user_id
JOIN projects p ON p.id = up.project_id
WHERE u.id = 1;
 user_name | project_name 
-----------+--------------
 Alice     | Project1
 Alice     | Project2
(2 rows)

mgm=# 
