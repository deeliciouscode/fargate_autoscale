output "ecs_cluster" {
  value = aws_ecs_cluster.ecs_cluster
}

output "ecs_service" {
  value = aws_ecs_service.ecs_service
}

output "ecs_cluster_arn" {
  value = aws_ecs_service.ecs_cluster.arn
}