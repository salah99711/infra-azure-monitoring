output "web_public_ip" {
  description = "Adresse IP publique de la VM Web"
  value       = azurerm_public_ip.web_ip.ip_address
}

output "monitoring_public_ip" {
  description = "Adresse IP publique de la VM Monitoring"
  value       = azurerm_public_ip.mon_ip.ip_address
}

