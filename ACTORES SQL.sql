USE sakila;

/*. 1. Selecciono todos los nombres de las películas sin que aparezcan duplicados*/ 

SELECT DISTINCT title AS Películas
FROM film;

/* . 2. Muestro los nombres de todas las películas que tengan una clasificación de "PG-13".*/ 

SELECT title AS Películas, rating
FROM film
WHERE rating= "PG-13" OR rating = "G";

/* . 3. Busco el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción*/ 

SELECT title AS Película, `description` AS Descripción  
FROM film
WHERE title LIKE "%Amazing%" OR `description` LIKE "%Amazing%";  

-- Aqui tuve un pequeño error al interpretar el enunciado, si queremos solo encontrar la palabra en la descripcion quitamos el "or like"

/*4. Busco el título de todas las películas que tengan una duración mayor a 120 minutos*/ 

SELECT title AS Película, `length` AS duracíon 
FROM film 
WHERE `length`> 120; 


/*5. Recupero los nombres de todos los actores*/

SELECT first_name AS nombre, last_name AS apellido
FROM actor;  

/* 6. Busco el nombre y apellido de los actores que tengan "Gibson" en su apellido*/ 

SELECT first_name AS nombre, last_name AS apellido
FROM actor
WHERE last_name LIKE "%Gibson%"; 

/* 7. Busco los nombres de los actores que tengan un actor_id entre 10 y 20*/ 


SELECT actor_id, first_name AS nombre, last_name AS apellido
FROM actor
WHERE actor_id >= 10 AND actor_id <= 20; 

/* 8. Busco el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación*/

SELECT title AS Película, rating AS Calificacíon 
FROM film
WHERE rating NOT IN ("PG-13", "R");


/* 9.Busco la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento*/ 

SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
HAVING total_peliculas > 200;


/* 10.E Encuentro la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su.
nombre y apellido junto con la cantidad de películas alquiladas.*/ 

SELECT c.customer_id, c.first_name AS nombre, c.last_name AS apellido, COUNT(r.rental_id) AS total_peliculas_alquiladas
FROM customer AS c
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;


/* 11. Encuentro la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres*/ 

SELECT c.name AS categoria, COUNT(r.rental_id) AS total_pelis
FROM category AS c
INNER JOIN film_category AS fc 
ON c.category_id = fc.category_id
INNER JOIN film AS f 
ON fc.film_id = f.film_id
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
GROUP BY c.name;
-- Hemos tenido que hacer varios joins para llegar desde category hasta rental.

/* 12. Encuentro el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración*/ 

SELECT rating AS clasificacion, AVG(length) AS promedio_duracion 
FROM film 
GROUP BY rating; 

/* 13. Encuentro el nombre y apellido de los actores que aparecen en la película con title "Indian Love*/ 

SELECT a.first_name AS nombre, a.last_name AS apellido, f.title AS titulo 
FROM film AS f
INNER JOIN film_actor AS fa 
ON f.film_id = fa.film_id
INNER JOIN actor AS a 
ON a.actor_id = fa.actor_id 
WHERE title = "Indian Love"; 

/* 14. Muestro el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción*/ 

SELECT title, `description`
FROM film
WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%"; 

/* 15. ¿Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor? */ 

SELECT a.actor_id, a.first_name AS nombre, a.last_name AS apellido
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;
-- NO HUBO RESULTADOS.

/* 16.Encuentro el título de todas las películas que fueron lanzadas entre el año 2005 y 2010*/ 

SELECT title AS Película, release_year AS año_lanzamiento
FROM film 
WHERE release_year >= "2005" AND release_year <= "2010"; 

/* 17. Encuentro el título de todas las películas que son de la misma categoría que "Family"*/ 

SELECT f.title AS Películas_cat_family
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family';
 

/* 18. Muestro el nombre y apellido de los actores que aparecen en más de 10 películas*/ 

SELECT first_name AS nombre, last_name AS apellido
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor 
                    GROUP BY actor_id 
                    HAVING COUNT(film_id) > 10); 
                    
/* 19. Encuentro el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
tabla film.*/ 
 
SELECT title AS Película, length AS Duracíon, rating 
FROM film 
WHERE rating = "R" AND length > "120"; 

/* 20. Encuentro las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración*/ 

SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 120;

/* 21.  Encuentro los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado */ 

SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;

/* 22. Encuentro el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes*/

SELECT DISTINCT f.title AS películas
FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN (SELECT rental_id
					  FROM rental
					  WHERE DATEDIFF(return_date, rental_date) > 5); -- DATEDIFF: Calcula la diferencia entre fechas. 
    
/* 23. Encuentro el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores */ 

SELECT a.first_name AS nombre, a.last_name AS apellido 
FROM actor AS a
WHERE a.actor_id NOT IN (SELECT DISTINCT fa.actor_id
						 FROM film_actor AS fa
						 INNER JOIN film AS f 
						 ON fa.film_id = f.film_id
						 INNER JOIN film_category AS fc 
						 ON f.film_id = fc.film_id
						 INNER JOIN category AS c 
						 ON fc.category_id = c.category_id 
						 WHERE c.name = "Horror");
                       
                       
/* 24. Encuentro el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film */ 

SELECT f.title AS comedias
FROM film f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = "Comedy" AND f.length > 180; 

/* 
25.Encuentro todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar 
el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/ 


SELECT CONCAT(a1.first_name, " ", a1.last_name) AS Actor_1, CONCAT(a2.first_name, " ", a2.last_name) AS Actor_2, COUNT(DISTINCT fa1.film_id) AS Peliculas_Juntos
FROM film_actor fa1
INNER JOIN film_actor fa2 
ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
INNER JOIN actor a1
ON fa1.actor_id = a1.actor_id
INNER JOIN actor a2 
ON fa2.actor_id = a2.actor_id
GROUP BY fa1.actor_id, fa2.actor_id, a1.first_name, a1.last_name, a2.first_name, a2.last_name
HAVING Peliculas_Juntos >= 1
ORDER BY Peliculas_juntos DESC;
/* He unido nombre y apellidos de los actores en uno con un "CONCAT" para tener una vision mas limpia de la query, de 
necesitar tenerlos por sepado no hay problema en dejarla en su forma original. */ 