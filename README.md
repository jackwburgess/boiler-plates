# dd-tf-boilerplate

A Terraform Boilerplate to onboard new Teams in an existing Datadog account, and create standard assets (service accounts, monitors, log indexes, etc.) for each of them.

This repo consists of 
* a [Terraform Configuration](conf/) - the *boilerplate* per se.
* a [Ubuntu Virtual Machine (Docker)](tf-box/) with Terraform CLI already installed and packaged in it. 


## Get Started

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

$ terraform.sh init

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

$ terraform.sh apply
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

```
