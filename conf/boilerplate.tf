## TEAMS DECLARATION ##### ##### ##### ##### ##### ##### ##### ##### #####

variable "team_names" {
  default = ["team-a", "team-b", "team-c", "team-d", "team-e", "team-f", "team-g", "team-h", "team-i", "team-j"]
}

resource "datadog_team" "teams" {
    for_each = toset(var.team_names)
    name = each.key
    handle = each.key
    description = "This is Team ${each.key}"
}

## TEAMS RESOURCES CREATION ##### ##### ##### ##### ##### ##### ##### ##### #####

## API KEYS

resource "datadog_api_key" "team_keys" {

  for_each = { for idx, team in datadog_team.teams : idx => team }

  name = "API Key for Team ${each.value.handle}"
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

  for_each = { for idx, team in datadog_team.teams : idx => team }

  name  = "${each.value.handle}-service-account"
  email = "${each.value.handle}-service@example.com"

  roles = [datadog_role.service_accounts_role.id]

}

resource "datadog_service_account_application_key" "app_keys" {

    depends_on = [datadog_team.teams]
    for_each = { for idx, sa in datadog_service_account.service_accounts : idx => sa }
    
    service_account_id = each.value.id
    name               = "Application key for managing ${each.value.name}"    

}

## LOG INDEXES

# Builds a unique log index per team onboarding to Datadog.

resource "datadog_logs_index" "sample_index" {
  for_each = { for idx, team in datadog_team.teams : idx => team }
    name  = "${each.value.handle}-index"
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

## USAGE MONITORS ##### ##### ##### ##### ##### ##### ##### ##### #####

## Please comment out any product which you do not currently use

variable "products" {
  default = {
    product-1 = { product_name = "apm_hosts" }
    product-2 = { product_name = "apm.indexed_spans" }
    product-3 = { product_name = "apm.ingested_bytes" }
    product-4 = { product_name = "asm.hosts" }
    product-5 = { product_name = "asm.traced_invocations" }
    product-6 = { product_name = "asm.vulnerability_oss_host" }
    product-7 = { product_name = "serverless.aws_lambda_functions" }
    product-9 = { product_name = "ci_visibility.pipeline.committers" }
    product-10 = { product_name = "ci_visibility.test.committers" }
    product-11 = { product_name = "containers" }
    product-12 = { product_name = "cspm.containers" }
    product-13 = { product_name = "cspm.hosts" }
    product-14 = { product_name = "custom_events" }
    product-15 = { product_name = "metrics.custom" }
    product-16 = { product_name = "cws.containers" }
    product-17 = { product_name = "cws.hosts" }
    product-18 = { product_name = "apm.data_streams_monitoring_hosts" }
    product-19 = { product_name = "dbm.hosts" }
    product-20 = { product_name = "error_tracking.logs.events" }
    product-21 = { product_name = "fargate_tasks" }
    product-22 = { product_name = "incident_management.active_users" }
    product-23 = { product_name = "hosts" }
    product-24 = { product_name = "logs.ingested_events" }
    product-25 = { product_name = "logs.ingested_bytes" }
    product-26 = { product_name = "network.devices" }
    product-27 = { product_name = "network.hosts" }
    product-28 = { product_name = "observability_pipelines.ingested_bytes" }
    product-29 = { product_name = "profiling.containers" }
    product-30 = { product_name = "profiling.fargate_tasks" }
    product-31 = { product_name = "profiling.hosts" }
    product-32 = { product_name = "rum.sessions" }
    product-33 = { product_name = "sds.scanned_bytes" }
    product-34 = { product_name = "security_monitoring.analyzed_events" }
    product-35 = { product_name = "serverless.traced_invocations" }
    product-36 = { product_name = "api_test_runs" }
    product-37 = { product_name = "browser_test_runs" }
  }
}

resource "datadog_monitor" "Usage_Monitors_Anomaly_Detection" {
  for_each = var.products
  include_tags = false
  new_group_delay = 0
  monitor_thresholds {
    critical = 1
    critical_recovery = 0
  }
  name = "[Datadog Usage Monitors][Anomaly Detection] The number of ${each.value.product_name} is abnormally high"
  type = "query alert"
  tags = ["usage-monitor:true"]
  query = <<EOT
avg(last_1d):anomalies(avg:datadog.estimated_usage.${each.value.product_name}{*} by {team}.rollup(avg, 300), 'agile', 5, direction='above', interval=300, alert_window='last_1h', count_default_zero='true', seasonality='daily', timezone='utc') >= 1
EOT
  message = <<EOT
The number of ${each.value.product_name} was {{value}} which is abnormally high.
EOT
}
  message = <<EOT
The number of ${each.value.product_name} was {{value}} which is abnormally high.
EOT
}
