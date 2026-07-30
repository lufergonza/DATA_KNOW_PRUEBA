# 📓 Notebooks de Ingeniería de Datos: Arquitectura Medallón en Microsoft Fabric

Este directorio contiene los Notebooks de PySpark que orquestan el pipeline de datos principal del proyecto **RetailNova**. 

El flujo de procesamiento implementa una **Arquitectura Medallón (Bronze, Silver, Gold)**, transformando progresivamente los datos sintéticos generados, garantizando su calidad, aplicando reglas de negocio y preparándolos para su consumo analítico a través de vistas SQL y modelos de Machine Learning.

## 🏗️ Flujo de Procesamiento y Capas (Lakehouses)

El procesamiento está dividido en tres etapas secuenciales, cada una operando sobre su propio Lakehouse aislado en Microsoft Fabric:

### 🥉 1. Capa Bronze (Ingesta y Datos Crudos)
*   **Notebook:** `01_Ingesta_Bronze.ipynb`
*   **Objetivo:** Leer los datos transaccionales, de clientes y catálogo generados por el script de simulación (`Faker`).
*   **Formato de salida:** Tablas en formato Delta Lake (`delta`). Se almacenan exactamente con la misma estructura y granularidad que la fuente original, asegurando un punto de recuperación sin pérdida de información.

### 🥈 2. Capa Silver (Calidad, Limpieza y Privacidad)
*   **Notebook:** `02_Transformacion_Silver.ipynb`
*   **Objetivo:** Estandarizar formatos de fecha, castear tipos de datos y aplicar reglas de calidad (eliminación de duplicados y nulos).
*   **Seguridad y Gobierno:** En esta capa se aplican las lógicas de enmascaramiento dinámico (Data Masking) y hashing criptográfico (SHA-256) sobre los PII (Información Personal Identificable) de los clientes para cumplir con el principio de Mínimo Privilegio.

### 🥇 3. Capa Gold (Agregaciones y KPIs de Negocio)
*   **Notebook:** `03_Agregacion_Gold.ipynb`
*   **Objetivo:** Realizar cruces (Joins) complejos entre tablas de hechos y dimensiones para calcular KPIs de ventas, retención de clientes, y comportamiento de inventario.
*   **Preparación para ML:** Generación de un *Feature Store* tabular optimizado para el entrenamiento del modelo de **clasificación** de abandono (Churn).

## 🗄️ Consumo mediante SQL Analytics Endpoint

El Lakehouse Gold no solo almacena los datos en formato Delta, sino que Microsoft Fabric los expone automáticamente a través del **SQL Analytics Endpoint**. Esto permite:
*   Realizar consultas usando sintaxis **T-SQL** tradicional directamente sobre los datos Gold.
*   Conectar **Power BI** en modo *Direct Lake*, garantizando tiempos de respuesta ultrarrápidos sobre millones de registros sin necesidad de duplicar los datos.
*   Establecer permisos de seguridad granulares (nivel de fila/columna) para el rol de *Analista*.

## 📸 Evidencias de Ejecución (Notebooks y SQL Endpoint)

A continuación, se documenta la ejecución exitosa de los Notebooks, la persistencia en los Lakehouses y la consulta de las tablas procesadas:


![Evidencia Notebook 1](Captura%20de%20pantalla%202026-07-29%20123951.png)
![Evidencia Notebook 2](Captura%20de%20pantalla%202026-07-29%20125254.png)
![Evidencia Notebook 3](Captura%20de%20pantalla%202026-07-29%20185439.png)


![Evidencia Lakehouse 1](Captura%20de%20pantalla%202026-07-29%20202235.png)
![Evidencia Lakehouse 2](Captura%20de%20pantalla%202026-07-29%20202302.png)


![Evidencia SQL Endpoint 1](Captura%20de%20pantalla%202026-07-29%20202351.png)
![Evidencia SQL Endpoint 2](Captura%20de%20pantalla%202026-07-29%20210351.png)

## 🚀 Requisitos para Ejecución
1.  Permisos de nivel **Contributor** en el Workspace de Microsoft Fabric.
2.  Pipeline orquestador configurado para ejecutar los notebooks en orden estricto (Bronze $\rightarrow$ Silver $\rightarrow$ Gold) para evitar errores de capacidad y dependencia de tablas.


