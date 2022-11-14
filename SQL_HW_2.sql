--Таблица employees
create table employees(
	id serial primary key,
	employee_name varchar(50) not null
);
--Таблица salary
create table salary(
	id serial primary key,
	monthly_salary int not null
);
--Таблица employee_salary
create table employee_salary(
	id serial primary key,
	employee_id int not null unique,
	salary_id int not null
);
--Таблица roles
create table roles(
	id serial primary key,
	role_name int not null unique
);

--Таблица roles_employee
create table roles_employee(
	id serial primary key,
	employee_id int not null unique,
	role_id int not null,
	foreign key(employee_id)
		references employees(id),
	foreign key(role_id)
		references roles(id)
);
		
--drop table employee_salary;

select * from roles;
select * from employees;
select * from employee_salary;
select * from roles_employee;
select * from salary;

--Наполнить таблицу employee 70 строками.
insert into employees(employee_name) values ('Heimdallr_1'),('Heimdallr_2'),('Heimdallr_3'),('Heimdallr_4'),('Heimdallr_5'),('Heimdallr_6'),('Heimdallr_7'),('Heimdallr_8'),('Heimdallr_9'),('Heimdallr_10'),('Heimdallr_11'),('Heimdallr_12'),('Heimdallr_13'),('Heimdallr_14'),('Heimdallr_15'),('Heimdallr_16'),('Heimdallr_17'),('Heimdallr_18'),('Heimdallr_19'),('Heimdallr_20'),
('Heimdallr_21'),('Heimdallr_22'),('Heimdallr_23'),('Heimdallr_24'),('Heimdallr_25'),('Heimdallr_26'),('Heimdallr_27'),('Heimdallr_28'),('Heimdallr_29'),('Heimdallr_30'),('Heimdallr_31'),('Heimdallr_32'),('Heimdallr_33'),('Heimdallr_34'),('Heimdallr_35'),('Heimdallr_36'),('Heimdallr_37'),('Heimdallr_38'),('Heimdallr_39'),('Heimdallr_40'),
('Heimdallr_41'),('Heimdallr_42'),('Heimdallr_43'),('Heimdallr_44'),('Heimdallr_45'),('Heimdallr_46'),('Heimdallr_47'),('Heimdallr_48'),('Heimdallr_49'),('Heimdallr_50'),('Heimdallr_51'),('Heimdallr_52'),('Heimdallr_53'),('Heimdallr_54'),('Heimdallr_55'),('Heimdallr_56'),('Heimdallr_57'),('Heimdallr_58'),('Heimdallr_59'),('Heimdallr_60'),
('Heimdallr_61'),('Heimdallr_62'),('Heimdallr_63'),('Heimdallr_64'),('Heimdallr_65'),('Heimdallr_66'),('Heimdallr_67'),('Heimdallr_68'),('Heimdallr_69'),('Heimdallr_70');

--Наполнить таблицу salary 15 строками:
insert into salary(monthly_salary) values (1000),(1100),(1200),(1300),(1400),(1500),(1600),(1700),(1800),(1900),(2000),(2100),(2200),(2300),(2400),(2500);

--Наполнить таблицу employee_salary 40 строками: в 10 строк из 40 вставить несуществующие employee_id
insert into employee_salary(employee_id, salary_id) values(1, 3),(4, 14),(2, 2),(6, 1),(8, 9),(10, 13),(11, 4),(15, 7),(17, 16),(20, 14),(25, 7),(28, 9),(34, 12),(38, 2),(40, 10),(44, 1),(51, 9),(53, 6),(55, 15),(58, 2),(49, 8),(60, 1),(64, 16),(61, 3),(67, 4),(19, 1),(37, 9),(26, 5),(62, 11),(70, 5),
(342, 3),(71, 9),(88, 5),(112, 1),(167, 12),(135, 2),(543, 1),(1000, 13),(999, 9),(111, 14);
--Наполнить таблицу roles_employee 40 строками:
insert into roles_employee(employee_id, role_id) values(1, 3),(4, 14),(2, 2),(6, 1),(8, 9),(10, 13),(11, 4),(15, 7),(17, 16),(20, 14),(25, 7),(28, 9),(34, 12),(38, 2),(40, 10),(44, 1),(51, 9),(53, 6),(55, 15),(58, 2),(49, 8),(60, 1),(64, 16),(61, 3),(67, 4),(19, 1),(37, 9),(26, 5),(62, 11),(70, 5),(7, 3),(12, 9),(18, 5),(13, 1),(3, 12),(22, 2),(23, 1),(30, 13),(32, 9),(33, 14);

--Поменять тип столба role_name с int на varchar(30)
alter table roles alter column role_name type varchar(30);

--Наполнить таблицу roles 20 строками:
insert into roles(role_name) values ('Junior Python developer'),('Middle Python developer'),('Senior Python developer'),('Junior Java developer'),('Middle Java developer'),('Senior Java developer'),('Junior JavaScript developer'),('Middle JavaScript developer'),('Senior JavaScript developer'),('Junior Manual QA engineer'),('Middle Manual QA engineer'),('Senior Manual QA engineer'),('Project Manager'),('Designer'),('HR'),('CEO'),('Sales manager'),('Junior Automation QA engineer'),('Middle Automation QA engineer'),('Senior Automation QA engineer');



--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
where salary.monthly_salary < 2000;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_salary.employee_id, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
where employee_id = null;

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
left join employees on employee_salary.employee_id=employees.id
where salary.monthly_salary < 2000;

-- 5. Найти всех работников кому не начислена ЗП.
select employees.employee_name from employee_salary
left join employees on employee_salary.employee_id=employees.id;

-- 6. Вывести всех работников с названиями их должности.
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id;

-- 7. Вывести имена и должность только Java разработчиков.
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id
where roles.role_name like ('%Java%');

-- 8. Вывести имена и должность только Python разработчиков.
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id
where roles.role_name like ('%Python%');

-- 9. Вывести имена и должность всех QA инженеров.
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id
where roles.role_name like ('%QA%');

-- 10. Вывести имена и должность ручных QA инженеров.
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id
where roles.role_name like ('%Manual QA%');

-- 11. Вывести имена и должность автоматизаторов QA
select employees.employee_name, roles.role_name from roles_employee
join roles on roles_employee.role_id=roles.id
join employees on roles_employee.employee_id=employees.id
where roles.role_name like ('%Automation QA%');

-- 12. Вывести имена и зарплаты Junior специалистов
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like ('%Junior%');

-- 13. Вывести имена и зарплаты Middle специалистов
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like ('%Middle%');

-- 14. Вывести имена и зарплаты Senior специалистов
select employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like ('%Senior%');

-- 15. Вывести зарплаты Java разработчиков
select  salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Java%');

-- 16. Вывести зарплаты Python разработчиков
select  salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Python%');

-- 17. Вывести имена и зарплаты Junior Python разработчиков
select  employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Junior Python%');

-- 18. Вывести имена и зарплаты Middle JS разработчиков
select  employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Middle JavaScript%');

-- 19. Вывести имена и зарплаты Senior Java разработчиков
select  employees.employee_name, salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Senior Java%');

-- 20. Вывести зарплаты Junior QA инженеров
select  salary.monthly_salary from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where roles.role_name like('%Junior%QA%');

-- 21. Вывести среднюю зарплату всех Junior специалистов
select  avg(salary.monthly_salary) from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like('%Junior%');

-- 22. Вывести сумму зарплат JS разработчиков
select  sum(salary.monthly_salary) from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like('%JavaScript%');

-- 23. Вывести минимальную ЗП QA инженеров
select  min(salary.monthly_salary) from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like('%Junior%QA%');

-- 24. Вывести максимальную ЗП QA инженеров
select  max(salary.monthly_salary) from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like('%QA%');

--- 25. Вывести количество QA инженеров
select count(roles.role_name)  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like ('%QA%');

-- 26. Вывести количество Middle специалистов.
select count(roles.role_name)  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where role_name like ('%Middle%');

-- 27. Вывести количество разработчиков
select count(roles.role_name)  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where role_name like ('%developer%');

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
select sum(salary.monthly_salary)  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id 
where roles.role_name like ('%developer%');

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select  employees.employee_name, roles.role_name, salary.monthly_salary  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
order by salary.monthly_salary;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select  employees.employee_name, roles.role_name, salary.monthly_salary  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where salary.monthly_salary between 1700 and 2300
order by salary.monthly_salary;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
select  employees.employee_name, roles.role_name, salary.monthly_salary  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where salary.monthly_salary < 2300
order by salary.monthly_salary;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select  employees.employee_name, roles.role_name, salary.monthly_salary  from employee_salary
join salary on employee_salary.salary_id=salary.id
join employees on employee_salary.employee_id=employees.id
join roles on employee_salary.employee_id=roles.id
join roles_employee on employee_salary.id=roles_employee.id
where salary.monthly_salary in(1100,1500,2000)
order by salary.monthly_salary;








