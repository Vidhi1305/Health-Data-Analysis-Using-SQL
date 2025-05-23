-- Databricks notebook source
select * from health_data limit 5;

-- COMMAND ----------

select * 
from health_data
where `Gender (Patient)`=1
and `Visit Type`= 'Office'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC  --1.	Total Visits per Month – How many total visits occurred in each month (YYYYMM)?

-- COMMAND ----------

select YYYYMM , sum(`number of visits`) as total_visit 
from health_data
group by YYYYMM
order by YYYYMM

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --2.	 Visits by Patient Age Group – How many visits occurred for each patient age group (Age Group (Patient))?

-- COMMAND ----------

select `Age Group (Patient)` , sum(`number of visits`) as total_visit 
from health_data
group by `Age Group (Patient)`
order by `Age Group (Patient)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --3.	 Visits by Patient Gender – What is the total number of visits for each gender (Gender (Patient))?

-- COMMAND ----------

select `Gender (Patient)`, sum(`Number of Visits`) as total_number
from health_data
group by `Gender (Patient)`
order by `Gender (Patient)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC  --4.	 Visits by Health Zone of Patient and Physician – How many visits happened between different patient and physician health zones?

-- COMMAND ----------

select `Health Zone (Patient)`,`Health Zone (Physician)`, sum(`Number of Visits`) as visit
from health_data
WHERE `Health Zone (Patient)` != `Health Zone (Physician)`
group by `Health Zone (Patient)`,`Health Zone (Physician)`
order by `Health Zone (Patient)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC  --5.	Most Common Visit Type – Which visit type (Visit Type) had the highest number of visits?

-- COMMAND ----------

select `Visit Type` , sum(`Number of Visits`) as total
from health_data
group by `Visit Type`
order by total desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --6.	 Top 3 Patient Health Zones with Most Visits – Which top 3 patient health zones had the highest number of visits?

-- COMMAND ----------

select `Health Zone (Patient)` , sum(`Number of Visits`) as total
from health_data
group by `Health Zone (Patient)`
order by total desc
limit 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --7.	 Visits by Physician Gender – How many visits were handled by male vs. female physicians?

-- COMMAND ----------

select `Gender (Physician)` , sum(`Number of Visits`) as total
from health_data
group by `Gender (Physician)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC  --8.	 Number of Visits by Age Group and Gender – How many visits occurred per patient age group and gender?

-- COMMAND ----------

select `Age Group (Patient)`, `Gender (Patient)`, sum(`Number of Visits`) as total
from health_data
group by `Age Group (Patient)`,`Gender (Patient)`
order by `Age Group (Patient)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --9.	Visits where Patient & Physician are in the Same Health Zone – How many visits happened where the patient and physician were in the same health zone?

-- COMMAND ----------

select `Health Zone (Patient)`,`Health Zone (Physician)`, sum(`Number of Visits`) as total
from health_data
where `Health Zone (Patient)`= `Health Zone (Physician)`
group by `Health Zone (Patient)`,`Health Zone (Physician)`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC --10.	Monthly Visits Trend for a Specific Age Group – What is the monthly trend of visits for patients aged 00-04 years?

-- COMMAND ----------

select `Age Group (Patient)`, YYYYMM,`Visit Type`, sum(`Number of Visits`) 
from health_data
where `Age Group (Patient)` = '00 - 04 Years'
group by YYYYMM
order by YYYYMM
