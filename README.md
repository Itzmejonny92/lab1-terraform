# Lab 1 Terraform for GCP

Detta projekt provisionerar en Ubuntu 22.04-VM i Google Cloud Platform med Terraform. Konfigurationen skapar en `e2-micro`-instans i `europe-north1-a`, tilldelar en publik IP, satter labels och tags, kor ett startup-script for grundlaggande hardening med `ufw`, `fail2ban` och `unattended-upgrades`, och kopplar dessutom pa en daglig snapshot-policy for backup av disken.

## Hur man kor

```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Variabler

Projektet anvander dessa variabler:

- `project_id`
- `region`
- `student_id`

Exempel finns i `example.tfvars`. Egna varden laggs i `terraform.tfvars`, som inte ska committas.

## GitHub Actions Pipeline

Pipelinen finns i `.github/workflows/terraform.yml` och innehaller tre jobb:

- `lint` kor `terraform fmt -check -recursive`
- `security` kor Trivy mot Terraform-konfigurationen
- `validate` kor `terraform init -backend=false` och `terraform validate`

### Screenshot av pipeline som passerar

Lagg din bild har nar pipelinen ar gron:

```md
![Pipeline Pass](docs/images/pipeline-pass.png)
```

## Screenshot av VM i GCP Console

Lagg din bild har nar VM:n syns i GCP Console:

```md
![GCP VM](docs/images/gcp-vm-console.png)
```

## Sakerhetsbeslut

- `ufw` anvands for att skapa en enkel host-baserad brandvagg. Standardregeln blockerar inkommande trafik och tillater endast utgaende trafik, med undantag for SSH.
- `fail2ban` anvands for att minska risken for brute force-forsok mot SSH genom att banna IP-adresser som uppvisar misstankt beteende.
- `unattended-upgrades` anvands for att automatiskt installera viktiga sakerhetsuppdateringar, vilket minskar tiden da kanda sarbarheter ligger opatchade.
- Startup-scriptet kor automatiskt vid uppstart, vilket gor att hardening blir reproducerbar och konsekvent mellan nya VM-instanser.
- En daglig snapshot-policy ar tillagd for att ge enkel aterstallning vid fel eller oonskade andringar.

## Status just nu

- Terraform-konfigurationen validerar lokalt.
- GitHub Actions-workflow ar skapad for `main`.
- Startup-scriptet ar lagt till och kopplat till VM:n.
- `terraform apply` stoppades tidigare av saknade GCP-behorigheter, inte av kodfel.
