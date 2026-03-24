
CREATE OR REPLACE VIEW vw_compras_general AS
SELECT 
 h.id_cliente,
 c.genero,
 c.edad,
 c.nivel_ingreso,
 c.ubicacion,

 h.categoria,
 p.calificacion_producto,

 h.canal_compra,
 h.metodo_pago,
 h.dispositivo,

 t.anio,
 t.mes,
 t.dia,

 -- Métricas
 h.monto_compra,
 h.frecuencia_compra,
 h.satisfaccion,
 h.tiempo_decision,

 -- Indicadores
 h.uso_descuento,
 h.miembro_lealtad

FROM hechos_compras h
JOIN dim_cliente c ON h.id_cliente = c.id_cliente
JOIN dim_producto p ON h.categoria = p.categoria
JOIN dim_canal ca ON h.canal_compra = ca.canal_compra
JOIN dim_tiempo t ON h.fecha_compra = t.fecha_compra;


CREATE OR REPLACE VIEW vw_ventas AS
SELECT 
 categoria,
 SUM(monto_compra) AS total_ventas,
 COUNT(*) AS total_transacciones,
 AVG(monto_compra) AS ticket_promedio
FROM hechos_compras
GROUP BY categoria;


CREATE OR REPLACE VIEW vw_clientes AS
SELECT 
 genero,
 nivel_ingreso,
 COUNT(*) AS total_clientes,
 AVG(edad) AS edad_promedio
FROM dim_cliente
GROUP BY genero, nivel_ingreso;


CREATE OR REPLACE VIEW vw_tiempo AS
SELECT 
 anio,
 mes,
 SUM(h.monto_compra) AS ventas_totales
FROM hechos_compras h
JOIN dim_tiempo t ON h.fecha_compra = t.fecha_compra
GROUP BY anio, mes;

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

DESCRIBE vw_compras_general;
DESCRIBE vw_ventas;
DESCRIBE vw_clientes;
DESCRIBE vw_tiempo;

