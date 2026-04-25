# Week 1 – SSH Setup & Server Access

## 🎯 Objective
To understand SSH, secure server access, and basic Linux user management.

---

## Tools & Technologies
- Linux (Ubuntu)
- AWS EC2
- SSH
- Networking Basics

## Hands-on Labs

### Lab 1: SSH Setup & Server Access
- Generated SSH key pair
- Connected to EC2 instance
- Disabled password authentication

### Lab 2: User Management
- Created new user
- Assigned sudo privileges

## Incident Simulation

### Issue: SSH Connection Failure

### Possible Causes:
- Incorrect key permissions
- Port blocked in security group
- Wrong SSH user

### Troubleshooting Steps:
1. Checked security group rules
2. Fixed key permission using chmod 400
3. Verified correct username

### Resolution:
Successfully connected after fixing permissions and port access

### Key Learning:
SSH issues are often related to permissions and network access



## 🛠️ Tasks Performed
- Generated SSH key pair
- Connected to AWS EC2 instance
- Created a new user
- Assigned sudo privileges
- Disabled password authentication

---

## 💻 Commands Used
```bash
ssh-keygen
ssh -i key.pem ubuntu@<ip>
sudo adduser devopsuser
sudo usermod -aG sudo devopsuser
chmod 400 key.pem
