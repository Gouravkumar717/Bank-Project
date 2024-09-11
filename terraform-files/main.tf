resource "aws_instance" "test-server" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name      = "myedkey"
  vpc_security_group_ids = ["sg-09361e08bf2cb972b"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./myedkey.pem")  # Corrected private key path
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
  }

  tags = {
    Name = "test-server"  # Corrected tag name spelling
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Bank-Project/terraform-files/ansibleplaybook.yml"
  }
}
