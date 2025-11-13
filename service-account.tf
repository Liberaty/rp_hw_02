resource "yandex_iam_service_account" "vm-sa" {
  name        = "vm-service-account"
  description = "Service account for LAMP instance group"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "sa_vpc_admin" {
  folder_id = var.folder_id
  role      = "vpc.admin"
  member    = "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_lb_admin" {
  folder_id = var.folder_id
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_compute_admin" {
  folder_id = var.folder_id
  role      = "compute.admin"
  member    = "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_storage_viewer" {
  folder_id = var.folder_id
  role      = "storage.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "vm-sa-key" {
  service_account_id = yandex_iam_service_account.vm-sa.id
  description        = "Static key for VM management"
}