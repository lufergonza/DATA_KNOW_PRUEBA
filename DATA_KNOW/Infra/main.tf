# ---------------------------------------------------------
# 1. Workspace
# ---------------------------------------------------------
resource "fabric_workspace" "workspace" {
  display_name = "workspace-${var.project_prefix}-${var.environment}"
  description  = "Workspace para arquitectura medallón - Entorno: ${var.environment}"
  capacity_id  = var.capacity_id
}

# ---------------------------------------------------------
# 2. Lakehouses (Almacenamiento Medallón)
# ---------------------------------------------------------
resource "fabric_lakehouse" "lh_bronze" {
  display_name = "lh_${var.project_prefix}_bronze_${var.environment}"
  description  = "Capa Bronze: Datos crudos"
  workspace_id = fabric_workspace.workspace.id
}

resource "fabric_lakehouse" "lh_silver" {
  display_name = "lh_${var.project_prefix}_silver_${var.environment}"
  description  = "Capa Silver: Datos limpios"
  workspace_id = fabric_workspace.workspace.id
}

resource "fabric_lakehouse" "lh_gold" {
  display_name = "lh_${var.project_prefix}_gold_${var.environment}"
  description  = "Capa Gold: Datos agregados"
  workspace_id = fabric_workspace.workspace.id
}

# ---------------------------------------------------------
# 3. Notebooks
# ---------------------------------------------------------
resource "fabric_notebook" "nb_bronze" {
  display_name = "nb_01_ingesta_bronze_${var.environment}"
  description  = "Extrae datos y los guarda en Bronze"
  workspace_id = fabric_workspace.workspace.id
}

resource "fabric_notebook" "nb_silver" {
  display_name = "nb_02_transformacion_silver_${var.environment}"
  description  = "Transforma datos de Bronze a Silver"
  workspace_id = fabric_workspace.workspace.id
}

resource "fabric_notebook" "nb_gold" {
  display_name = "nb_03_agregacion_gold_${var.environment}"
  description  = "Genera métricas de Silver a Gold"
  workspace_id = fabric_workspace.workspace.id
}

# ---------------------------------------------------------
# 4. Pipeline
# ---------------------------------------------------------
resource "fabric_data_pipeline" "pipeline_medallion" {
  display_name = "pipeline_etl_${var.project_prefix}_${var.environment}"
  description  = "Orquesta ETL Completo en ${var.environment}"
  workspace_id = fabric_workspace.workspace.id
}

