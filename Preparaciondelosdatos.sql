

-- ✅ 1. Crear la base de datos
CREATE DATABASE ecommerce_bi;
USE ecommerce_bi;

-- 2. Crear tabla Raw (Staging):
DROP TABLE IF EXISTS raw_customer_data;
CREATE TABLE raw_customer_data (
    customer_id VARCHAR(50),      -- Cambiado a VARCHAR por los guiones
    age INT,
    gender VARCHAR(20),
    income_level VARCHAR(20),
    marital_status VARCHAR(20),
    education_level VARCHAR(50),
    occupation VARCHAR(100),
    location VARCHAR(100),
    category VARCHAR(100),
    purchase_amount DECIMAL(10,2),
    purchase_frequency INT,
    purchase_channel VARCHAR(50),
    brand_loyalty INT,
    product_rating INT,
    research_time INT,
    social_influence VARCHAR(20),
    discount_sensitivity VARCHAR(30),
    return_rate DECIMAL(5,2),
    satisfaction INT,
    ad_interaction VARCHAR(20),
    device VARCHAR(50),
    payment_method VARCHAR(50),
    purchase_date DATETIME,
    discount_used BOOLEAN,
    loyalty_member BOOLEAN,
    purchase_intention VARCHAR(50),
    shipping_preference VARCHAR(50),
    decision_time INT             -- Se eliminó 'payment_frequency'
);
-- 3. Importar los Datos

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE "secure_file_priv";
TRUNCATE TABLE raw_customer_data;
SELECT COUNT(*) FROM raw_customer_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.6/Uploads/Ecommerce_Consumer_Behavior_Analysis_Data.csv'
INTO TABLE raw_customer_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(
 @customer_id, age, gender, income_level, marital_status, education_level, 
 occupation, location, category, @amount, purchase_frequency, purchase_channel, 
 brand_loyalty, product_rating, research_time, social_influence, 
 discount_sensitivity, return_rate, satisfaction, ad_interaction, device, 
 payment_method, @p_date, @d_used, @l_member, purchase_intention, 
 shipping_preference, decision_time
)
SET 
 customer_id = TRIM(@customer_id),

 purchase_amount = CAST(
     REPLACE(REPLACE(@amount, '$', ''), ' ', '') 
     AS DECIMAL(10,2)
 ),

 purchase_date = STR_TO_DATE(@p_date, '%m/%d/%Y'),

 discount_used = IF(UPPER(@d_used) = 'TRUE', 1, 0),
 loyalty_member = IF(UPPER(@l_member) = 'TRUE', 1, 0);
 
 -- 4 verificacion de los datos
 
 SELECT * FROM raw_customer_data LIMIT 10; -- Para ver una muestra de los datos (las primeras 10 filas)
 SELECT COUNT(*) AS total_registros FROM raw_customer_data; -- ver la catidad de registros
 
 SELECT customer_id, COUNT(*) 
FROM raw_customer_data
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT 
 MIN(age) AS edad_min,
 MAX(age) AS edad_max,
 MIN(purchase_amount) AS compra_min,
 MAX(purchase_amount) AS compra_max
FROM raw_customer_data;

SELECT DISTINCT gender FROM raw_customer_data;
SELECT DISTINCT payment_method FROM raw_customer_data;
SELECT DISTINCT purchase_channel FROM raw_customer_data;

SELECT 
 MIN(purchase_date),
 MAX(purchase_date)
FROM raw_customer_data;


 
 
 