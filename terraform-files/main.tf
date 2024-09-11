resource "aws_instance" "test-server" {
  ami                    = "ami-0182f373e66f89c85"
  instance_type          = "t2.micro"
  key_name               = "myedkey"
  vpc_security_group_ids = ["sg-0ce13666ac0d4df60"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./myedkey.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'wait to start the instance'"
    ]
  }

  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Bank-Project/terraform-files/ansibleplaybook.yml"
  }
}
