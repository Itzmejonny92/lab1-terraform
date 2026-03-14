# Lab 1 Terraform for GCP

Detta projekt provisionerar en hardenad Ubuntu 22.04-VM i GCP med Terraform i projektet `chas-devsecops-2026`. Losningen skapar en `e2-micro`-instans i `europe-north1-a`, lagger till labels och tags, kor ett startup-script for grundlaggande hardening, skapar en daglig snapshot-policy for backup och kopplar policyn till VM-disken. For att komma forbi kvotproblemet med externa IP-adresser skapades den fungerande slutversionen utan publik IP.

## Hur man kor

Skapa en lokal `terraform.tfvars` som inte committas:

```hcl
project_id = "chas-devsecops-2026"
region     = "europe-north1"
student_id = "jonny-nguyen"
```

Kor sedan:

```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Om du kor lokalt med service account-fil:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="$PWD/gcp-sa-key.json"
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## GitHub Actions

Workflowen finns i `.github/workflows/terraform.yml` och kor:

- `lint` med `terraform fmt -check -recursive`
- `security` med Trivy IaC-scan
- `validate` med `terraform init -backend=false` och `terraform validate`
- `plan` med GCP-auth via `GCP_SA_KEY` och repo variables

`apply` kor inte i CI i den har versionen eftersom projektet saknar delad remote state for Terraform.

## Screenshot av pipeline som passerar

Befintlig bild kan anvandas som underlag:

```md
![Pipeline / Validate](Material%20f%C3%B6r%20rapport%20lab1/terraform%20init%20%26%20validate%20av%20Jonny%20Nguyen.png)
```

Om du tar en ny bild fran en helt gron Actions-korning kan du ersatta den med den.

## Screenshot av VM i GCP Console

Befintlig bild fran Compute Engine:

```md
![GCP VM](Material%20f%C3%B6r%20rapport%20lab1/vm%20instance%20running%20av%20Jonny%20Nguyen.png)
```

## Sakerhetsbeslut

- `ufw` anvands for att blockera inkommande trafik som standard och minska attackytan pa hostniva.
- `fail2ban` anvands for att minska risken for brute force-forsok mot SSH genom att banna aggressiva IP-adresser.
- `unattended-upgrades` anvands for att automatiskt installera sakerhetsuppdateringar.
- Startup-scriptet gor hardening reproducerbar vid ny provisionering.
- Snapshot-policy med sju dagars retention ger enkel aterstallning vid fel eller oonskade andringar.
- VM:n skapades utan publik IP i slutversionen for att undvika kvotproblemet `IN_USE_ADDRESSES` i `europe-north1`.

## Merge och Inlamning

- Arbetsgrenen `feature/initial-setup` ar mergad till `main`.
- Repo-URL for inlamning: `https://github.com/Itzmejonny92/lab1-terraform`
