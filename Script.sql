set schema 'videoclub';


-- Carga GÉNERO

insert into genero (tipo_genero)
select tv.genero from tmp_videoclub tv group by genero;  

select g.tipo_genero from genero g; 

-- Carga DIRECTOR

insert into director(nombre_director)
select tv.director from tmp_videoclub tv group by tv.director;  

select d.id, d.nombre_director from director d; 

-- Carga CÓDIGO_POSTAL

insert into codigo_postal (numero_cp)
select tv.codigo_postal from tmp_videoclub tv group by tv.codigo_postal; 

select cp.numero_cp from codigo_postal cp; 

-- Carga SOCIO
-- 		Aplico to_date para adaptar la fecha a mi esquema

insert into socio (dni, nombre, apellido1, apellido2, telefono,fecha_nacimiento)
select distinct tv.dni, tv.nombre, tv.apellido_1, tv.apellido_2, tv.telefono, TO_DATE(tv.fecha_nacimiento, 'YYYY-MM-DD')
from tmp_videoclub tv;



-- Carga DIRECCIÓN

insert into direccion (id_socio, calle, numero, piso, letra, id_cp)
select distinct s.id, tv.calle, tv.numero, tv.piso, tv.letra, cp.id  
from tmp_videoclub tv 
inner join codigo_postal cp on tv.codigo_postal = cp.numero_cp 
inner join socio s on tv.dni = s.dni
order by s.id;  

select * from direccion d ;

-- Carga PELÍCULA

/*
 * 	alter table pelicula alter column anno_publicacion drop not null;
 * 	alter table pelicula
 * 	alter column titulo type varchar(80);
*/

insert into pelicula(id, titulo, sinopsis, id_director, id_genero)
select distinct  tv.id_copia, tv.titulo, tv.sinopsis, d.id, g.id  
from tmp_videoclub tv 
inner join genero g on tv.genero = g.tipo_genero
inner join director d on tv.director = d.nombre_director
order by tv.id_copia; 
 


-- Añado aleatoriamente un año entre 1950 y 2020 al año de publicación
/*
 * 	Uso un CTE (una tabla virtual y temporal que no cambia nuestra BBDD)
 *	para lograr que todos los títulos compartan el mismo año aleatorio
*/

with NumAleatorio as (
    select distinct titulo, FLOOR(random() * (2020 - 1950 + 1) + 1950)::int AS anno_aleatorio
    from pelicula
) --lo anterior es el cte
update pelicula p
set anno_publicacion = na.anno_aleatorio
from NumAleatorio na where p.titulo = na.titulo;
  

-- Carga PRÉSTAMO
 
insert into prestamo (id_socio, id_film, fecha_prestamo, fecha_devolucion)
select s.id, p.id, tv.fecha_alquiler, tv.fecha_devolucion  
from tmp_videoclub tv 
inner join socio s on tv.dni = s.dni 
inner join pelicula p on tv.id_copia = p.id;
--group by s.id, p.id, tv.fecha_alquiler, tv.fecha_devolucion order by s.id;


-- ############################################################### --


with NumAleatorio as (
    select distinct titulo, FLOOR(random() * (2020 - 1950 + 1) + 1950)::int AS anno_aleatorio
    from pelicula
) --lo anterior es el cte
update pelicula p
set anno_publicacion = na.anno_aleatorio
from NumAleatorio na where p.titulo = na.titulo;


-- peliculas con fecha devo != null
-- agrupo por titulo
-- hago count

with PelisPrestadas as(
	select *
	from pelicula p 
	inner join prestamo pr on p.id = pr.id_film 
	where pr.fecha_devolucion is null
)
--....

SELECT *
FROM pelicula p
WHERE NOT EXISTS (
	SELECT 1
	FROM prestamo pr
	WHERE p.id = pr.id_film
	AND pr.fecha_devolucion IS NULL
);

/*
 * Añado una copia más de SDLA para probar que el count funcione bien
 */
select * from pelicula p 
where p.titulo = 'El señor de los anillos: La comunidad del anillo';

insert into pelicula (id, titulo, anno_publicacion, sinopsis, id_director, id_genero)
values (309,'El señor de los anillos: La comunidad del anillo', 1966, 'En la Tierra Media, el Señor Oscuro Saurón creó los Grandes Anillos de Poder, forjados por los herreros Elfos. Tres para los reyes Elfos, siete para los Señores Enanos, y nueve para los Hombres Mortales. Secretamente, Saurón también forjó un anillo maestro, el Anillo Único, que contiene en sí el poder para esclavizar a toda la Tierra Media. Con la ayuda de un grupo de amigos y de valientes aliados, Frodo emprende un peligroso viaje con la misión de destruir el Anillo Único. Pero el Señor Oscuro Sauron, quien creara el Anillo, envía a sus servidores para perseguir al grupo. Si Sauron lograra recuperar el Anillo, sería el final de la Tierra Media.', 41, 6)


select titulo, count(id)
from pelicula p
where not exists (
	select pr.id_film  
	-- opc: poner un simple select 1. La idea es devolver algo si cumple la condición para testear el exist de arriba
	from prestamo pr
	where p.id = pr.id_film
	and pr.fecha_devolucion is null
	)
group by titulo;





/*
with CopiasPrestadas as(
	select id_film 
	from prestamo where fecha_devolucion = null 
);
*/


select count(id_film) 
from prestamo;   

