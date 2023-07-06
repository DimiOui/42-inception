# Inception

This project aims to broaden your knowledge of system administration by utilizing Docker to set up a small infrastructure composed of different services. The project must be completed on a Virtual Machine (VM) using Docker Compose. The objective is to create and manage multiple Docker containers with specific rules and configurations.

The project requires the following services:
- NGINX container with TLSv1.2 or TLSv1.3 only
- WordPress + php-fpm container (without NGINX)
- MariaDB container (without NGINX)
- Volumes for WordPress database and website files
- Docker network to establish connections between containers
- The containers should restart automatically in case of a crash. It is important to note that using `network: host`, `--link`, or `links`: is not allowed.

With the requirements in mind, the project has additional features including:
- Creating Docker images using Alpine as the base image for each service
- Writing custom Dockerfiles, one per service, which will be called in the docker-compose.yml file via the Makefile
- Setting up two users in the WordPress database, with one of them being the administrator
- Configuring the domain name login.42.fr to point to the local IP address
- Using environment variables and a .env file to store and manage configuration settings
- Using NGINX container as the only entry point into the infrastructure via port 443, supporting TLSv1.2 or TLSv1.3 protocols
- Implementing a simple chatbot with Python and a static website
- Including an FTP server container pointing to the volume of the WordPress website

## Getting Started
To get started with this project, follow the steps below:

### Prerequisites
- Virtual Machine (VM) environment
- Docker installed on the VM

### Installation
1. Clone this repository to your local machine or VM:
```fish
git clone https://github.com/DimiOui/Inception.git
```

2. Navigate to the project directory
```fish
cd <project_directory>
```

3. Build the Docker containers and set up the entire application using the Makefile:
```fish
make all
```

### Configuration
The project includes a .env file located at the root of the srcs directory. This file contains environment variables used for configuration. You can modify these variables as needed.

### Usage
Once the project is set up and running, you can access the various services through the following URLs:

- NGINX: https://login.42.fr
- WordPress: https://login.42.fr/wordpress
- Chatbot: http://localhost:9500
- FTP Server: ftp://localhost:21
