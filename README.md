# Samba Server Docker Project

This project sets up a Samba server using Docker and Docker Compose. The Samba server is configured to share a directory (`/mount`) and allows user authentication based on the environment variables defined in a `.env` file.

## Project Structure

    .
    ├── config
    │   └── smb.conf
    ├── mount
    ├── create_users.sh
    ├── Dockerfile
    ├── docker-compose.yml
    ├── .env
    ├── .gitignore
    ├── README.md
    └── LICENSE

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/samba-server-docker.git
   cd ops-samba
   ```

2. **Create the .env file:**

   ```bash
   echo > .env
   ```

Add user credentials in the .env file:

    ```bash
    USER1=foo
    PASSWORD1=pass1
    USER2=too
    PASSWORD2=pass2
    # Add more users as needed
    ```
