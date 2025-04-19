# TP3

<br>

## Herramientas
<table border="0">
  <tr valign="center">
    <td><img src="../imgs/docker.png" alt="Docker" height="60"></td>
    <td><img src="../imgs/neo4j.png" alt="Neo4J" height="40"></td>
  </tr>
</table>
<br>

## Contenido

<table border="0">
  <tr valign="center">
    <td colspan="2">TP 3</td>
  </tr>
  <tr valign="center">
    <td>docker-compose.yml</td>
    <td># Archivo de configuración de Docker Compose para generar el entorno</td>
  </tr>
  <tr valign="center">
    <td>XXX</td>
    <td># Archivo para crear la base de datos</td>
  </tr>
    <tr valign="center">
    <td>XXXX</td>
    <td># Datos para importar en la base de datos</td>
  </tr>
    <tr valign="center">
    <td>TP 3 Bases de grafos.pdf</td>
    <td># Consignas</td>
  </tr>
</table>
<br>

## Set Up

Ejecutar el siguiente comando para generar el entorno (Neo4J):

```Bash
docker-compose up -d
```

Ejecutar el siguiente comando para verificar el estado del contenedor:
```Bash
docker ps -a
```

<br><br>
Acceso a la interfaz web de Neo4j en el navegador:
```Bash
http://localhost:7474
```
<br>

Acceso a la base de datos de Neo4j desde la línea de comandos con el cliente cypher-shell:
```Bash
docker exec -it neo4j bin/cypher-shell -u neo4j -p neo4j_185
```
<br>

## Entregable
<table border="0">
  <tr valign="center">
    <td><img src="../imgs/pdf.png" alt="PDF" height="40"></td>
    <td><a href="./CEIA_BDIA_TP3_a1618.pdf" target="_blank">Entregable TP3</a></td>
  </tr>
</table>
<br>
