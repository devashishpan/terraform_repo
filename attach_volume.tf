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
