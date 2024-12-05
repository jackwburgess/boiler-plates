## INPUTS ##### ##### ##### ##### ##### ##### ##### ##### #####

variable "dd_api_key" {
  type    = string
  sensitive   = true
}

variable "dd_app_key" {
  type    = string
  sensitive   = true
}

variable "dd_site" {
  type    = string
}

## OUTPUTS ##### ##### ##### ##### ##### ##### ##### ##### #####

output "team_ids" {
  value = [for team in data.datadog_team.teams : "${team.name}::${team.id}"]
}
