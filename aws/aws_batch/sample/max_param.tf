## provide unique name for compute environment and queue
module "batch_creation" {
    source               = "./code"
    location             = "eu-west-2"
    vpc_id               = "vpc-09a8c77ae21f28516"
    subnet_id            = ["subnet-073f346b28ccddaf6"]
    env_name             = "sample-env-for-batch"
    max_vcpu             = 2
    min_vcpu             = 1
    desired_vcpu         = 1
    resource_type        = "EC2"
    env_type             = "MANAGED"
    queue_name           = "sample-queue"
    queue_state          = "ENABLED"
    queue_priority       = 1
    job_definition_name  = "sample-job-definition"
    job_type             = "container"
    container_properties   = file("./code/data/job_definition.json")
    retry_strategy = {
        attempts = 3
        evaluate_on_exit = {
          retry_error = {
            action       = "RETRY"
            on_exit_code = 1
          }
          exit_success = {
            action       = "EXIT"
            on_exit_code = 0
          }
        }
      }
    
}

