/* Задание 1.1. Создайте таблицу city с колонками city_id и city_name.*/

skypro=# CREATE TABLE city(
skypro(# city_id BIGSERIAL NOT NULL PRIMARY KEY,
skypro(# city_name VARCHAR(50) NOT NULL
skypro(# );

/* Задание 1.2. Добавьте в таблицу employee колонку city_id.*/

skypro=# ALTER TABLE employee ADD city_id BIGSERIAL NOT NULL;


/* Задание 1.3. Назначьте ее (колонку city_id в таблице employee) внешним ключом и свяжите с таблицей city.*/

skypro=# ALTER TABLE employee ADD FOREIGN KEY(city_id) REFERENCES city(city_id);

/* Задание 1.4. Заполните таблицу city и назначьте работникам соответствующие города.*/

skypro=# INSERT INTO city(city_name) VALUES('Амурск');
skypro=# INSERT INTO city(city_name) VALUES('Биробиджан');
skypro=# INSERT INTO city(city_name) VALUES('Воронеж');
skypro=# INSERT INTO city(city_name) VALUES('Гудермес');

skypro=# UPDATE employee SET city_id = 1 WHERE id = 2;
skypro=# UPDATE employee SET city_id = 4 WHERE id = 3;
skypro=# UPDATE employee SET city_id = 4 WHERE id = 4;
skypro=# UPDATE employee SET city_id = 2 WHERE id = 5;
skypro=# UPDATE employee SET city_id = 2 WHERE id = 6;

skypro=# SELECT * FROM city;
city_id | city_name
---------+------------
       1 | Амурск
       2 | Биробиджан
       3 | Воронеж
       4 | Гудермес
(4 строки)

skypro=# SELECT * FROM employee;
id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
  2 | Борис      | Борисов   | муж    |  30 |       1
  3 | Геннадий   | Генин     | муж    |  33 |       4
  4 | Геннадий   | Дмитриев  | муж    |  15 |       4
  5 | Егор       | Егоров    | муж    |  62 |       2
  6 | Егор       | Захаров   | муж    |  49 |       2
(5 строк)

    /* Задание 2.1. Получите имена и фамилии сотрудников, а также города, в которых они проживают.*/
skypro=# SELECT first_name, last_name, city_name FROM employee INNER JOIN city ON employee.city_id = city.city_id;
first_name | last_name | city_name
------------+-----------+------------
 Борис      | Борисов   | Амурск
 Егор       | Захаров   | Биробиджан
 Егор       | Егоров    | Биробиджан
 Геннадий   | Дмитриев  | Гудермес
 Геннадий   | Генин     | Гудермес
(5 строк)

    /* Задание 2.2. Получите города, а также имена и фамилии сотрудников, которые в них проживают. Если в городе никто
    из сотрудников не живет, то вместо имени должен стоять null.*/

skypro=# SELECT city_name, first_name, last_name FROM city LEFT JOIN employee ON city.city_id = employee.city_id;
city_name  | first_name | last_name
------------+------------+-----------
 Амурск     | Борис      | Борисов
 Биробиджан | Егор       | Захаров
 Биробиджан | Егор       | Егоров
 Воронеж    |            |
 Гудермес   | Геннадий   | Дмитриев
 Гудермес   | Геннадий   | Генин
(6 строк)

    /* Задание 2.3. Получите имена всех сотрудников и названия всех городов. Если в городе не живет никто из сотрудников,
    то вместо имени должен стоять null. Аналогично, если города для какого-то из сотрудников нет в списке,
    так же должен быть получен null.*/
skypro=# SELECT first_name, city_name FROM employee FULL JOIN city ON employee.city_id = city.city_id;
first_name | city_name
------------+------------
 Борис      | Амурск
 Егор       | Биробиджан
 Егор       | Биробиджан
            | Воронеж
 Геннадий   | Гудермес
 Геннадий   | Гудермес
(6 строк)

/* Задание 2.4. Получите таблицу, в которой каждому имени должен соответствовать каждый город.*/

skypro=# SELECT first_name, city_name FROM employee CROSS JOIN city;
first_name | city_name
------------+------------
 Борис      | Амурск
 Геннадий   | Амурск
 Геннадий   | Амурск
 Егор       | Амурск
 Егор       | Амурск
 Борис      | Биробиджан
 Геннадий   | Биробиджан
 Геннадий   | Биробиджан
 Егор       | Биробиджан
 Егор       | Биробиджан
 Борис      | Воронеж
 Геннадий   | Воронеж
 Геннадий   | Воронеж
 Егор       | Воронеж
 Егор       | Воронеж
 Борис      | Гудермес
 Геннадий   | Гудермес
 Геннадий   | Гудермес
 Егор       | Гудермес
 Егор       | Гудермес
(20 строк)