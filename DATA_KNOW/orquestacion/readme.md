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
![Evidencia SQL Endpoint 2](Captura%20de%20pantalla%202026-07-29%20210351.png)
## 🚨 Troubleshooting y Errores Conocidos

Durante el desarrollo y la ejecución del pipeline en **Microsoft Fabric**, se documentó el siguiente incidente relacionado con los límites de infraestructura. Se detalla la causa raíz y la solución implementada para referencia futura.

### Incidente: Límite de Capacidad de Cómputo en Spark (Error HTTP 430)

**Descripción del Error:**
Al ejecutar el Data Pipeline orquestador, los Notebooks fallan y pasan a estado *Failed* arrojando el siguiente mensaje en los logs de la sesión de Livy:
> `Error: [TooManyRequestsForCapacity] HTTP Response code 430: This Spark job can't be run because you've hit spark overall capacity compute limit.`

**Causa Raíz:**
El error se produce por una saturación en la capacidad de cómputo (V-Cores) asignada al Workspace de Fabric (SKU actual). Al intentar ejecutar múltiples Notebooks de PySpark de forma concurrente, o si existen sesiones previas "atascadas" en segundo plano, el entorno no tiene recursos físicos suficientes para inicializar un nuevo clúster de Spark, provocando un rechazo inmediato por límite de concurrencia.

**Solución y Mitigación Implementada:**
Para garantizar la estabilidad del pipeline en producción, se aplicaron las siguientes acciones correctivas:

1. **Gestión de Recursos Atascados:** 
   * Se ingresó al *Monitoring Hub* (Centro de supervisión) de Fabric para cancelar manualmente las sesiones en estado *In progress* o *Queued* que estaban consumiendo recursos de ejecuciones anteriores fallidas.
2. **Orquestación Secuencial (Pipeline):** 
   * Se modificó el diseño del Data Pipeline para evitar paralelismos innecesarios. Se configuraron dependencias estrictas (`On Success`) garantizando que solo exista una sesión activa a la vez: `Notebook Bronze` $\rightarrow$ `Notebook Silver` $\rightarrow$ `Notebook Gold`.
3. **Ajuste de Tamaño del Clúster:** 
   * En *Workspace Settings > Data Engineering > Spark Compute*, se redujo el tamaño de los nodos (Node Size) del clúster por defecto a "Small", reduciendo significativamente la cantidad de V-Cores requeridos para arrancar cada etapa del proceso.
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


