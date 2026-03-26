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

- Going to use ed25519 instead of previously used rsa keys
- ssh-keygen -t ed25519 -C "your_email@example.com" 
    - -C is just a label
- Stored in GH Secrets as per prereq

- Going to implement some things I have not before i nthese projects, such as running validations beforehand (vs the YOLO approach), and verify. 

- Splitting up Ansible into much smaller chunks. Previously would have roles seperates but with one .yml file per role. With this approach, I will utilize the following: 
    - `tasks/` Logic / What to Do
    - `defaults/` Config / Configurable Values
    - `handlers/` Handlers / Conditional Reactions
    - `templates/` Output Rendering / Dynamic File Generation

## Lessons Learned

- One main issue was the ssh access check would time out once everything was working. Why? Because it used 'root' to check when 'root's ssh access gets removed later in the ansible playbook. This would also affect future changes to an existing system. Therefore implemented a `detect ssh user` step' that tries root first (for initial setup for 60sec) then reverts to the new user setup if that fails. however, fail2ban was still kicking in. Since this was really just in to prevent bootstrapping from failing, I added a wait function in ansible.

- The only thing with this now (i.e. good enough for this project) is it does try one as root while running the playbook, which means on subsequent runs it will show an ERROR, however it then switches to the user and continues with that. Ansible counts it as unreachable instead of failed.

## GitHub Actions Flow

This repository uses a simple GitHub Actions pipeline to provision and configure the server in ordered stages:

- `build`: runs lightweight checks before any infrastructure changes. This includes Terraform format and validate checks plus an Ansible syntax check.
- `deploy`: runs Terraform to create or update the DigitalOcean droplet and captures the droplet IP as a workflow output.
- `config`: waits for SSH to become available, builds a temporary Ansible inventory from the Terraform output, and applies the Ansible playbook to configure the server.
- `verify`: reconnects to the configured server as the non-root admin user and runs a lightweight verification playbook to confirm SSH, UFW, unattended upgrades, Fail2Ban, and log inspection checks.

At a high level, Terraform is responsible for provisioning the droplet and Ansible is responsible for configuring and validating the operating system after the server is reachable.
