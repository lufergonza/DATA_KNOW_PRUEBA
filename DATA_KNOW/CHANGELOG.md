
# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/), y este proyecto se adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-07-29

### Añadido
- **Orquestación de Datos**: Creación del pipeline principal en Microsoft Fabric estableciendo dependencias secuenciales estrictas (Bronze -> Silver -> Gold).
- **Automatización del Flujo**: Configuración de ejecución programada diaria a las 02:00 horas, integrando políticas de reintento automático (3 intentos con backoff exponencial) y notificaciones de alerta ante fallos.
- **Seguridad PII**: Implementación de enmascaramiento de datos sensibles aplicando un hash SHA-256 a la columna `id_miembro` dentro de la capa Silver.
- **Auditoría de Calidad**: Creación de un script en PySpark para generar reportes automatizados por cada ejecución, detallando el porcentaje de valores nulos por columna, conteo de registros conformes y aislamiento de registros rechazados mediante cruces lógicos (`left_anti`).

### Cambiado
- **Modelado Predictivo**: Actualización del enfoque del modelo de Machine Learning; transición estructurada hacia un modelo de clasificación, incorporando las métricas de evaluación correspondientes.
- **Gestión de Infraestructura**: Modificación temporal de la capacidad de cómputo (SKU) para garantizar los recursos de Spark necesarios durante las pruebas del orquestador.

### Corregido
- **Cálculos Matemáticos (Gold)**: Resolución de la excepción `UNRESOLVED_COLUMN` al calcular la `cobertura_dias`. Se implementó un cruce (`join`) previo de la tabla de stock con el histórico de ventas y se aseguró la operación contra la división por cero utilizando la función `F.when`.
- **Integridad Referencial (Silver)**: Corrección del error `DELTA_TABLE_NOT_FOUND` estandarizando la creación y escritura en modo `overwrite` de la dimensión `dim_ciudad` en el formato Delta Lake correcto.
- **Depuración de Código**: Solución de errores de formato, incluyendo el cierre adecuado de paréntesis en operaciones de escritura encadenadas y la limpieza de sangrías inesperadas (`IndentationError`) en los Notebooks de PySpark.
