# Kort Labbsammanfattning

Datum: 2026-03-12

Idag satte jag upp min Terraform-labb for GCP med en Ubuntu-VM, startup-script for hardening och en daglig backup-policy. Jag skapade ocksa en GitHub Actions-pipeline som kor `terraform fmt`, Trivy och `terraform validate` mot branchen `main`.

Det mesta av kodarbetet ar klart. Det som aterstar ar att fixa GCP-behorigheter, kora `terraform apply` och lagga in screenshots pa pipeline och VM i dokumentationen.
