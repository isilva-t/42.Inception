# Inception

A Docker containerized WordPress infrastructure with NGINX, MariaDB, and additional services.

This project implements a complete web infrastructure using Docker containers, with each service running in its own dedicated container according to best practices. It's designed as an educational project to demonstrate containerization concepts and multi-service orchestration.

## Infrastructure Overview

![Infrastructure Diagram](https://via.placeholder.com/800x400?text=Docker+Infrastructure+Diagram)

The infrastructure consists of the following components:

### Core Services
- **NGINX**: Web server with TLS/SSL, the only entry point to your infrastructure
- **WordPress + PHP-FPM**: Content management system
- **MariaDB**: Database server

### Bonus Services
- **Redis**: Cache for WordPress to improve performance
- **FTP Server**: For file uploads to WordPress directory
- **Adminer**: Database management interface
- **Portainer**: Docker container management UI

## Requirements

- Docker Engine 20.10.x+
- Docker Compose 1.25.x+
- Make

## Getting Started

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/inception.git
cd inception
```

2. Run the setup:
```bash
make
```

This will:
- Create necessary data directories
- Extract configuration secrets
- Build Docker images
- Set up the Docker network

3. Start the services:
```bash
make up       # Start in detached mode
# OR
make uplog    # Start with logs in foreground
```

4. Access your services:
   - WordPress: https://localhost
   - Adminer: https://localhost/adminer/
   - Portainer: https://localhost/portainer/

### Login Information

#### WordPress
- Admin Username: boss
- Admin Password: bosswordpress
- Admin Email: boss@isilva-t.42.fr

#### Database
- Username: sqluser
- Password: userpass
- Root Password: rootpass

#### FTP
- Username: boss
- Password: bossftp

#### Portainer
- Password: bossportainer

## Make Commands

| Command | Description |
|---------|-------------|
| `make` | Setup the infrastructure (build images) |
| `make up` | Start containers in detached mode |
| `make uplog` | Start containers with logs in foreground |
| `make down` | Stop and remove containers |
| `make clean` | Same as `make down` |
| `make fcleanimsure` | Full cleanup (containers, images, volumes, networks) |
| `make adminer` | Open shell in adminer container |
| `make mariadb` | Open shell in mariadb container |
| `make redis` | Open Redis CLI |

## Project Structure

```
.
├── Makefile               # Build automation
├── secrets/               # Contains password files
├── srcs/
│   ├── .env               # Environment variables
│   ├── docker-compose.yml # Container orchestration
│   └── requirements/
│       ├── nginx/         # NGINX configuration
│       ├── wordpress/     # WordPress configuration
│       ├── mariadb/       # MariaDB configuration
│       └── bonus/
│           ├── redis/     # Redis cache
│           ├── ftp/       # FTP server
│           ├── adminer/   # Database interface
│           └── portainer/ # Container management
```

## Technical Details

### Networking

All services communicate through a Docker network bridge named `myNet`. NGINX is the only container exposed to the host, via port 443 (HTTPS). The FTP server also exposes ports 20, 21, and 30000-30100 for passive mode connections.

### Volumes

The project uses several Docker volumes to persist data:
- WordPress files: `/home/username/data/wordpress`
- MariaDB database: `/home/username/data/mariadb`
- Portainer data: `/home/username/data/portainer`
- Redis data: `/home/username/data/redis`

### Security

- TLS/SSL with self-signed certificates for HTTPS
- Docker secrets for sensitive information
- No passwords stored in Dockerfiles
- Environment variables for configuration

## Troubleshooting

### Cannot connect to services

- Verify all containers are running: `docker ps`
- Check container logs: `docker logs <container_name>`
- Ensure ports are not in use by other applications

### WordPress setup issues

- If WordPress doesn't initialize properly, you may need to check the database connection
- Verify MariaDB is running: `make mariadb` then run `mysql -u sqluser -p`

### SSL Certificate Warnings

Since the project uses self-signed certificates, browsers will show security warnings. This is expected and can be bypassed for testing purposes.

## License

This project is created for educational purposes and is not meant for production use.

## Acknowledgments

This project was developed as part of the 42 School curriculum.
