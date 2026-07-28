variable "environment" {
  type        = string
  description = "Entorno de despliegue (ej. dev, prod)"
}

variable "project_prefix" {
  type        = string
  description = "Prefijo del proyecto para estandarizar nombres"
  default     = "retailnova"
}

variable "capacity_id" {
  type        = string
  description = "ID de la capacidad de Microsoft Fabric. Debe inyectarse de forma segura."
}