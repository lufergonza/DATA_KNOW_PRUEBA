output "workspace_id" {
  description = "ID del Workspace de Fabric creado"
  value       = fabric_workspace.workspace.id
}

output "workspace_name" {
  description = "Nombre del Workspace"
  value       = fabric_workspace.workspace.display_name
}

output "lakehouse_bronze_id" {
  description = "ID del Lakehouse Bronze"
  value       = fabric_lakehouse.lh_bronze.id
}

output "lakehouse_silver_id" {
  description = "ID del Lakehouse Silver"
  value       = fabric_lakehouse.lh_silver.id
}

output "pipeline_id" {
  description = "ID del Pipeline principal"
  value       = fabric_data_pipeline.pipeline_medallion.id
}

