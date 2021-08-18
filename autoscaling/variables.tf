variable "autoscaling_max_capa" {
    default = 10
}

variable "autoscaling_min_capa" {
    default = 1
}

variable "ecs_cluster" {}

variable "ecs_service" {}

variable "service_namespace" {
    default = "ecs"
}

variable "memory_scaling_name" {}

variable "memory_scaling_policy_type" {
    default = "TargetTrackingScaling"
}

variable "memory_target_value" {
    default = 80
}

variable "cpu_scaling_name" {}

variable "cpu_scaling_policy_type" {
    default = "TargetTrackingScaling"
}

variable "cpu_target_value" {
    default = 80
}