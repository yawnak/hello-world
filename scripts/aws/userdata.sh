#!/bin/bash
# Update the system and install Docker
sudo yum update -y
sudo yum install docker -y
sudo service docker start

# Pull the Docker image
sudo docker pull yawnak/hello-world:v1.0.0

# Run the Docker container and map port 3000 on the host to port 80 in the container
sudo docker run -d -p 3000:3000 yawnak/hello-world:v1.0.0