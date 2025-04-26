--1. Colores más utilizados en los 90
SELECT
c.name AS color_name, c.rgb, 
SUM(i_p.quantity) AS total_quantity
FROM
sets AS s
JOIN inventories AS i ON (s.set_num = i.set_num)
JOIN inventory_parts AS i_p ON (i.id = i_p.inventory_id)
JOIN colors AS c ON (i_p.color_id = c.id)
WHERE
s.year BETWEEN 1990 AND 1999
GROUP BY 
c.name, c.rgb
ORDER BY 
total_quantity DESC
LIMIT 10;

--2. Colores únicos
SELECT
COUNT(c.*) as unique_colors
FROM
colors AS c;

SELECT
COUNT(DISTINCT c.rgb) as unique_colors
FROM
colors AS c;

SELECT
COUNT(DISTINCT c.rgb) AS unique_used_colors
FROM
inventory_parts AS i_p
JOIN colors AS c ON i_p.color_id = c.id;

SELECT
COUNT(DISTINCT c.name) AS unique_used_colors
FROM
inventory_parts AS i_p
JOIN colors AS c ON i_p.color_id = c.id;

SELECT 
c.name AS color_name, c.id AS color_id, c.rgb
FROM (
    SELECT color_id
    FROM inventory_parts
    GROUP BY color_id
    HAVING COUNT(*) = 1
) AS unique_colors
JOIN colors c ON unique_colors.color_id = c.id;

SELECT
c.id, c.name, c.rgb, c.is_trans
FROM
colors AS c
WHERE
c.id NOT IN
(SELECT DISTINCT i_p.color_id FROM inventory_parts AS i_p);

--3. Tendencia de piezas por sets a lo largo de los años
SELECT s.year, AVG(s.num_parts) AS promedio_piezas_por_set
FROM sets AS s
GROUP BY year
ORDER BY year;

SELECT s.year, 
       COUNT(s.*) AS cantidad_sets,
       AVG(s.num_parts) AS promedio_piezas_por_set,
       SUM(s.num_parts) AS total_piezas
FROM sets AS s
GROUP BY s.year
ORDER BY s.year;
.
--4. Temáticas más populares de los 2000
SELECT 
t.name AS tema, COUNT(*) AS cantidad_sets
FROM 
sets AS s
JOIN themes AS t ON s.theme_id = t.id
WHERE 
s.year BETWEEN 2000 AND 2009
GROUP BY 
t.name
ORDER BY 
cantidad_sets DESC
LIMIT 10;

SELECT 
t.name AS tema, SUM(s.num_parts) AS total_piezas
FROM 
sets AS s
JOIN themes AS t ON s.theme_id = t.id
WHERE 
s.year BETWEEN 2000 AND 2009
GROUP BY 
t.name
ORDER BY 
total_piezas DESC
LIMIT 10;

WITH top_x_sets AS (
    SELECT 
        t.name AS tema
    FROM 
        sets AS s
    JOIN themes AS t ON s.theme_id = t.id
    WHERE s.year BETWEEN 2000 AND 2009
    GROUP BY t.name
    ORDER BY COUNT(*) DESC
    LIMIT 10
),
top_x_parts AS (
    SELECT 
        t.name AS tema
    FROM 
        sets AS s
    JOIN themes AS t ON s.theme_id = t.id
    WHERE s.year BETWEEN 2000 AND 2009
    GROUP BY t.name
    ORDER BY SUM(s.num_parts) DESC
    LIMIT 10
)
SELECT c.tema
FROM top_x_sets c
JOIN top_x_parts p ON c.tema = p.tema;

WITH top_x_sets AS (
    SELECT 
        t.name AS tema
    FROM 
        sets AS s
    JOIN themes AS t ON s.theme_id = t.id
    WHERE s.year BETWEEN 2000 AND 2009
    GROUP BY t.name
    ORDER BY COUNT(*) DESC
    LIMIT 10
),
top_x_parts AS (
    SELECT 
        t.name AS tema
    FROM 
        sets AS s
    JOIN themes AS t ON s.theme_id = t.id
    WHERE s.year BETWEEN 2000 AND 2009
    GROUP BY t.name
    ORDER BY SUM(s.num_parts) DESC
    LIMIT 10
)
SELECT 
    s.year,
    c.tema,
    COUNT(s.set_num) AS cantidad_sets,
    SUM(s.num_parts) AS total_piezas
FROM 
sets AS s
JOIN top_x_sets c ON s.theme_id = (SELECT id FROM themes WHERE name = c.tema LIMIT 1)
JOIN top_x_parts p ON s.theme_id = (SELECT id FROM themes WHERE name = p.tema LIMIT 1)
WHERE 
    s.year BETWEEN 2000 AND 2009
    AND c.tema = p.tema  
GROUP BY 
    s.year, c.tema
ORDER BY 
    s.year, c.tema;


