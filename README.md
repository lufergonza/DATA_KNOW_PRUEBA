# DATA_KNOW_PRUEBA

# RetailNova: End-to-End Data Pipeline & Machine Learning

Este repositorio contiene la implementación de una arquitectura de datos analítica completa para **RetailNova**, construida bajo el enfoque de Arquitectura Medallón (Bronze, Silver, Gold). El proyecto abarca desde la ingesta y transformación de datos hasta la orquestación automatizada y la implementación de un modelo de clasificación de Machine Learning.

## 📐 Arquitectura del Proyecto

El flujo de procesamiento está diseñado en **Microsoft Fabric** utilizando **PySpark** y formato **Delta Lake**, estructurado en tres capas principales:

*   **Capa Bronze (Ingesta):** Extracción de datos crudos desde las bases de datos de origen y carga inicial con validación de volúmenes.
*   **Capa Silver (Limpieza y Calidad):** 
    *   Estandarización de formatos y manejo de valores nulos.
    *   Enmascaramiento de Información de Identificación Personal (PII) mediante algoritmos criptográficos (SHA-256).
    *   Separación de registros conformes y rechazados (cuarentena).
    *   Generación de reportes de calidad de datos por ejecución.
*   **Capa Gold (Negocio e IA):** 
    *   Generación de métricas clave, agregaciones y reglas de negocio (ej. `cobertura_dias`, `alerta_quiebre`).
    *   Preparación de características (Feature Engineering) para el modelado predictivo.
    *   Implementación y evaluación de un **modelo de clasificación** para predecir el comportamiento del negocio basado en el histórico de ventas e inventario.

## ⚙️ Orquestación (Microsoft Fabric Pipelines)

El flujo de ejecución está completamente automatizado garantizando la dependencia secuencial de las tareas (Bronze $\rightarrow$ Silver $\rightarrow$ Gold). 

**Características del Orquestador:**
*   **Programación:** Ejecución automática diaria a las 02:00 horas.
*   **Tolerancia a fallos:** Implementación de reintentos automáticos (3 intentos) con *backoff exponencial*.
*   **Timeouts:** Tiempo máximo de ejecución definido por tarea para optimización de capacidad (Spark Compute).
*   **Monitoreo y Alertas:** Notificaciones configuradas en caso de fallo (indicando DAG, tarea, fecha y error) y un reporte resumen diario en caso de éxito.

## 🛠️ Tecnologías Utilizadas

*   **Entorno:** Microsoft Fabric
*   **Motor de Procesamiento:** Apache Spark / PySpark
*   **Almacenamiento:** Delta Lake / OneLake
*   **Lenguaje:** Python
*   **Control de Versiones:** Git / GitHub

## 🚀 Cómo ejecutar este proyecto

1.  Clonar este repositorio en el entorno local o vincularlo directamente a un Workspace de Microsoft Fabric.
2.  Asegurar la configuración del SKU de capacidad para evitar contención de recursos en los clústeres de Spark.
3.  Ejecutar el Pipeline principal ubicado en la carpeta `/orchestration`, el cual disparará los Notebooks en el orden correspondiente.

---
**Autor:** LUISA FERNANDA GONZALEZ DELGADO 
