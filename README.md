
#### Ejercicio de aprendizaje de SQL y Postgrsql  ####
### BBDD ficticia sobre un videoclub retro ###


¬ La intención de este proyecto es aprender y asentar conocimientos sobre SQL, utilizando el sistema de gestión de base de datos (SGBD) relacional **PostgreSQL**. Para ello se ha creado una base datos básica sobre un ficticio videoclub retro, centrada en el registro de préstamo e inventario de películas.

¬ Cómo herramientas, he usado:
    
    · **ElephantSQL** https://customer.elephantsql.com/ como servicio de alojamiento de la base de 
    datos, en su modalidad gratuita "Tiny Turtle".

    · **Dbeaver** como aplicación de software cliente de SQL y herramienta de administración de bases
     de datos. Es un software completo y muy versátil para administrar proyectos de BBDD si buscamos 
     una opción gratuita, aunque presenta algúnos problemas de actualización automática de datos.

¬ Las funcionalidades planteadas como requisitos mínimos serían:

    · Registrar los socios del videoclub: nombre y apellidos, fecha de nacimiento, teléfono y su 
     número de identificación (DNI). Se le asignará un número de socio.
    · Registrar la dirección postal de los socios :código postal, calle, número y piso es suficiente. 
    · Registrar las películas. Puedo tener más de una copia de cada una. De cada película necesito: 
     título, año de publicación, género, director y sinopsis.
    · Necesito saber a que socio le he prestado cada copia y cuándo: fecha de préstamo y fecha de 
     devolución. Se considera que la película está actualmente alquilada si no tiene fecha de devolución.

    · Realización de 2 consultas:
        ·· 1-Requerida: Qué películas están disponibles para alquilar en este momento (es decir, que no 
        están prestadas). Se devuelve título y número de copias disponibles. -> HECHA
        ·· 2-Optativa: Cuál es el género favorito de cada socios (el género(s) del que tenga más préstamos). 
        Se devuelve número de socio, nombre completo y género(s) favorito(s). -> HECHA

¬ Material en el repositorio:

    · Diagrama Entidad/Relación -> videoclub.drawio:
        · Tablas: Socio, Dirección, Código_Postal, Película, Género, Director y Préstamo
        · Claves primarias y foráneas.
        · Relaciones entre tablas
        · Se han usado reglas de normalización en la elaboración
    · Script SQL -> script-videoclub.sql, que se ejecuta de seguido, con las siguientes partes:
        · Creación del Schema.
        · Creación de las tablas y sus relaciones.
        · Carga de los datos primarios presentes en tmp_videoclub.sql
        · Consulta 1 y 2.
    

¬ Puntos a considerar:

    · Se ha usado un CTE en lugar de view para añadir un año de publicación aleatorio
     a la tabla de películas, de manera que todos los títulos iguales compartan el mismo año.
     Se ha optado por ello al tratarse de una tabla virtual y temporal, que es borrada una 
     vez realizada la consulta.

    · Se ha añadido una copia de película extra al Señor de Los Anillos (id 309) para tener
     varias copias disponibles de un título y así poder testear que la consulta-1 funciona 
     adecuadamente.

    · En caso de que un cliente tenga un empate a número de películas alquiladas en más de
     un género, ofreceremos no un único género favorito, sino varios. 

    · Se ha hecho uso de la normalización, pero buscando un compromiso con las simplicidad. 
     Así, se ha sacado el código postal fuera de dirección para representar la normalización 
     de ese dato, pero se ha dejado la calle como dato sin más. La idea ha sido mostrar como 
     sería el proceso, pero sin complicar/alargar en exceso el ejercicio.


¬ Opciones de desarrollo futuro:

    · Aplicar diferentes metodologías para obtener las mismas consultas (usando left join, 
     with, etc.)



--- David Arrarás ---




