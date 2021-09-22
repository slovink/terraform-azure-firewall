locals {
    resourceTags = {
        controller = var.environment_controller
        owner = var.environment_owner
        costcenter = var.environment_costcenter
    }
}