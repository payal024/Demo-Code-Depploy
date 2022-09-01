locals {
  common_tags = {
    Product          = "${var.product}"
    Project          = "${var.project}"
    EmergencyContact = "${var.emergency-contact}"
    Owner            = "${var.owner}"
    Environment      = "${var.environment}"
    LastUpdate       = "${timestamp()}"
    GitHash          = "${var.git-hash}"
  }
}
locals {
  common_tags_asg = []
}