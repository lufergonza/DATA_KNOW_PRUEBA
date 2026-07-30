# 🏗️ Infraestructura como Código (IaC) - Entorno Analítico

Este directorio contiene la definición de la Infraestructura como Código (IaC) necesaria para aprovisionar y gestionar automáticamente el entorno de procesamiento de datos en **Microsoft Fabric** y **Microsoft Azure**. 

El diseño despliega una Arquitectura Medallón completa, garantizando entornos aislados para cada fase del procesamiento y una orquestación centralizada.

## 📐 Recursos Aprovisionados

La ejecución de esta infraestructura despliega automáticamente los siguientes componentes:

### 1. Backend de Estado (Microsoft Azure)
*   **Storage Account:** Creación de una cuenta de almacenamiento dedicada en Azure.
*   **Contenedor de Estado:** Configuración de un contenedor remoto (`backend`) para almacenar de forma segura el archivo de estado de la infraestructura, permitiendo el trabajo colaborativo y el bloqueo de estado para evitar despliegues concurrentes.

### 2. Capa de Almacenamiento (Microsoft Fabric - OneLake)
Se aprovisionan tres **Lakehouses** independientes para segmentar físicamente los datos según su nivel de refinamiento en la Arquitectura Medallón:
*   `lakehouse_bronze`: Almacenamiento de datos crudos (Raw/Ingesta).
*   `lakehouse_silver`: Almacenamiento de datos limpios, enmascarados y estandarizados.
*   `lakehouse_gold`: Almacenamiento de datos agregados y características de Machine Learning.

### 3. Capa de Procesamiento y Orquestación (Microsoft Fabric)
*   **Notebooks (PySpark):** Despliegue de tres Notebooks de ingeniería de datos, cada uno vinculado a su respectivo Lakehouse.
*   **Data Pipeline:** Creación de un pipeline automatizado que establece la dependencia secuencial de los Notebooks.

## 📸 Evidencias del Despliegue

A continuación, se presentan las capturas del aprovisionamiento exitoso de la infraestructura:

![Backend Azure](docs_terraform/Captura%20de%20pantalla%202026-07-27%20014653.png)

## ⚙️ Requisitos Previos

Para ejecutar y modificar esta infraestructura, necesitas:
1.  **Credenciales de Azure:** Suscripción activa con permisos para Storage Accounts.
2.  **Entorno de Fabric:** Un Workspace con capacidad asignada (SKU válido).
3.  **Herramienta de IaC:** Terraform instalada en tu máquina local.
4.  **Autenticación:** Sesión iniciada a través de Azure CLI (`az login`).

## 🚀 Despliegue de la Infraestructura

1. **Inicializar el backend:** 
   ```bash
   terraform init
