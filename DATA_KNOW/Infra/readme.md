# 🏗️ Infraestructura como Código (IaC) - Entorno Analítico

Este directorio contiene la definición de la Infraestructura como Código (IaC) necesaria para aprovisionar y gestionar automáticamente el entorno de procesamiento de datos en **Microsoft Fabric** y **Microsoft Azure**. 

El diseño despliega una Arquitectura Medallón completa, garantizando entornos aislados para cada fase del procesamiento y una orquestación centralizada.

## 📐 Recursos Aprovisionados

La ejecución de esta infraestructura despliega automáticamente los siguientes componentes:

### 1. Backend de Estado (Microsoft Azure)
*   **Storage Account:** Creación de una cuenta de almacenamiento dedicada en Azure.
*   **Contenedor de Estado:** Configuración de un contenedor remoto (`backend`) para almacenar de forma segura el archivo de estado de la infraestructura (ej. `terraform.tfstate`), permitiendo el trabajo colaborativo, la trazabilidad y el bloqueo de estado para evitar despliegues concurrentes.

### 2. Capa de Almacenamiento (Microsoft Fabric - OneLake)
Se aprovisionan tres **Lakehouses** independientes para segmentar físicamente los datos según su nivel de refinamiento en la Arquitectura Medallón:
*   `lakehouse_bronze`: Almacenamiento de datos crudos (Raw/Ingesta).
*   `lakehouse_silver`: Almacenamiento de datos limpios, enmascarados y estandarizados.
*   `lakehouse_gold`: Almacenamiento de datos agregados, KPIs de negocio y características para el modelo de clasificación.

### 3. Capa de Procesamiento y Orquestación (Microsoft Fabric)
*   **Notebooks (PySpark):** Despliegue de tres Notebooks de ingeniería de datos, cada uno vinculado a su respectivo Lakehouse (Bronze, Silver, Gold) para ejecutar las transformaciones correspondientes.
*   **Data Pipeline:** Creación de un pipeline automatizado que establece la dependencia secuencial de los Notebooks, orquestando el flujo completo (Ingesta $\rightarrow$ Transformación $\rightarrow$ Agregación/ML).

## ⚙️ Requisitos Previos

Para ejecutar y modificar esta infraestructura, necesitas:

1.  **Credenciales de Azure:** Una suscripción de Microsoft Azure activa con permisos para crear cuentas de almacenamiento (Storage Accounts).
2.  **Entorno de Fabric:** Un Workspace de Microsoft Fabric con capacidad asignada (SKU válido).
3.  **Herramienta de IaC:** Terraform (o la herramienta CLI correspondiente Bicep/ARM) instalada en tu máquina local.
4.  **Autenticación:** Sesión iniciada a través de Azure CLI (`az login`).

## 🚀 Despliegue de la Infraestructura

Sigue estos pasos para inicializar y desplegar los recursos en tu entorno:

1. **Inicializar el backend:** 
   Esto preparará el directorio y conectará la configuración con la Storage Account en Azure.
   ```bash
   terraform init
