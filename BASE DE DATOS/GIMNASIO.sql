create database if not exists egogym character set utf8 collate utf8_general_ci;
use egogym;

create table if not exists plan(
	codigo int not null primary key auto_increment,
    nombre varchar(100) not null,
    precio int not null,
    descripcion text(2000)
) engine=innodb;

create table if not exists persona(
	id_persona int not null primary key auto_increment,
    nombre varchar(50) not null,
    apellido_paterno varchar(50) not null,
    apellido_materno varchar(50) not null,
    telefono int not null,
    correo varchar(100) unique,
    fecha_nacimiento date not null,
    sexo enum('Masculino','Femenino'),
    contraseña varchar(500) not null
    )auto_increment=100 engine=innodb;
    
    create table if not exists cliente(
	id_cliente int not null primary key,
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

alter table servicios_empleados auto_increment=2200;

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
servicio int not null,
constraint fk_servicio foreign key (servicio) references servicios_empleados(id_empserv),
fecha date not null,
hora time not null,
estado_cita enum("confirmar", "cancelada", "completada"),
cliente int not null,
constraint fk_cte_cit foreign key (cliente) references cliente(id_cliente)
);

alter table citas auto_increment= 500;

create table if not exists fichaMedica(
	id_ficha int not null primary key auto_increment,
    fecha date not null,
    peso decimal(5,2) not null,
    altura decimal(3,2) not null,
    med_cintura decimal(5,2) ,
    med_cadera decimal(5,2) ,
    med_cuello decimal(4,2) ,
    porc_grasa_corporal decimal(4,2),
    masa_corp_magra  decimal(4,2) ,
    objetivo text ,
    cita int not null,
    foreign key fk_cit(cita) references citas(id_cita),
    cliente int not null,
    foreign key fk_cli(cliente) references cliente(id_cliente)
    on update cascade on delete cascade,
    observaciones text,
    motivo text
)engine=innodb;

alter table fichaMedica auto_increment=200;

insert into persona values
('','Anahi','Alvarez','Holguin',871242794, 'anahi@gmail.com','2000-01-01','Femenino','aaaa'),
('','Kiara','Barrientos','Salazar',8712782938,'kiara@gmail.com','2000-01-01','Femenino','bbbb'),
('','Rene', 'Arteaga','Meza',8712347789,'rene@gmail.com','2000-01-01','Masculino','cccc'),
('','Adriana','Soto','De Leon',8713475940,'adri@gmail.com','2000-01-01','Femenino','dddd'),
('','Cesar','Campos','Villareal',8723456712,'cesar@gmail.com','2000-01-01','Masculino','eeee');

insert into plan values
('','Plan 1',300,'el basico'),
('','Plan 2',500,'el decente'),
('','Plan 3',650,'el de lujo');

insert into cliente values
(100,'2023-05-10','2023-06-10',1,'');

insert into empleado values
(101,''),
(102,''),
(103,''),
(104,'');

insert into servicios values
(1,'spinning'),
(2,'fisioterapia'),
(3,'nutricion');

insert into fisioterapeuta values
(101);

insert into entrenador values
(102, 'spinning');

insert into nutricionista values
(103);

insert into recepcionista values
(104);

insert into servicios_empleados values
('',102,1),
('',103,3),
('',101,2);

insert into citas values 
('',2201,'2023-06-23','16:00:00','confirmar',100);

insert into fichaMedica values
('','2023-06-23',63.5,1.70,77.5,105.2,25.5,22.2,70,'bajar 2kg',500,100,
'Comer mas vegetales y beber suficiente agua.Seguir el plan de alimentacion y la 
rutina disciplinadamente','consulta de seguimiento');

