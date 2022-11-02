version: "3"

services:
  mysqldb:
    container_name: 3f3946d5572f
    image: mysql/mysql-server:8.0
    restart: unless-stopped
    ports:
     - 3306:336
    environment:
     - MYSQL_ROOT_PASSWORD=root
     - MYSQL_DATABASE=achatdb
     - MYSQL_USER=root
     - MYSQL_PASSWORD=root


  spring_app:
    image: gaston2100/achat
    container_name: achatspring
    restart: on-failure
    environment:
     - spring.datasource.url=jdbc:mysql://mysqldb:3306/achatdb?createDatabaseIfNotExist=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC
    ports:
     - 8089:8089
    depends_on:
     - mysqldb
