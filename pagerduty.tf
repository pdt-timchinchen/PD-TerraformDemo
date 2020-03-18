# Configure the PagerDuty provider
provider "pagerduty" {
  #token = "${var.pagerduty_token}"
  #LIVE DEMO ####################
  token = "XXXXXXXXXXXXXXXX"
  #TEST DEMO ####################
  #token = "XXXXXXXXXXXXXXXX"
}

################################################################################################
# Create PagerDuty teams - Automation, Operations, Banking Development (DevOps), Management
resource "pagerduty_team" "automation" {
  name        = "Automation"
  description = "All automation engineers" 
}
resource "pagerduty_team" "Operations" {
  name        = "Operations Team"
  description = "Operations Team" 
}
resource "pagerduty_team" "bankingDev" {
  name        = "Banking DevOps Team"
  description = "Banking DevOps Team" 
}
resource "pagerduty_team" "Stakeholders" {
  name        = "Stakeholders"
  description = "Management Team" 
}
################################################################################################



################################################################################################
# Create a PagerDuty users
resource "pagerduty_user" "sam" {
  name  = "Sam Blake"
  email = "sam.blake@pagerduty.demo"
  color = "dark-goldenrod"
  role = "team_responder"
}
resource "pagerduty_user" "bob" {
  name  = "Bob Smith"
  email = "Bob.Smith@pagerduty.demo"
  color = "chocolate"
  role = "limited_user"
}
resource "pagerduty_user" "dave" {
  name  = "Dave Bailey"
  email = "Dave.Bailey@pagerduty.demo"
  role = "user"
}
resource "pagerduty_user" "kate" {
  name  = "Kate Chapman"
  email = "Kate.Chapman@pagerduty.demo"
  role = "admin"
}
resource "pagerduty_user" "Derek" {
  name  = "DBA Derek"
  email = "DBA.Derek@pagerduty.demo"
}
resource "pagerduty_user" "Dora" {
  name  = "DBA Dora"
  email = "DBA.Dora@pagerduty.demo"
}
resource "pagerduty_user" "Nancy" {
  name  = "Network Nancy"
  email = "Network.Nancy@pagerduty.demo"
}
resource "pagerduty_user" "Norman" {
  name  = "Network Norman"
  email = "Network.Norman@pagerduty.demo"
}
resource "pagerduty_user" "Morris" {
  name  = "Management Morris"
  email = "Management.Morris@pagerduty.demo"
}

resource "pagerduty_user" "Martha" {
  name  = "Management Martha"
  email = "Management.Martha@pagerduty.demo"
}
################################################################################################



################################################################################################
# Assign the Users to the right Teams: -
resource "pagerduty_team_membership" "teamSam" {
  user_id = "${pagerduty_user.sam.id}"
  team_id = "${pagerduty_team.automation.id}"
}
resource "pagerduty_team_membership" "teamBob" {
  user_id = "${pagerduty_user.bob.id}"
  team_id = "${pagerduty_team.automation.id}"
}
resource "pagerduty_team_membership" "teamDave" {
  user_id = "${pagerduty_user.dave.id}"
  team_id = "${pagerduty_team.automation.id}"
}
resource "pagerduty_team_membership" "teamkate" {
  user_id = "${pagerduty_user.kate.id}"
  team_id = "${pagerduty_team.automation.id}"
}
resource "pagerduty_team_membership" "teamDerek" {
  user_id = "${pagerduty_user.Derek.id}"
  team_id = "${pagerduty_team.Operations.id}"
}
resource "pagerduty_team_membership" "teamDora" {
  user_id = "${pagerduty_user.Dora.id}"
  team_id = "${pagerduty_team.Operations.id}"
}
resource "pagerduty_team_membership" "teamNorman" {
  user_id = "${pagerduty_user.Norman.id}"
  team_id = "${pagerduty_team.Operations.id}"
}
resource "pagerduty_team_membership" "teamNancy" {
  user_id = "${pagerduty_user.Nancy.id}"
  team_id = "${pagerduty_team.Operations.id}"
}
resource "pagerduty_team_membership" "teamMorris" {
  user_id = "${pagerduty_user.Morris.id}"
  team_id = "${pagerduty_team.Stakeholders.id}"
}
resource "pagerduty_team_membership" "teamMartha" {
  user_id = "${pagerduty_user.Martha.id}"
  team_id = "${pagerduty_team.Stakeholders.id}"
}
################################################################################################



################################################################################################
# Create PagerDuty Schedules
resource "pagerduty_schedule" "automation_sch" {
  name      = "Automation On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-06T20:00:00-10:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.sam.id}",
                                    "${pagerduty_user.bob.id}",
                                    "${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankPayment" {
  name      = "Payment On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-06T20:00:00-10:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.bob.id}",
                                    "${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankApply" {
  name      = "Apply On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-06T20:00:00-10:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankTransfer" {
  name      = "Transfer On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-06T20:00:00-10:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
################################################################################################



################################################################################################
# Create PagerDuty EP's
resource "pagerduty_escalation_policy" "EngineeringEP" {
  name      = "eCommerce Engineering (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.automation.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.automation_sch.id}"
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Payment" {
  name      = "Payment Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.bankPayment.id}"
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Balance" {
  name      = "Balance Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.automation_sch.id}"
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Transfer" {
  name      = "Transfer Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.bankTransfer.id}"
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Apply" {
  name      = "Apply Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule"
      id   = "${pagerduty_schedule.bankApply.id}"
    }
  }
}
################################################################################################



################################################################################################
# Create PagerDuty Services - eCommerce
resource "pagerduty_service" "eCommerce_FrontEnd" {
  name                    = "eCommerce FrontEnd"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.EngineeringEP.id}"
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "eCommerce_Search" {
  name                    = "eCommerce Search"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.EngineeringEP.id}"
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "eCommerce_Payment" {
  name                    = "eCommerce Payment"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.EngineeringEP.id}"
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }

}
################################################################################################



################################################################################################
# Create PagerDuty Services - Banking
resource "pagerduty_service" "Bank-Payment" {
  name                    = "DutyBank Payment"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.Bank-Payment.id}"
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }  

}
resource "pagerduty_service" "Bank-Apply" {
  name                    = "DutyBank Apply"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.Bank-Apply.id}"
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }  
}
resource "pagerduty_service" "Bank-Balance" {
  name                    = "DutyBank Balance"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.Bank-Balance.id}"
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "Bank-Transfer" {
  name                    = "DutyBank Transfer"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = "${pagerduty_escalation_policy.Bank-Transfer.id}"
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "intelligent"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }

}
################################################################################################
