# TP1

## * Recursos
<table border="0">
  <tr valign="center">
    <td><img src="../imgs/docker.png" alt="Docker" height="60"></td>
    <td><img src="../imgs/postgresql.png" alt="PostgreSQL" height="80"></td>
    <td><img src="../imgs/cloudbeaver.png" alt="CloudBeaver" height="40"></td>
  </tr>
</table>

## * Contenido

<table border="0">
  <tr valign="center">
    <td colspan="2">TP 1</td>
  </tr>
  <tr valign="center">
    <td>docker-compose.yml</td>
    <td># Archivo de configuración de Docker Compose para generar el entorno</td>
  </tr>
  <tr valign="center">
    <td>2.chinook_pg_serial_pk_proper_naming.sql</td>
    <td># Sentencias de inicialización de la DB</td>
  </tr>
    <tr valign="center">
    <td>PracticaChinook.sql</td>
    <td># Consignas</td>
  </tr>
    <tr valign="center">
    <td>README.md</td>
    <td> </td>
  </tr>
</table>

## **Set Up**

Ejecutar el siguiente comando para generar el entorno (PostgreSQL + CloudBeaver):

```Bash
docker-compose up -d
```

Ejecutar el siguiente comando para verificar el estado de los contenedores:
```Bash
docker ps -a
```

Aguardar hasta que todos los servicios estén en estado "Up (health: healthy)".

Acceder a CloudBeaver a través de: 
http://localhost:8978


## **Entregable**

