
# run the command below to specify the path for configuration of the t
# erraform state in S3 bucket with the DynamoDb table as the backend and encryption, locking enabled
# terraform init -backend-config=backend.hcl

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-state-bucket-for-tutorial"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.nano"
  min_size               = 2
  max_size               = 2
}

# setting autoscaling schedule to scale out, scale in based on specific 
# times and make use of the asg name specified in the modules as we are
# passing it from the outputs of the modules to the main.tf file in the 
# staging environment but should be defined in the main.tf file in the
# modules folder but it only applied to the staging environment.
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

# Extra security group rule added as can be configured using the 
# seperate rosources option instead of the inline block option for 
# modules in the main.tf file, then accessed as we are getting the 
# security group id from the outputs of the modules in the main.tf
resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
