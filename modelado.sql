-- modelado 

DROP TABLE IF EXISTS dim_cliente;

-- tabla de clientes

CREATE TABLE dim_cliente AS
SELECT DISTINCT
 id_cliente,
 edad,
 genero,
 nivel_ingreso,
 estado_civil,
 nivel_educacion,
 ocupacion,
 ubicacion,
 miembro_lealtad
FROM clientes_limpio;

-- tabla de productos

DROP TABLE IF EXISTS dim_producto;

CREATE TABLE dim_producto AS
SELECT DISTINCT
 categoria,
 calificacion_producto,
 lealtad_marca
FROM clientes_limpio;

-- tabla de canal

DROP TABLE IF EXISTS dim_canal;

CREATE TABLE dim_canal AS
SELECT DISTINCT
 canal_compra,
 metodo_pago,
 dispositivo
FROM clientes_limpio;

-- tabla del tiempo

DROP TABLE IF EXISTS dim_tiempo;

CREATE TABLE dim_tiempo AS
SELECT DISTINCT
 fecha_compra,
 YEAR(fecha_compra) AS anio,
 MONTH(fecha_compra) AS mes,
 DAY(fecha_compra) AS dia
FROM clientes_limpio;

-- tabla de hechos

DROP TABLE IF EXISTS hechos_compras;

CREATE TABLE hechos_compras AS
SELECT 
 id_cliente,
 categoria,
 canal_compra,
 metodo_pago,
 dispositivo,
 fecha_compra,

 -- Métricas
 monto_compra,
 frecuencia_compra,
 tasa_devolucion,
 satisfaccion,
 tiempo_decision,
 tiempo_investigacion,

 -- Flags
 uso_descuento,
 miembro_lealtad

FROM clientes_limpio;

