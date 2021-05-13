resource "aws_instance" "web_server"{
	ami = "ami-010aff33ed5991201"
	instance_type = "t2.micro"
	security_group = ["web_server"]
	key_name = "ssh-key-name"
	tags = {
		Name = "Webserver"
	}
}
