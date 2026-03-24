# Linux Server Setup

This is based off the DevOps Roadmap Project [Linux Server Setup](https://roadmap.sh/projects/linux-server-setup)

Learn to set up and secure a Linux server from scratch.

This is an intermediate [DevOps Project](https://roadmap.sh/devops/projects) as per roadmap.sh

## Description From Site 

The goal of this project is to take a fresh Linux server (e.g., a newly provisioned VPS from DigitalOcean, Linode, AWS, or any cloud provider) and configure it with essential security measures and settings that every production server should have. By the end, you will have a hardened server ready for deploying applications.

## Requirements

Requirements

You are required to perform the following tasks on a fresh Ubuntu server:

- User Setup: Create a non-root user with sudo privileges. This user should be used for all future server administration instead of root.

- SSH Configuration: Generate an SSH key pair on your local machine, add the public key to your server, and configure the server to disable password-based authentication.

- Firewall Configuration: Set up UFW (Uncomplicated Firewall) to allow only SSH (port 22) by default. You should understand how to add additional rules when needed.

- System Updates: Update all system packages and configure automatic security updates using unattended-upgrades.

- Basic Hardening: Install and configure Fail2Ban to protect against brute-force SSH attacks.

- Server Configuration: Set the correct timezone and a meaningful hostname for your server.

- Service Management: Demonstrate basic systemctl commands to check the status of services, start/stop them, and enable them at boot.

- Log Inspection: Use journalctl to view system logs and locate common log files in /var/log/.

- Verification: Complete a security checklist confirming all configurations are in place and working correctly.

### Learning Outcomes

After completing this project, you will have learned how to secure a Linux server from common attack vectors, manage users and permissions, configure SSH for key-based authentication, set up a firewall, and maintain your server with automatic updates. These are foundational skills for any developer working with cloud infrastructure, deploying applications, or managing their own servers.


### Stretch Goals


- (blank)

## prerequisites

- Setup the following repository secrets:
    - DO_TOKEN : Digital Ocean access token
    - DO_SPACES_SECRET_KEY : Digital Ocean spaces secret key (for Terraform state file)
    - DO_SPACES_ACCESS_KEY : Digital Ocean spaces access key (for Terraform state file)
    - DO_SSH_PUBLIC_KEY_PRIVATE : Keypair to be used for Private VM 
    - DO_SSH_PRIVATE_KEY_PRIVATE : Keypair to be used for Private VM

## To Run  

- Create an SSH key locally.
- Make sure prerequisites are satisfied 


## Notes 

- (blank)

## Lessons Learned

- (blank)