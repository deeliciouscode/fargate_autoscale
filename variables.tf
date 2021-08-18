########### FARGATE ###########

variable "name_ecs_cluster" {}

variable "capacity_providers" {
    default = ["FARGATE", "FARGATE_SPOT"]
}

variable "tags" {}

variable "ecs_task_family" {}

variable "port_mapping_host_port" {
    default = 80
}

variable "port_mapping_protocol" {
    default = "tcp"
}

variable "port_mapping_container_port" {
    default = 80
}

variable "cpu_units" {
    default = 256
}

variable "author_name" {}

variable "memory_mb" {
    default = 512
}

variable "docker_image_uri" {}

variable "essential" {
    default = true
}

variable "name" {}

variable "network_mode" {
    default = "awsvpc"
}

variable "ecs_role_arn" {}

variable "name_ecs_service" {}

variable "platform_version" {
    default = "LATEST"
}

variable "ecs_subnet_ids" {}

variable "ecs_sg_ids" {}

variable "assign_public_ip" {
    default = false
}

variable "lb_ecs_target_group_arn" {}

variable "lb_container_name" {}

variable "lb_container_port" {}

########### AUTOSCALING ###########

variable "autoscaling_max_capa" {
    default = 10
}

variable "autoscaling_min_capa" {
    default = 1
}

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