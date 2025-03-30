-- Selecciona todos los registros de la tabla Albums.
SELECT
  *
FROM
  album


-- Selecciona todos los géneros únicos de la tabla Genres.
SELECT
  DISTINCT g.name AS "Género"
FROM
  genre AS g


-- Cuenta el número de pistas por género.
SELECT 
  g.name AS "Género", COUNT(t.*) AS "Nro. de pistas" 
FROM 
  track AS t
  LEFT JOIN genre AS g ON t.genre_id = g.genre_id
GROUP BY
  g.name


-- Encuentra la longitud total (en milisegundos) de todas las pistas para cada álbum.
SELECT 
  a.title AS "Álbum", SUM(t.milliseconds) AS "Longitud Total (ms)" 
FROM 
  track AS t
  INNER JOIN album AS a ON t.album_id = a.album_id
GROUP BY
  a.title

  
-- Lista los 10 álbumes con más pistas.
SELECT 
  a.title AS "Álbum", 
  COUNT(t.track_id) AS "Nro. de pistas"
FROM 
  album AS a
INNER JOIN 
  track AS t ON a.album_id = t.album_id
GROUP BY 
  a.album_id
ORDER BY 
  "Nro. de pistas" DESC
LIMIT 10;


-- Encuentra la longitud promedio de la pista para cada género.
SELECT 
  g.name AS "Género", 
  AVG(t.milliseconds) "Longitud promedio del track (ms)"
FROM 
  track AS t
INNER JOIN 
  genre AS g ON t.genre_id = g.genre_id
GROUP BY 
  g.name


-- Para cada cliente, encuentra la cantidad total que han gastado.
SELECT 
  c.first_name || ' ' || c.last_name AS "Cliente",
  SUM(i.total) AS "Total gastado"
FROM 
  customer AS c
INNER JOIN 
  invoice AS i ON c.customer_id = i.customer_id
GROUP BY 
  c.customer_id


-- Para cada país, encuentra la cantidad total gastada por los clientes.
SELECT 
  c.country AS "País",
  SUM(i.total) AS "Total gastado"
FROM 
  customer AS c
INNER JOIN 
  invoice AS i ON c.customer_id = i.customer_id
GROUP BY 
  c.country


-- Clasifica a los clientes en cada país por la cantidad total que han gastado.

-- ** Clasificación propuesta: dividir el consumo total en cuartiles para segmentar en:
-- Cuartil 1 → Consumo Bajo
-- Cuartil 2 → Consumo Medio
-- Cuartil 3 → Consumo Alto
-- Cuartil 4 → Cliente Premium
WITH TotalBilled AS (
  SELECT 
    c.country AS "País del cliente",
    c.first_name || ' ' || c.last_name AS "Cliente",
    SUM(i.total) AS "Total gastado"
  FROM 
    customer AS c
  JOIN 
    invoice AS i ON c.customer_id = i.customer_id
  GROUP BY 
    c.country, c.customer_id
)
SELECT 
  "País del cliente", 
  "Cliente", 
  "Total gastado", 
  CASE
    WHEN NTILE(4) OVER (ORDER BY "Total gastado" DESC) = 1 THEN 'Consumo Bajo'
    WHEN NTILE(4) OVER (ORDER BY "Total gastado" DESC) = 2 THEN 'Consumo Medio'
    WHEN NTILE(4) OVER (ORDER BY "Total gastado" DESC) = 3 THEN 'Consumo Alto'
    ELSE 'Cliente Premium'
  END AS "Segmento de Consumo"
FROM 
  TotalBilled
ORDER BY 
  "País del cliente", "Total gastado" DESC


-- Para cada artista, encuentra el álbum con más pistas y clasifica a los artistas por este número.
-- ** Clasificación propuesta: Álbum corto, mediano o largo en función de la longitud promedio de todos los álbumes
WITH AlbumTrackCount AS (
  SELECT
    a.artist_id,
    a.title AS "Álbum",
    COUNT(t.track_id) AS "Nro. de Pistas"
  FROM
    album AS a
  JOIN
    track AS t ON a.album_id = t.album_id
  GROUP BY
    a.artist_id, a.album_id
),
MaxAlbumTrack AS (
  SELECT
    artist_id,
    MAX("Nro. de Pistas") AS "Máx Pistas en un Álbum"
  FROM
    AlbumTrackCount
  GROUP BY
    artist_id
),
AlbumStats AS (
  SELECT
    MIN("Nro. de Pistas") AS "MinPistas",
    MAX("Nro. de Pistas") AS "MaxPistas",
    AVG("Nro. de Pistas") AS "AvgPistas"
  FROM
    AlbumTrackCount
)
SELECT
  ar.name AS "Artista",
  atc."Álbum",
  atc."Nro. de Pistas",
  CASE
    WHEN atc."Nro. de Pistas" <= (asv."AvgPistas" - (asv."MaxPistas" - asv."MinPistas") / 3) THEN 'Álbum Corto'
    WHEN atc."Nro. de Pistas" <= (asv."AvgPistas" + (asv."MaxPistas" - asv."MinPistas") / 3) THEN 'Álbum Mediano'
    ELSE 'Álbum Largo'
  END AS "Clasificación por nro. de pistas"
FROM
  AlbumTrackCount AS atc
JOIN
  artist AS ar ON atc.artist_id = ar.artist_id
JOIN
  MaxAlbumTrack AS mat ON atc.artist_id = mat.artist_id
JOIN
  AlbumStats AS asv ON 1=1
WHERE
  atc."Nro. de Pistas" = mat."Máx Pistas en un Álbum"


-- Selecciona todas las pistas que tienen la palabra "love" en su título.
SELECT
  t.*
FROM
  track AS t
WHERE
  t.name LIKE '%love%'

-- ** Considerando estrictamente la palabra "love" y no otras que la contengan (por ejemplo, Glove, Beloved, Rollover)
SELECT
  t.*
FROM
  track AS t
WHERE
  t.name ~ '\\m love \\M';


-- Selecciona a todos los clientes cuyo primer nombre comienza con 'A'.
SELECT
  c.*
FROM
  customer AS c
WHERE
  c.first_name LIKE 'A%'


-- Calcula el porcentaje del total de la factura que representa cada factura.
WITH TotalBilling AS (
  SELECT
    SUM(i.total) AS "Total Facturado"
  FROM
    invoice AS i
),
TotalCustomer AS (
  SELECT
    inv.customer_id, SUM(inv.total) "Total Cliente"
  FROM
    invoice AS inv
  GROUP by 
    inv.customer_id
)
SELECT
  customer_id, "Total Cliente", "Total Cliente" * 100/"Total Facturado" AS "Porcentaje del total facturado"
FROM
  TotalCustomer 
  LEFT JOIN TotalBilling ON 1=1


-- Calcula el porcentaje de pistas que representa cada género
WITH TotalTracks AS (
  SELECT
    COUNT(*) AS "Tracks Totales"
  FROM
    track
)
SELECT
  g.name "Género", 1.0*COUNT(t.*)/"Tracks Totales" AS "Porcentaje del total de pistas"
FROM
  genre AS g
  LEFT JOIN track AS t ON (g.genre_id = t.genre_id)
  LEFT JOIN TotalTracks ON 1=1
GROUP BY
  g.name, "Tracks Totales"


-- Para cada cliente, compara su gasto total con el del cliente que gastó más.
WITH CustomerBill AS (
  SELECT
    c.customer_id "ID Cliente",
    SUM(i.total) AS "Gasto Total"
  FROM
    customer AS c
    LEFT JOIN invoice AS i ON c.customer_id = i.customer_id
  GROUP BY
    c.customer_id
),
MaxBill AS (
  SELECT
    MAX("Gasto Total") AS "Max Gasto"
  FROM
    CustomerBill
)
SELECT
  cb."ID Cliente",
  cb."Gasto Total",
  cmb."Max Gasto",
  (cb."Gasto Total" / cmb."Max Gasto") * 100 AS "Porcentaje del Gasto Máximo"
FROM
  CustomerBill cb
JOIN
  MaxBill cmb ON 1=1
ORDER BY
  cb."Gasto Total" DESC


-- Para cada factura, calcula la diferencia en el gasto total entre ella y la factura anterior.
WITH Billing AS (
  SELECT
    i.invoice_id,
    i.customer_id,
    i.total AS "Gasto Total",
    LAG(i.total) OVER (ORDER BY i.invoice_date) AS "Gasto Anterior"
  FROM
    invoice AS i
)
SELECT
  b.invoice_id,
  b.customer_id,
  b."Gasto Total",
  b."Gasto Anterior",
  b."Gasto Total" - COALESCE(b."Gasto Anterior", 0) AS "Diferencia con Factura Anterior"
FROM
  Billing b
ORDER BY
  b.invoice_id


-- Para cada factura, calcula la diferencia en el gasto total entre ella y la próxima factura.
WITH Billing AS (
  SELECT
    i.invoice_id,
    i.customer_id,
    i.total AS "Gasto Total",
    LEAD(i.total) OVER (ORDER BY i.invoice_date) AS "Gasto Próximo"
  FROM
    invoice AS i
)
SELECT
  b.invoice_id,
  b.customer_id,
  b."Gasto Total",
  b."Gasto Próximo",
  b."Gasto Próximo" - b."Gasto Total" AS "Diferencia con Próxima Factura"
FROM
  Billing b
ORDER BY
  b.invoice_id


-- Encuentra al artista con el mayor número de pistas para cada género.
WITH ArtistGenreTrack AS (
  SELECT
    g.name AS "Género",
    a.name AS "Artista",
    COUNT(t.track_id) AS "Nro. de Pistas",
    RANK() OVER (PARTITION BY g.name ORDER BY COUNT(t.track_id) DESC) AS "Ranking"
  FROM
    track AS t
  LEFT JOIN genre AS g ON t.genre_id = g.genre_id
  LEFT JOIN album AS al ON t.album_id = al.album_id
  LEFT JOIN artist AS a ON al.artist_id = a.artist_id
  GROUP BY
    g.name, a.name
)
SELECT
  agt."Género",
  agt."Artista",
  agt."Nro. de Pistas"
FROM
  ArtistGenreTrack agt
WHERE
  "Ranking" = 1
ORDER BY
  agt."Género"


-- Compara el total de la última factura de cada cliente con el total de su factura anterior.
WITH Billing AS (
  SELECT
    i.invoice_id,
    i.customer_id,
    i.total AS "Total Factura",
    LAG(i.total) OVER (PARTITION BY i.customer_id ORDER BY i.invoice_date) AS "Total Factura Anterior",
    ROW_NUMBER() OVER (PARTITION BY i.customer_id ORDER BY i.invoice_date DESC) AS "RowNum"
  FROM
    invoice AS i
)
SELECT
  b.customer_id,
  b.invoice_id AS "Última Factura",
  b."Total Factura" AS "Total Última Factura",
  b."Total Factura Anterior",
  b."Total Factura" - COALESCE(b."Total Factura Anterior", 0) AS "Diferencia con Factura Anterior"
FROM
  Billing AS b
WHERE
  b."RowNum" = 1
ORDER BY
  b.customer_id
  

-- Encuentra cuántas pistas de más de 3 minutos tiene cada álbum.
SELECT
  al.title AS "Álbum",
  COUNT(t.track_id) AS "# Pistas de más de 3 mins"
FROM
  track AS t
JOIN
  album AS al ON t.album_id = al.album_id
WHERE
  t.milliseconds > (3*60*1000)
GROUP BY
  al.title
ORDER BY
  "# Pistas de más de 3 mins" DESC
