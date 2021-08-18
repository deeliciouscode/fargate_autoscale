resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity = var.autoscaling_max_capa
  min_capacity = var.autoscaling_min_capa
  resource_id = "service/${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = var.service_namespace
}

resource "aws_appautoscaling_policy" "memory_scaling" {
  name               = var.memory_scaling_name
  policy_type        = var.memory_scaling_policy_type
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_target_value
  }
}

resource "aws_appautoscaling_policy" "cpu_scaling" {
  name = var.cpu_scaling_name
  policy_type         = var.cpu_scaling_policy_type
  resource_id         = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension  = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace   = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value      = var.cpu_target_value
  }
}