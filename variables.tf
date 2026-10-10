variable "kendra_faqs" {
  description = <<EOT
Map of kendra_faqs, attributes below
Required:
    - index_id
    - name
    - role_arn
    - s3_path (block):
        - bucket (required)
        - key (required)
Optional:
    - description
    - file_format
    - language_code
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    index_id      = string
    name          = string
    role_arn      = string
    description   = optional(string)
    file_format   = optional(string)
    language_code = optional(string)
    region        = optional(string)
    tags          = optional(map(string))
    tags_all      = optional(map(string))
    s3_path = object({
      bucket = string
      key    = string
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.kendra_faqs : (
        can(regex("[0-9A-Za-z][0-9A-Za-z-]{35}", v.index_id))
      )
    ])
    error_message = "Starts with an alphanumeric character. Subsequently, can contain alphanumeric characters and hyphens. Fixed length of 36."
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

