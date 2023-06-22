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

    
create table if not exists clientes(
	id_cliente int not null primary key auto_increment,
    foreign key fk_cliente(id_cliente) references persona(id_persona)
    on update cascade on delete cascade,
    fecha_ini date not null,
    fecha_fin date not null,
    codigo_plan int not null,
    foreign key fk_cod_plan(codigo_plan) references plan(codigo)
    on update cascade on delete cascade,
    foto blob
) engine=innodb;

create table if not exists servicios(
	codigo int not null primary key,
    nombre varchar(100) not null
)engine=innodb;

create table if not exists empleado(
	id_empleado int not null primary key,
    foreign key fk_emplead(id_empleado) references persona(id_persona)
    on update cascade on delete cascade,
    foto blob
)engine=innodb;

create table if not exists servicios_empleados(
	id_empserv int not null primary key auto_increment,
    empleado int not null references empleado(id_empleado),
    servicio int not null references servicios(codigo)
);

create table if not exists entrenador(
	id_ent int not null primary key,
    foreign key fk_entre(id_ent) references empleado(id_empleado)
    on update cascade on delete cascade,
    curso varchar(20) not null
)engine=innodb;

create table if not exists nutricionista(
	id_nutri int not null primary key auto_increment,
    foreign key fk_nutri(id_nutri) references empleado(id_empleado)
    on update cascade on delete cascade
)engine=innodb;

create table if not exists recepcionista(
	id_rcp int not null primary key auto_increment,
    foreign key fk_rcp(id_rcp) references empleado(id_empleado)
    on update cascade on delete cascade
)engine=innodb;

create table if not exists fisioterapeuta(
	id_fisio int not null primary key auto_increment,
    foreign key fk_fisio(id_fisio) references empleado(id_empleado)
    on update cascade on delete cascade
)engine=innodb;


create table citas
(
id_cita int not null auto_increment primary key,
id_cliente int not null,
id_empleado int not null,
fecha date not null,
hora time not null,
estado_cita enum("confirmar", "cancelada", "completada"),
constraint fk_cte_cit foreign key (id_cliente) references clientes(id_cliente),
constraint fk_emp_cit foreign key (id_empleado) references empleado(id_empleado)
);

create table if not exists fichaMedica(
	id_ficha int not null primary key auto_increment,
    fecha date not null,
    peso int not null,
    altura int not null,
    med_cintura int ,
    med_cadera int ,
    med_cuello int ,
    porc_grasa_corporal int,
    masa_corp_magra  int ,
    objetivo varchar(500) ,
    id_emplead int not null,
    cita int not null,
    foreign key fk_cit(cita) references citas (id_cita),
    foreign key fk_dni_empl(id_emplead) references empleado(id_empleado)
    on update cascade on delete cascade,
    id_client int not null,
    foreign key fk_clie(id_client) references clientes(id_cliente)
    on update cascade on delete cascade,
    observaciones varchar(500),
    motivo varchar(500)
)engine=innodb;

insert into persona values
('','Anahi',871242794,'anahi@gmail.com','2000-01-01','Mujer','aaaa','Alvarez','Holguin'),
('','Kiara',8712782938,'kiara@gmail.com','2000-01-01','Mujer','bbbb','Barrientos','Salazar'),
('','Rene',8712347789,'rene@gmail.com','2000-01-01','Hombre','cccc', 'Arteaga','Meza'),
('','Adriana',8713475940,'adri@gmail.com','2000-01-01','Mujer','dddd','Soto','De Leon'),
('','Cesar',8723456712,'cesar@gmail.com','2001-01-01','Hombre','eeee','Campos','Villareal');

