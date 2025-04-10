# TP2

<br>

## Herramientas
<table border="0">
  <tr valign="center">
    <td><img src="../imgs/docker.png" alt="Docker" height="60"></td>
    <td><img src="../imgs/mongodb.png" alt="MongoDB" height="40"></td>
  </tr>
</table>
<br>

## Contenido

<table border="0">
  <tr valign="center">
    <td colspan="2">TP 2</td>
  </tr>
  <tr valign="center">
    <td>docker-compose.yml</td>
    <td># Archivo de configuración de Docker Compose para generar el entorno</td>
  </tr>
  <tr valign="center">
    <td>import.sh</td>
    <td># Archivo para crear la base de datos</td>
  </tr>
    <tr valign="center">
    <td>facturas.json</td>
    <td># Datos para importar en la base de datos</td>
</table>
<br>

## Set Up

Ejecutar el siguiente comando para generar el entorno (MongoDB):

```Bash
docker-compose up -d
```

Ejecutar el siguiente comando para verificar el estado del contenedor:
```Bash
docker ps -a
```

Aguardar hasta que el estado sea "Up (health: healthy)".
<br><br>
Acceso al contenedor con Mongo Shell:  
```Bash
docker exec -it mongo_container mongosh -u mongo -p mongo --authenticationDatabase admin
```
<br>


## Entregable
<table border="0">
  <tr valign="center">
    <td><img src="../imgs/pdf.png" alt="PDF" height="40"></td>
    <td><a href="./CEIA_BDIA_TP2_a1618.pdf" target="_blank">Entregable TP2</a></td>
  </tr>
</table>
<br>
