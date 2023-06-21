create database if not exists gimnasio3 character set utf8 collate utf8_general_ci;
use gimnasio3;

create table if not exists plan(
	codigo int not null primary key auto_increment,
    nombre varchar(100) not null,
    precio int not null,
    descripcion text(2000)
) engine=innodb;

create table if not exists persona(
	id_persona int not null primary key auto_increment,
    nombre varchar(100) not null,
    telefono int not null,
    correo varchar(100) unique,
    fecha_nacimiento date not null,
    sexo enum('Masculino','Femenino'),
    contraseña varchar(500) not null
)auto_increment=100 engine=innodb;
