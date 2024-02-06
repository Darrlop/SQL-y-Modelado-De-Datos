--DROP SCHEMA videoclub CASCADE;
--C:\Users\arrar\AppData\Roaming\DBeaverData\workspace6\General\Scripts

create schema if not exists videoclub;
set schema 'videoclub';


-- TABLAS --

create table if not exists socio(
	id smallserial primary key,
	nombre varchar(15) not null,
	apellido1 varchar(20) not null,
	apellido2 varchar(20) not null,
	telefono varchar(9) not null,
	fecha_nacimiento date not null
);


create table if not exists direccion(
	id smallserial primary key,
	id_socio smallint not null,
	calle varchar(20) not null,
	numero varchar(6) not null,
	piso varchar(9) not null,
	id_cp smallint not null	
);

create table if not exists codigo_postal(
	id smallserial primary key,
	numero_cp varchar(5) not null
);

create table if not exists pelicula(
	id smallserial primary key,
	titulo varchar(50) not null,
	anno_publicacion smallint not null,
	sinopsis text not null,
	id_director smallint not null,
	id_genero smallint not null
);

create table if not exists director(
	id smallserial primary key,
	nombre_director varchar(40) not null
);

create table if not exists genero(
	id smallserial primary key,
	tipo_genero varchar(20) not null
);

create table if not exists prestamo(
	id serial primary key,
	id_socio smallint not null,
	id_film smallint not null,
	fecha_prestamo date not null,
	fecha_devolucion date not null
);


-- RELACIONES --

alter table pelicula
add constraint fk_genero_pelicula
foreign key (id_genero)
references genero(id);

alter table pelicula
add constraint fk_director_pelicula
foreign key (id_director)
references director(id);


alter table direccion
add constraint fk_cp_direccion
foreign key (id_cp)
references codigo_postal(id);


alter table direccion 
add constraint fk_socios_direccion
foreign key (id_socio)
references socio(id);


alter table prestamo
add constraint fk_pelicula_prestamo
foreign key (id_film)
references pelicula(id);

alter table prestamo 
add constraint fk_socio_prestamo
foreign key (id_socio)
references socio(id);




