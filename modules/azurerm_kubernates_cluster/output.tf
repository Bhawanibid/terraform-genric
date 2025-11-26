output "kube_config_raw" {
  value = { for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_config_raw }
  sensitive = true
}

output "client_certificate" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config[0].client_certificate
  }
  sensitive = true
}
