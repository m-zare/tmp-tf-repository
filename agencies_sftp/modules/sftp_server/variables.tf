variable "bucket" {
  type = string
  description = "Bucket name"
}

variable "force_destroy" {
  type = bool
  default = false
  description = "Force non-empty bucket destroy"
}