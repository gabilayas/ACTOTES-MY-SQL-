Colección de 25 consultas SQL sobre el dataset de ejemplo Sakila (MySQL) para practicar selección, filtrado, agregaciones, joins, subconsultas y análisis exploratorio básico.

🎯 Objetivo

Mostrar dominio de SQL práctico: desde consultas simples con SELECT hasta análisis con GROUP BY/HAVING, joins en cadena y subconsultas para preguntas de negocio en un contexto de videoclub.

📁 Contenido

sakila_queries.sql — archivo con las 25 consultas, comentadas y numeradas.

🧰 Stack

MySQL 8+

Base de datos: Sakila (tablas como film, actor, rental, category, etc.)

▶️ Cómo ejecutar

Instala la base Sakila (si no la tienes).

Abre tu cliente MySQL y ejecuta:

USE sakila;
SOURCE sakila_queries.sql;


Ejecuta cada consulta por número (los comentarios explican el objetivo).

🧠 Técnicas y funciones usadas

Selección y deduplicación: SELECT, DISTINCT, alias.

Filtrado: WHERE, IN/NOT IN, BETWEEN, LIKE.

Agregación: COUNT, AVG, GROUP BY, HAVING.

Uniones: INNER JOIN, LEFT JOIN (multi-join entre 4–5 tablas).

Subconsultas: en WHERE y con IN.

Fechas: DATEDIFF para duración de alquileres.

Orden y formato: ORDER BY, CONCAT.

🔍 Qué resuelve cada bloque (resumen)

Catálogo de películas: títulos únicos, filtrado por rating, búsqueda por texto.

Duraciones: películas > 120 min; medias por clasificación.

Talento (actores): listados, filtros por apellido, top performers por nº de películas.

Clientes y demanda: nº de alquileres por cliente y por categoría.

Categorías: películas de la categoría Family; comedias > 180 min; categorías con duración media > 120 min.

Integridad: actores sin películas (mediante LEFT JOIN).

Rendimiento: películas con alquileres > 5 días (subconsulta).

Co-actuaciones: parejas de actores y conteo de películas juntos.

✅ Notas y decisiones

En la consulta “Amazing”: se incluyó title o description; si se requiere solo descripción, bastaría con:

WHERE description LIKE '%Amazing%';


Para rangos (p.ej., actor_id 10–20) se usa >= y <= por claridad.

En filtros por rating se combinan IN/NOT IN según convenga a la lectura.

📈 Qué evidencia este proyecto

Lectura de modelos relacionales y llaves (film_actor, film_category, inventory, rental).

Construcción de consultas analíticas con múltiples joins.

Uso de agregaciones y grouping para preguntas de negocio.

Capacidad de documentar y comentar consultas.
