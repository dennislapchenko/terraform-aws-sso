variable "permission_sets" {
  description = "Map of maps containing Permission Set names as keys. See permission_sets description in README for information about map values."
  type        = any
  default = {
    AdministratorAccess = {
      description      = "Provides full access to AWS services and resources.",
      session_duration = "PT2H",
      managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    ViewOnlyAccess = {
      description      = "View resources and basic metadata across all AWS services. Additionaly allow SSM get parameter",
      session_duration = "PT12H",
      managed_policies = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
      inline_policy: {
        sid =  "SSMGetParameterAccess"
        actions =  ["ssm:GetParameter*"]
        resources = ["*"]
      }
    }
  }
}

variable "account_assignments" {
  description = "List of maps containing mapping between user/group, permission set and assigned accounts list. See account_assignments description in README for more information about map values."
  type = list(object({
    principal_name = string,
    principal_type = string,
    permission_set = string,
    account_ids    = list(string)
  }))

  default = []
}
