# Automation Project Documentation

This project consists of several GitHub repositories aimed at automating infrastructure provisioning, configuration management, and deployment using Terraform, Ansible, Docker, and Flask.

## Repositories:

1. [automation-terraform](https://github.com/ashrafelshazly/automation-terraform): Contains Terraform files for provisioning infrastructure.

2. [automation-ansible](https://github.com/ashrafelshazly/automation-ansible): Includes Ansible playbooks for configuration management.

3. [automation-docker-role](https://github.com/ashrafelshazly/automation-docker-role): Houses Ansible roles for Docker installation and management.

4. [automation-flask-app](https://github.com/ashrafelshazly/automation-flask-app): Contains files for a Flask application to be deployed.

## Project Workflow:

### 1. Infrastructure Provisioning:

Clone the `automation-terraform` repository and use the Terraform files to provision infrastructure. This will create three EC2 instances: a management server, server1, and server2.

### 2. Configuration Management:

SSH into the management server and add the necessary SSH key for communication with other servers.

### 3. Ansible Setup:

Clone the `automation-ansible` repository and install required Ansible roles using the command:

```bash
ansible-galaxy install -r roles/requirements.yml -p roles
```

### 4. Docker Deployment:

Run the Docker playbook (`docker-playbook.yml`) included in the `automation-ansible` repository. This playbook will:

```bash
ansible-playbook docker-playbook.yml -i invetories/hosts
```

1. Install Docker on the servers.
2. Pull the Flask application repository.
3. Build and run the Docker image using the provided Dockerfile and application files.

### 5. Accessing the Application:

Once the deployment is complete, the Flask application will be accessible via the IP address or DNS of the deployed servers. Navigate to the provided address in your web browser to access the application.

### Additional Notes:

1. Ensure proper configuration of security groups and network settings to allow communication between the servers.
2. Customize variables and configurations according to your specific requirements before running the automation scripts.
3. For troubleshooting and additional information, refer to individual repositories and their respective documentation.

## Contributors

- [Ashraf Elshazly](https://github.com/ashrafelshazly)
