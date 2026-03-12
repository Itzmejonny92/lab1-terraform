# Labbsammanfattning

Datum: 2026-03-12

Idag byggde jag klart grunden for min forsta Terraform-labb i GCP. Jag skapade en Terraform-konfiguration som provisionerar en Ubuntu 22.04-VM med `e2-micro`, publik IP, labels och tags. Jag kopplade in ett startup-script som hardenar maskinen genom att installera och konfigurera `ufw`, `fail2ban` och `unattended-upgrades`. Syftet med det var att fa en mer saker standardkonfiguration direkt vid uppstart i stallet for att konfigurera allt manuellt efterat.

Jag byggde ocksa vidare pa infrastrukturen genom att lagga till en daglig backup-policy med `google_compute_resource_policy` och en attachment till VM-diskens resurs. Det gor att maskinen far regelbundna snapshots, vilket ar relevant ur bade drift- och sakerhetsperspektiv.

Utovar infrastrukturen satte jag upp en GitHub Actions-pipeline i `.github/workflows/terraform.yml`. Den kor tre viktiga kontroller: formatkontroll med `terraform fmt -check -recursive`, en sakerhetsskanning med Trivy samt `terraform validate` efter `terraform init -backend=false`. Det gor att projektet far en grundlaggande CI-kedja som fangar formatfel, vissa sakerhetsproblem och syntaxfel innan kod merges till `main`.

Jag skapade ocksa dokumentationsunderlag i projektet, inklusive README och sammanfattningar. Under verifieringen konstaterade jag att Terraform-planen ser korrekt ut med mina riktiga variabler, men att `terraform apply` blockeras av IAM-behorigheter i GCP. Det betyder att konfigurationen i sig ar i bra skick, men att jag senare maste losa credentials och roller for att kunna skapa resurserna i projektet.

Sammanfattningsvis har jag idag fatt pa plats infrastrukturkod, startup-hardening, backup-policy, CI-pipeline och dokumentation. Det som aterstar ar framfor allt att slutfora GCP-autentisering, kora `apply`, och sedan ta screenshots pa den passerande pipelinen och den skapade VM:n i GCP Console.
