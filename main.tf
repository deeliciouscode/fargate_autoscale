resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name_ecs_cluster
  capacity_providers = var.capacity_providers
  
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = var.ecs_task_family
  container_definitions = jsonencode([
      {
          "portMappings" = [
              {
                "hostPort" = var.port_mapping_host_port,
                "protocol" = var.port_mapping_protocol,
                "containerPort" = var.port_mapping_container_port,
              },
          ],
          "cpu" = var.cpu_units,
          "environment" = [
              {
                "name" = "AUTHOR",
                "value" = var.author_name,
              },
              {
                "name" = "DB_HOST_PROD",
                "value" = var.db_host_url
              }
          ],
          "memory" = var.memory_mb,
          "image" = var.docker_image_uri,
          "essential" = var.essential,
          "name" = var.ecs_task_name,
      },
  ])

  network_mode = var.network_mode
  requires_compatibilities = [
    "FARGATE"]
  memory = "1024"
  cpu = "512"
  execution_role_arn = aws_iam_role.ecs_service.arn
  task_role_arn = aws_iam_role.ecs_service.arn

  tags = var.tags
}

resource "aws_ecs_service" "ecs_service" {
  name = var.name_ecs_service
  cluster = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = var.platform_version

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    subnets = var.ecs_subnet_ids
    security_groups = var.ecs_sg_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.lb_ecs_target_group_arn
    container_name = var.lb_container_name
    container_port = var.lb_container_port
  }
}

module "auto_scaling" {
  source = "./autoscaling"
  autoscaling_max_capa = var.autoscaling_max_capa
  autoscaling_min_capa = var.autoscaling_min_capa
  ecs_cluster = aws_ecs_cluster.ecs_cluster
  ecs_service = aws_ecs_service.ecs_service
  service_namespace = var.service_namespace
  memory_scaling_name = var.memory_scaling_name
  memory_scaling_policy_type = var.memory_scaling_policy_type
  memory_target_value = var.memory_target_value
  cpu_scaling_name = var.cpu_scaling_name
  cpu_scaling_policy_type = var.cpu_scaling_policy_type
  cpu_target_value = var.cpu_target_value
}