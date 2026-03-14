output "vm_name" {
  value = google_compute_instance.vm.name
}

output "vm_external_ip" {
  value = try(google_compute_instance.vm.network_interface[0].access_config[0].nat_ip, null)
}

output "vm_zone" {
  value = google_compute_instance.vm.zone
}
