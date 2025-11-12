###cloud vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive   = true
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "ssh_pub_key" {
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name for the storage bucket"
  type        = string
  default     = "lepishin-12112025"
}

variable "image_path" {
  description = "Path to local image file"
  type        = string
  default     = "image.jpg"
}

variable "vm_image_id" {
  description = "ID of the LAMP image"
  type        = string
  default     = "fd827b91d99psvq5fjit"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "192.168.10.0/24"
}