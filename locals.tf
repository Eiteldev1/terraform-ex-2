locals {

 common_tags ={
    Env = var.env
    Team = var.team
 }

 inbound_rules = [22,80]

}