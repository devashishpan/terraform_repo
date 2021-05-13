provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "web_server"{
  ami = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  security_group = ["web_server"]
  key_name = "ssh-key-name"
  tags = {
    Name = "Webserver"
  }
}

resource "null_resource" "config_webserver" {
  connection {
    type = "ssh"
    user = "root"
    private_key = file("/path/to/key-file")
    host = aws_instance.web_server.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}

resource "aws_ebs_volume" "web _server_hhd"{
  avaibility_zone = aws_instance.web_server.avaibility_zone
  size = 10
  tags = {
    Name = "webserver_volume"
  }
}

resource "aws_volume_attachment" "web_server_hhd_att" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.web_server_hhd.id
  instance_id = aws_instance.web_server.id
}

resource "null_resource" "web_server_mount" {
  provisioner "remote-exec"{
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo mount /dev/xvdc /var/www",
      "sudo yum install git -y",
      "sudo git clone <url_of git_repo_contianing_http_source> /var/www/html"
    ]
  }
  provisioner "local-exec"{
    command = "chrome <url>"
}
}

