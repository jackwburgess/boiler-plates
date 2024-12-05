# dd--tf-boilerplate
Terraform Boilerplate for Datadog usage at scale.


## How To

* Create a [Terraform Cloud account](https://app.terraform.io/session) and [create a token](https://app.terraform.io/app/settings/tokens).
* Update environment variables [`.env`](.env)
* Update your list of teams in [`conf/boilerplate.tf`](conf/boilerplate.tf)


```bash
./terraform.sh login
./terraform.sh init
./terraform.sh apply

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
```