
resource "aws_ebs_volume" "web _server_hhd"{
  avaibility_zone = aws_instance.web_server.avaibility_zone
  size = 10
  tags = {
    Name = "webserver_volume"
  }
}
