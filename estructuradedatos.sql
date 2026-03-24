
USE ecommerce_bi;
DROP TABLE IF EXISTS clientes_limpio;

CREATE TABLE clientes_limpio AS
SELECT 
 -- Identificador
 customer_id AS id_cliente,

 -- Datos personales
 age AS edad,
 UPPER(TRIM(gender)) AS genero,
 UPPER(TRIM(income_level)) AS nivel_ingreso,
 UPPER(TRIM(marital_status)) AS estado_civil,
 UPPER(TRIM(education_level)) AS nivel_educacion,
 UPPER(TRIM(occupation)) AS ocupacion,
 UPPER(TRIM(location)) AS ubicacion,

 -- Producto / compra
 UPPER(TRIM(category)) AS categoria,
 purchase_amount AS monto_compra,
 purchase_frequency AS frecuencia_compra,
 UPPER(TRIM(purchase_channel)) AS canal_compra,

 -- Comportamiento
 brand_loyalty AS lealtad_marca,
 product_rating AS calificacion_producto,
 research_time AS tiempo_investigacion,
 UPPER(TRIM(social_influence)) AS influencia_social,
 UPPER(TRIM(discount_sensitivity)) AS sensibilidad_descuento,
 return_rate AS tasa_devolucion,
 satisfaction AS satisfaccion,

 -- Interacción
 UPPER(TRIM(ad_interaction)) AS interaccion_anuncio,
 UPPER(TRIM(device)) AS dispositivo,
 UPPER(TRIM(payment_method)) AS metodo_pago,

 -- Tiempo
 purchase_date AS fecha_compra,

 -- Indicadores
 discount_used AS uso_descuento,
 loyalty_member AS miembro_lealtad,

 -- Decisión
 UPPER(TRIM(purchase_intention)) AS intencion_compra,
 UPPER(TRIM(shipping_preference)) AS preferencia_envio,
 decision_time AS tiempo_decision

FROM raw_customer_data;

SELECT COUNT(*) FROM clientes_limpio;