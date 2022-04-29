locals {
  name     = "LaunchTemplate_assign"
  userdata = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  sudo bash -c 'echo @@@@@@@@Webserver is up!!!@@@@@@@@ > /var/www/html/index.html'
  sudo systemctl start apache2
  
  EOF
}