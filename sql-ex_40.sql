-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
select model, speed, hd from pc
where price < 500;
-- Найдите производителей принтеров. Вывести: maker
select distinct maker from product
where type like 'printer';
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
select model, ram, screen from laptop
where price > 1000;
-- Найдите все записи таблицы Printer для цветных принтеров.
Select * from printer
where color like 'y';
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
Select model, speed, hd from pc
where (cd like '12x' or cd like '24x') and price < 600;
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
Select distinct maker, laptop.speed from product
join laptop on laptop.model = product.model
where laptop.hd >= 10;
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
Select product.model, laptop.price from product
join laptop ON laptop.model = product.model
Where maker like 'B'
UNION
select product.model, pc.price from product
JOIN pc ON pc.model = product.model
Where maker like 'B'
Union
select product.model, printer.price from product
join printer ON printer.model = product.model
Where maker like 'B';
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.
Select maker from product
where type = 'pc'
EXCEPT
select maker from product
where type = 'laptop';
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
Select distinct maker from product
join pc ON product.model = pc.model
where speed >= 450;
-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
Select distinct model, price from printer
where price = ( select max(price) from printer);
-- Найдите среднюю скорость ПК.
Select avg(speed) as 'Средняя_скорость_пк' from pc;
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
Select avg(speed) as 'Средняя_скорость' from laptop
where price > 1000;
-- Найдите среднюю скорость ПК, выпущенных производителем A.
select avg(pc.speed) from pc
join product ON product.model=pc.model
where maker = 'A';
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
select ships.class, ships.name, classes.country from ships
join classes on ships.class = classes.class
where classes.numGuns >= 10;
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
Select hd from pc
group by hd
having count(hd)>=2;
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
Select distinct a.model, b.model, a.speed, a.ram
from pc as a, pc as b
where a.speed =b.speed and a.ram=b.ram and a.model > b.model;
--Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК. Вывести: type, model, speed
Select distinct c.type, a.model, a.speed
from laptop as a, pc as b, product as c
where a.speed < all ( select speed from pc) and c.type ='laptop';
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
Select distinct product.maker, printer.price from product
join printer on printer.model = product.model
where printer.price = ( select min(price) from printer where color = 'y') AND printer.color = 'y';
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов. Вывести: maker, средний размер экрана.
select product.maker, avg(laptop.screen) 
from product
join laptop on product.model=laptop.model
group by maker
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
select maker, count(model) as count_model from product
where type = 'pc'
group by maker
having count(model) >= 3;
--Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC. Вывести: maker, максимальная цена.
select product.maker, max(pc.price) as max_price from product
join pc on product.model = pc.model
group by maker
-- Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
Select speed, avg(price) as avg_price from pc
Group by speed
Having speed > 600
--Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker
Select product.maker from product
join laptop on product.model=laptop.model
where laptop.speed >=750
union
Select product.maker from product
join pc on product.model=pc.model
where pc.speed >=750;
--Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
select model from
(select price, model from laptop
union 
select price, model from pc
union 
select price, model from printer) as result
where price = (select max(price) from(select price, model from laptop
union 
select price, model from pc
union 
select price, model from printer) as result)
--Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
with data as (Select maker, ram, speed from product
join pc on pc.model=product.model
where type='PC' and maker in
(select maker from product where type='Printer')and ram=(select min(ram) from pc))
select distinct maker from data
where speed=(select max(speed) from data)

--Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.
select avg(price) as AVG_price from
( Select price from pc
join product p on p.model=pc.model
where maker ='a'
union all
Select price from laptop
join product p on p.model=laptop.model
where maker ='a') as avg
--Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
select maker, avg(hd) from product
join pc on pc.model=product.model
where maker in(select maker from product where type='printer')
group by maker

--Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
select count(maker) from product
where maker in(
select maker from product
group by maker
having count(Distinct model)=1)


