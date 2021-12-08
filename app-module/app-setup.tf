resource "null_resource" "app-deploy" {
    count= length(local.PRIVATE_IPS)
    provisioner "remote-exec" {
        connection {
            host= element(local.PRIVATE_IPS,count.index)
            user= local.ssh_user
            password = local.ssh_pass
        }
        inline = [
            "ansible-pull -U https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps60/_git/ansible roboshop-pull.yml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT}"
        ]
    }

}