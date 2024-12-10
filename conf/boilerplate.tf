## TEAMS DECLARATION ##### ##### ##### ##### ##### ##### ##### ##### #####

variable "team_names" {
  default = ["team1", "team2", "team3", "team4", "team5"]
}

data "datadog_team" "teams" {
  count          = length(var.team_names)
  filter_keyword = var.team_names[count.index]
}

## TEAMS RESOURCES CREATION ##### ##### ##### ##### ##### ##### ##### ##### #####


## API KEYS

resource "datadog_api_key" "team_keys" {
  for_each = { for idx, team in data.datadog_team.teams : idx => team }

  name = "API Key for ${each.value.filter_keyword}"
}


## SERVICE ACCOUNTS

data "datadog_permissions" "bar" {}

resource "datadog_role" "service_accounts_role" {

  name = "Teams service accounts"

  permission { id = data.datadog_permissions.bar.permissions.workflows_read     }
  permission { id = data.datadog_permissions.bar.permissions.workflows_write    }
  permission { id = data.datadog_permissions.bar.permissions.workflows_run      }

}

resource "datadog_service_account" "service_accounts" {

  for_each = { for idx, team in data.datadog_team.teams : idx => team }

  name  = "${each.value.filter_keyword}-service-account"
  email = "${each.value.filter_keyword}-service@example.com"

  depends_on = [datadog_role.service_accounts_role]
  roles = [datadog_role.service_accounts_role.id]

}

resource "datadog_service_account_application_key" "app_keys" {

    for_each = { for idx, sa in datadog_service_account.service_accounts : idx => sa }
    
    service_account_id = each.value.id
    name               = "Application key for managing ${each.value.name}"    

}

## LOG INDEXES

# A sample Datadog logs index resource definition.

resource "datadog_logs_index" "sample_index" {
  for_each = { for idx, team in data.datadog_team.teams : idx => team }
  name  = "${each.value.filter_keyword}-index"
  daily_limit = 200000
  daily_limit_reset {
    reset_time       = "14:00"
    reset_utc_offset = "+02:00"
  }
  daily_limit_warning_threshold_percentage = 50
  retention_days                           = 15
  flex_retention_days                      = 180
  filter {
    query = "team:${each.value.handle}"
  }
  exclusion_filter {
    name       = "debug logs"
    is_enabled = true
    filter {
      query       = "status:debug"
      sample_rate = 1.0
    }
  }
}
