use egogym;

/*CONSULTAS DEL LADO DEL CLIENTE
 1.Buscar citas disponibles en determinada fecha para determinado servicio*/
select * from citas
inner join servicios_empleados on citas.serv_emp=servicios_empleados.id_empserv
inner join servicios on servicios_empleados.servicio=servicios.codigo
where citas.estado='cancelada' or 'completada'
and servicios.nombre = 'fisioterapia'
and citas.fecha = '2023-06-28';

  /*2.Buscar el perfil de determinado empleado. (foto, nombre de persona y servicio que brinda)*/


/*3.BUSCAR O VISUALIZAR SU PROPIO HISTORIAL DE CITAS*/


/*CONSULTAS PARA EL LADO DEL EMPLEADO
1.Buscar el perfil de determinado cliente. (datos de cliente y su ficha medica)*/



/*- 2.citas agendadas para cierta fecha para determinado empleado.*/




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

/*CONSULTAS 28/06/2023*/
select id_empleado from empleado 
inner join persona on empleado.id_empleado=persona.id_persona
where nombre = 'Rene';