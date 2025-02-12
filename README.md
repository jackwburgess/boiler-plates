# Onboarding Starter Packs

* The following Onboarding Starter Packs can help you automate & standarise your Datadog onboarding via Terraform templates. 
* The core concept of the Governance Starter Packs is to provide a repository of assets for common onboarding task.
* These are typically deployed through a central observability team to enable a faster/consistent Datadog deployment which follows best practices. 
* The Terraform based starter packs are designed to onboard new Teams in an existing Datadog account.

## Onboarding Assets

| Terraform Resource                     | Description                                                          |
|----------------------------------------|----------------------------------------------------------------------|
| datadog_team                           | Datadog Teams                                                        |
| datadog_api_key                        | Datadog API Keys                                                     |
| datadog_application_key                | Datadog API Keys                                                     |
| datadog_service_account                | Datadog Service Account                                              |
| datadog_logs_index                     | Datadog Log Index                                                    |

## Get Started

This repo contains: 
* a [Terraform Configuration](conf/) - the *boilerplate* per se.
* a [Ubuntu Virtual Machine (Docker)](tf-box/) with Terraform CLI already installed and packaged in it.

Please complete the following steps:
* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* Create a [Terraform Cloud account](https://app.terraform.io/session) and [create a token](https://app.terraform.io/app/settings/tokens).
* Update environment variables [`.env`](.env)
* Update your list of teams in [`conf/boilerplate.tf`](conf/boilerplate.tf)
Then open a Terminal in the dd-tf-boilerplate repo: 
* alias [terraform.sh](terraform.sh): `alias terraform=./terraform.sh`
