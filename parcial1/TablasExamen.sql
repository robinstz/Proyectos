create table estudiantes1 (
	nombre varchar(150),
	edad varchar(150),
	genero varchar(150),
	direccion varchar (150),
	identificacion varchar (150)
	
)

create table presupuesto2 (
	Descripcion varchar(150),
	Monto varchar(150),
	Fecha varchar (150)
)

create table inventario3 (
	Nombre varchar(150),
	cantidad varchar(150),
	precio varchar (150),
	identificacion varchar (150)
)

create table pedidos4 (
	identificacion varchar (150)
	cliente varchar(150),
	producto varchar(150),
	entrega varchar (150),
	identificacion varchar (150)
)

create table ventas5 (
	fecha varchar(150),
	producto varchar(150),
	cantidad varchar (150),
	ingresos varchar (150)
)

select * from estudiantes1 ;
select * from presupuesto2 ;
select * from inventario3 ;
select * from pedidos4 ;
select * from ventas5 ;