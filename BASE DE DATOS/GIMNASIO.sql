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
    empleado int not null,
    constraint fk_emp foreign key (empleado) references empleado(id_empleado),
    servicio int not null,
    constraint fk_serv foreign key (servicio) references servicios(codigo)
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

alter table citas drop foreign key fk_servicio;
alter table citas add constraint fk_servicio_cd foreign key (servicio) references servicios(codigo);
alter table citas auto_increment= 500;
select * from servicios;
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
    cliente int not null references cliente(id_cliente),
    observaciones text,
    motivo text
)engine=innodb;

alter table fichaMedica auto_increment=200;
alter table fichaMedica drop foreign key fk_cli;

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


/*NUEVOS REGISTROS EN LAS NUEVAS TABLAS 26/06/2023*/

insert into persona values ('','Nancy','Holguin','Vazquez',8717359273,'nancy@gmail.com',
'1970-10-23','Femenino','nnnn');
insert into persona values ('','Saul','Alvarez','Holguin',8715849665,'saul@gmail.com',
'1995-12-26','Masculino','sssss');

insert into cliente values (106,'2023-05-28','2023-06-28',2,'');
insert into cliente values (107,'2023-05-30','2023-06-30',3,'');



/*NUEVAS TABLAS 28/06/2023*/
create table citas (
id_cita int(10) primary key not null auto_increment,
fecha date,
hora time,
estado enum('confirmada','cancelada','completada'),
cliente int(10),
constraint foreign key fk_clie(cliente) references cliente(id_cliente),
serv_emp int(10),
constraint foreign key fk_serv_emp(serv_emp) references servicios_empleados(id_empserv)
);

alter table citas auto_increment=500;

create table if not exists ficha_nutri(
	id_ficha int not null primary key auto_increment,
    cita int(10),
    constraint foreign key fk_cita(cita) references citas(id_cita),
    peso decimal(5,2) not null,
    altura decimal(3,2) not null,
    med_cintura decimal(5,2) ,
    med_cadera decimal(5,2) ,
    med_cuello decimal(4,2) ,
    porc_grasa_corporal decimal(4,2),
    masa_corp_magra  decimal(4,2) ,
    objetivo text ,
    observaciones text,
    motivo text
);

alter table ficha_nutri auto_increment=200;

create table if not exists ficha_fisio(
	id_ficha int not null primary key auto_increment,
    cita int(10),
    constraint foreign key fk_cita_fisio (cita) references citas(id_cita),
    peso decimal(5,2) not null,
    altura decimal(3,2) not null,
    observaciones text,
    motivo text
);

alter table ficha_fisio auto_increment=300;

create table clases (
id_clase varchar(10) not null primary key,
dia varchar(15),
hora time
);

create table citas_spin (
id_citaspin int(10) not null primary key auto_increment,
fecha date,
estado enum('confirmada','cancelada','completada'),
cliente int(10),
constraint foreign key fk_clien(cliente) references cliente(id_cliente),
serv_emp int(10),
constraint foreign key fk_serv_empl(serv_emp) references servicios_empleados(id_empserv),
clase varchar(15),
constraint foreign key fk_clase(clase) references clases(id_clase)
);

alter table citas_spin auto_increment=400;


  select * from persona;
 SELECT * FROM empleado;
 select * from recepcionista;
 select * from entrenador;
 select * from fisioterapeuta;
 select * from nutricionista;
  select * from servicios_empleados;
  select * from servicios;
SELECT * FROM CLIENTE;
  select * from plan;
  select * from citas;
select * from citas_spin;
  select * from ficha_nutri;
  select * from ficha_fisio;
  select * from clases;
  select * from clases;

  
  
  insert into citas values
  ('','2023-06-29','16:00:00','confirmada',100,2202),
  ('','2023-06-25','13:00:00','completada',106,2201),
  ('','2023-06-28','14:00:00','cancelada',107,2202);
  
  
  insert into ficha_nutri values
  ('',501,63.5,1.70,75.5,105.6,25.5,22.3,75,60,'Llevar una dieta baja en carbos','Seguimiento');
  
  insert into clases values
  ('L-7','lunes','07:00:00'),
  ('L-8','lunes','08:00:00'),
  ('L-9','lunes','09:00:00'),
  ('M-7','martes','07:00:00'),
  ('M-8','martes','08:00:00'),
  ('M-9','martes','09:00:00'),
  ('Mi-7','miercoles','07:00:00'),
  ('Mi-8','miercoles','08:00:00'),
  ('Mi-9','miercoles','09:00:00'),
  ('J-7','jueves','07:00:00'),
  ('J-8','jueves','08:00:00'),
  ('J-9','jueves','09:00:00'),
  ('V-7','viernes','07:00:00'),
  ('V-8','viernes','08:00:00'),
  ('V-9','viernes','09:00:00');

insert into citas_spin values 
('','2023-06-15','completada',100,2200,'J-7'),
('','2023-07-03','confirmada',106,2200,'L-9'),
('','2023-06-30','cancelada',107,2200,'V-8');

insert into citas values
('','2023-06-27','17:00:00','completada',100,2202);

insert into ficha_fisio values
('',503,85,1.80,'colocar hielo en zona afectada','esguince');
