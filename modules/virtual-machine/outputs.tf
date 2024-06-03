output "vm_password" {
  description = "The password for the virtual machine"
  value       = random_password.vm_password.result
  sensitive   = true
}
