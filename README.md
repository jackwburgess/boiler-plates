# dd-tf-boilerplate

A Terraform Boilerplate to onboard new Teams in an existing Datadog account, and create standard assets (service accounts, monitors, log indexes, etc.) for each of them.

This repo consists of 
* a [Terraform Configuration](conf/) - the *boilerplate* per se.
* a Ubuntu Virtual Machine (Docker) with Terraform CLI already installed and packaged in it. 


## Get Started

* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* Create a [Terraform Cloud account](https://app.terraform.io/session) and [create a token](https://app.terraform.io/app/settings/tokens).
* Update environment variables [`.env`](.env)

* Update your list of teams in [`conf/boilerplate.tf`](conf/boilerplate.tf)


```bash
./terraform.sh login
./terraform.sh init
./terraform.sh apply

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
```

