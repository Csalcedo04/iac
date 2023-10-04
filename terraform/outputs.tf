output "virtual_machine_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "vpn_vm_ip" {
  value = azurerm_public_ip.public_ip_vpn.ip_address
}