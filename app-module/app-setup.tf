resource "null_resource" "app-deploy" {
    count= length(local.PRIVATE_IPS)
    triggers = {
        //private_IP = element(local.PRIVATE_IPS, count.index)
        abc = timestamp()
    }
    provisioner "remote-exec" {
        connection {
            host= element(local.PRIVATE_IPS,count.index)
            user= local.ssh_user
            password = local.ssh_pass
        }

        inline = [ 
            "ansible-pull -U https://github.com/MunishLagoo/test-ansible.git roboshop-pull.yml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT} -e NEXUS_USER=${var.NEXUS_USER} -e NEXUS_PASS=${var.NEXUS_PASS} -e APP_VERSION=${var.APP_VERSION}"
            ]
       
    }

}