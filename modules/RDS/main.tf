resource "aws_db_subnet_group" "db_subnet_group" {
    name = var.db_subnet_group_name
    subnet_ids = var.pvt_db_subnets
}

resource "aws_db_instance" "rds" {
    identifier = var.rds_identifier
    allocated_storage = var.rds_allocated_storage
    engine = var.rds_engine
    engine_version = var.rds_engine_version
    instance_class = var.rds_instance_class
# Defines the size and power of the RDS database instance, like cpu & RAM (memory)
    publicly_accessible = var.rds_publicly_accessible
    username = var.username
    password = var.password
    db_name = var.db_name
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [var.rds_sg]
    skip_final_snapshot = var.rds_skip_final_snapshot
# Controls whether AWS takes a final backup before deleting the RDS instance.
    multi_az = var.rds_multi_az
# Enables high availability by creating a standby database in another Availability Zone.
    storage_type = var.rds_storage_type
}
# Storage type defines the kind of disk used by the RDS database and its performance.
