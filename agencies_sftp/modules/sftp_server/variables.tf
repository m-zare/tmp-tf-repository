variable "bucket" {
  type        = string
  description = "Bucket name"
}

variable "forceDestroy" {
  type        = bool
  default     = false
  description = "Force non-empty bucket destroy"
}