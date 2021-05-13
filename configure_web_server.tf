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
