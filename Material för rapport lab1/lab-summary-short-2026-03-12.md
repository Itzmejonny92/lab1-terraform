# Kort Labbsammanfattning

Datum: 2026-03-12

Idag satte jag upp min Terraform-labb for GCP med en Ubuntu-VM, startup-script for hardening och en daglig backup-policy. Jag skapade ocksa en GitHub Actions-pipeline som kor `terraform fmt`, Trivy och `terraform validate` mot branchen `main`.

Jag stotte pa blockers kring GCP-IAM, GitHub-autentisering och branch-hantering. `terraform apply` stoppades av saknade GCP-behorigheter, Git-push over losenord fungerade inte utan behovde losas med `gh` i WSL, och repot behovde flyttas over till `main` som default branch for att matcha CI-workflown.

Jag verifierade ocksa att problemet i GCP inte bara handlade om login utan om saknade IAM-permissions for Compute Engine och resource policies. Samtidigt lades credentials in som GitHub Secret och workflown uppdaterades sa att GitHub Actions kan autentisera mot GCP i CI-miljon.

Nar jag korde `terraform plan` och `terraform apply` igen fungerade `plan`. Med en ny service account-nyckel kom `apply` forbi IAM-felet, och efter att jag tog bort publik IP fran VM:n gick hela deploymenten igenom. Bade VM:n och backup-kopplingen skapades korrekt.

Det mesta av kodarbetet ar klart. Slutlaget ar att `terraform apply` fungerar lokalt, och GitHub Actions kan nu ocksa kora en manuell `apply`-korning via `workflow_dispatch`. For att undvika konflikt med saknad delad remote state importeras de befintliga resurserna forst till jobbets temporara state innan `apply` kors.

Kommentar till lararen: Uppgiften ar nu verifierad bade lokalt och i GitHub Actions, inklusive en gron `apply`-korning med bifogad screenshot.

Som sista kontroll verifierade jag ocksa att kansliga och lokala Terraform-filer fortfarande ignorerades av `.gitignore`.
