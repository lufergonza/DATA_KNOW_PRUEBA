# 🧬 Generación de Datos Sintéticos con Faker

Este módulo contiene los scripts y la lógica utilizada para generar conjuntos de datos sintéticos realistas para el proyecto **RetailNova**. 

Dado que las normativas de privacidad impiden el uso de datos de clientes reales en entornos de desarrollo, se implementó la librería `Faker` en Python para simular perfiles demográficos, transacciones comerciales y catálogos de productos, garantizando el volumen y la varianza necesarios para alimentar nuestra Arquitectura Medallón y el posterior modelo de clasificación.

## 🛠️ Tecnologías y Librerías

*   **Python:** Lenguaje principal de orquestación.
*   **Faker:** Generación aleatoria de nombres, direcciones, correos electrónicos y fechas.
*   **Pandas / PySpark:** Estructuración de los datos generados en DataFrames para su exportación e ingesta en la capa Bronze.

## 📊 Estructura de los Datos Simulados

El script de generación está diseñado para mantener la integridad referencial entre las tablas simuladas:
1.  **Dimensión de Miembros (Clientes):** Perfiles únicos con edades, ubicaciones y datos de contacto realistas.
2.  **Dimensión de Productos:** Catálogo simulado con categorías, SKUs y precios base.
3.  **Hechos de Ventas (Transacciones):** Historial de compras que cruza clientes y productos, simulando recencia, frecuencia y valor monetario (RFM) para el análisis de negocio.

## 📸 Evidencias del Proceso de Generación

A continuación se documenta visualmente la ejecución de los scripts, la configuración de los parámetros de `Faker` y la validación de los DataFrames resultantes:

### Configuración y Ejecución del Script
![Generación Faker 1](docs_data/imagenes/Captura%20de%20pantalla%202026-07-27%20195605.png)
![Generación Faker 2](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20224538.png)

### Estructuración de DataFrames
![Estructura de Datos 1](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20225430.png)
![Estructura de Datos 2](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20225758.png)
![Estructura de Datos 3](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20225831.png)

### Validación y Exportación de Resultados
![Validación Resultados 1](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20230045.png)
![Validación Resultados 2](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20230206.png)
![Validación Resultados 3](docs_data/imagenes/Captura%20de%20pantalla%202026-07-28%20230542.png)

## 🚀 Cómo ejecutar la simulación localmente

1.  Asegúrate de tener instalado el entorno virtual con las dependencias necesarias:
    ```bash
    pip install Faker pandas
    ```
2.  Ejecuta el script principal de generación:
    ```bash
    python generar_datos.py
    ```
3.  Los archivos resultantes (ej. `.csv` o `.parquet`) se guardarán automáticamente en el directorio de salida configurado, listos para ser ingestados en el Lakehouse.

---
**Autor:** LUISA FERNANDA GONZALEZ DELGADO 
