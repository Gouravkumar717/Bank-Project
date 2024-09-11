resource "aws_instance" "test-server" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  key_name               = "myedkey"
  #vpc_security_group_ids = ["sg-0d38fda416689c02b"]
  #subnet_id              = "0878d772e5548846a"  # Specify the correct subnet here

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("myedkey.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance'"]
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
