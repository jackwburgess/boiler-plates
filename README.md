# Onboarding Starter Packs

The following Onboarding Governance Starter Packs can help customers automate and standarise their Datadog onboarding via Terraform templates. 
The core concept of the Governance Starter Packs is to provide a repository of assets for common onboarding tasks (see Onboarding Assets section).
These are typically deployed through a central observability team to enable a faster & more consistent Datadog deployment which follows best practices governance wise. 
By ensuring customers start their onboarding journey in the correct way (i.e. following the starter packs), we can ensure customers are following good governance standards. 
The Terraform based starter packs to onboard new Teams in an existing Datadog account.

This repo consists of 
* a [Terraform Configuration](conf/) - the *boilerplate* per se.
* a [Ubuntu Virtual Machine (Docker)](tf-box/) with Terraform CLI already installed and packaged in it. 

# Onboarding Assets

| Terraform Resource                     | Description                                                          |
|----------------------------------------|----------------------------------------------------------------------|
| datadog_team                           | Datadog Teams                                                        |
| datadog_api_key                        | Datadog API Keys                                                     |
| datadog_application_key                | Datadog API Keys                                                     |
| datadog_service_account                | Datadog Service Account                                              |
| datadog_logs_index                     | Datadog Log Index                                                    |

## Get Started

This repo consists of 
* a [Terraform Configuration](conf/) - the *boilerplate* per se.
* a [Ubuntu Virtual Machine (Docker)](tf-box/) with Terraform CLI already installed and packaged in it.
* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* Create a [Terraform Cloud account](https://app.terraform.io/session) and [create a token](https://app.terraform.io/app/settings/tokens).
* Update environment variables [`.env`](.env)

* Update your list of teams in [`conf/boilerplate.tf`](conf/boilerplate.tf)

Then open a Terminal in the dd-tf-boilerplate repo: 
* alias [terraform.sh](terraform.sh): `alias terraform=./terraform.sh`


```bash
$ terraform login
                                          -                                
                                          -----                           -
                                          ---------                      --
                                          ---------  -                -----
                                           ---------  ------        -------
                                             -------  ---------  ----------
                                                ----  ---------- ----------
                                                  --  ---------- ----------
   Welcome to HCP Terraform!                       -  ---------- -------
                                                      ---  ----- ---
   Documentation: terraform.io/docs/cloud             --------   -
                                                      ----------
                                                      ----------
                                                       ---------
                                                           -----
                                                               -

$ terraform init

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

$ terraform apply
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

```
