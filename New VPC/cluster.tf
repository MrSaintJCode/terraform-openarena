resource "aws_ecs_cluster" "openarena_cluster" {
    name  = "${terraform.workspace}-cluster"
}

resource "aws_ecs_task_definition" "openarena_task_def" {
    network_mode              = "awsvpc"
    requires_compatibilities  = ["FARGATE"]
    cpu                       = 512    
    memory                    = 1024
    family                    = "openarena"
    container_definitions     = file("task_definitions/openarena.json")
}

resource "aws_ecs_service" "openarena_game" {
 name                               = "${terraform.workspace}-openarena"
 cluster                            = aws_ecs_cluster.openarena_cluster.id
 task_definition                    = aws_ecs_task_definition.openarena_task_def.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.openarena_sg.id]
   subnets          = [aws_subnet.workspace_private_subnet_1a.id,
                       aws_subnet.workspace_private_subnet_1b.id
                    ]
   assign_public_ip = false
 }

  load_balancer {
    target_group_arn  = aws_alb_target_group.openarena_tg.arn
    container_name    = aws_ecs_task_definition.openarena_task_def.family
    container_port    = 27960
  }
  depends_on = [aws_alb_listener.openarena_listener]

}
