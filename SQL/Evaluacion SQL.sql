create database EvaluacionSQL;
-- Entendi el programa como hacer todo distinto en ves de hacer 5 proveedores con 5 productos que sean iguales, aparte de tener mas variedad
create table proveedores (
	id int primary key not null auto_increment,
	nombre varchar(100) not null, -- Nombre proveedor
	rut varchar(100), 
	PrecioUnidadP int not null, -- Precio del producto por unidad o kg o litro, por mes
	CantidadP int not null -- Cuantos articulos provee
);

create table tipoProductos (
	id int primary key not null auto_increment,
	nombreP varchar(100) not null,
	Sector varchar(100),
	proveedores_id int
);

CREATE TABLE productos (
	id int primary key not null auto_increment,
	fechaV date not null, -- fecha vencimiento
	descripcionP varchar(200) not null,
	stock int, -- unidades en tienda
	tipoproductos_id int
);

create table Tienda (
	id int primary key not null auto_increment,
	nombreProducto varchar(100) not null, -- nombre de producto vendido
	precioUnidadV int not null, -- Precio al que lo vende el
	cantidad int not null, -- Cuanto vende
	productos_id int
);


alter table tipoproductos  
add constraint fk_proveedores_id foreign key (proveedores_id) references Proveedores(id);
alter table productos 
add constraint fk_tipoproductos_id foreign key (tipoproductos_id) references TipoProductos(id);
alter table tienda 
add constraint fk_productos_id foreign key (productos_id) references productos(id);
-- como dije arriba hice 5 distintos proveedores

insert into proveedores (nombre,rut,PrecioUnidadP,cantidadp)
values ("Chupete Suazo","10837191",1760,5),("Johnny Cage","13824775",1300,3),("Johnny Bravo","10745742",870,35),
("Matias Fernandez","15009745",3500,6),("Homero Simpson","12312313",40000,1);
-- Con 5 tipos de productos distintos no con 5 tipos de productos iguales
insert into tipoproductos (nombrep ,sector,proveedores_id)
values ("Leche","Lacteos",1),("Uvas","Secos",2),("Harina","Abarrotes",3),
("Zandia","Frutas",4),("Carne de Cerdo","Congelados",5);
-- Con 5 productos derivados de los tipos de productos
insert into productos (fechav,descripcionP,stock,tipoproductos_id)
values ('2023/10/11',"Embutido que se elabora con una mezcla de carnes de vacuno y porcino sazonadas y que es posteriormente ahumado y curado al aire",55,5),
('2034/12/11',"Bebida hecha de uva, mediante la fermentación alcohólica de su mosto o zumo",45,2),
('2024/07/02',"Sustancia líquida extraída de las frutas, generalmente al exprimirlas por presión",10,4),
('2039/02/10',"Consta de la compresión o trefilado de la masa",40,3),
('2035/01/01',"Alimento congelado que por lo general se hace de productos lácteos tales como leche",7,1);
-- Con esos productos , se elaboraban y hice un producto totalmente nuevo con los materiales del proveedor, para mi es coherente xD
insert into tienda (nombreProducto,precioUnidadV,cantidad,productos_id)
values ("Salami",4350,17,5),
("Helado",3500,4,1),
("Vino",14490,12,2),
("Jugo de Zandia",2000,10,4),
("Fideos",1000,40,3);

select * from proveedores p -- Uni la tabla proveedores con la de tipo de prodcutos
inner join tipoproductos t 
on p.id = t.proveedores_id
-- where p.id = 3; si quiero algo en especifico compilo con el where

select * from tipoproductos t2  -- tipo productos lo uni con productos
inner join productos p 
on t2.id = p.tipoproductos_id

SELECT (sum(precioUnidadV*cantidad)*12)-(sum(p.PrecioUnidadP*p.cantidadp)*12)
FROM proveedores p,tienda t
WHERE p.id = t.id; -- Ganancia total de todos los productos vendidos *12 para la venta por año

select nombreProducto,precioUnidadV*cantidad from tienda; -- Productos vendidos por mes
select nombreProducto,precioUnidadV,cantidad from tienda; -- Productos con su cantidad vendida y precio unitario

-- union select sum(PrecioUnidadP*cantidadp) from proveedores; -- probando funciones

-- select sum(PrecioUnidadP*cantidadp) from proveedores; -- probando funciones

-- select sum(precioUnidadV*cantidad) from tienda; -- probando funciones
