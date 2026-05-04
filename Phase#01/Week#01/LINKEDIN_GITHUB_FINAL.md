# Week 1: SSH & Linux Fundamentals

**Status:** ✅ Complete  
**Duration:** 6 hours  
**Portfolio Piece:** Comprehensive learning + incident handling  

---

## 📚 What I Learned This Week

### Concepts Covered

1. **DevOps Fundamentals**
   - DevOps = Development + Operations collaboration
   - Why speed + reliability matters
   - DevOps skills triangle: Linux/Cloud + Automation + Culture

2. **SDLC (Software Development Lifecycle)**
   - 7 phases: Planning → Analysis → Design → Development → Testing → Deployment → Maintenance
   - Where DevOps fits in the process
   - Role in each phase

3. **Environments: DEV, SIT, UAT, PROD**
   - DEV: Local development, anything breaks = ok
   - SIT: System Integration Testing, multiple components together
   - UAT: User Acceptance Testing, client approval
   - PROD: Live users, real money, zero tolerance for errors
   - Why isolation between environments matters

4. **SSH Authentication**
   - Password-based = insecure (brute-forceable)
   - SSH Keys = mathematically secure
   - Public key (on server) + Private key (you keep) = authentication
   - Why permissions matter (600 for keys, 700 for directories)

5. **Server Security Best Practices**
   - Principle of least privilege (only needed permissions)
   - Users management (no root for daily work)
   - SSH key rotation (quarterly)
   - Monitoring and logging
   - Regular backups

---

## 🛠️ Labs Completed

### Lab 1: SSH Keys & Remote Access

**What I Did:**
1. Generated SSH key pair (RSA-4096)
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/devops_demo -N ""
   ```

2. Verified permissions (must be 600 for private, 644 for public)
   ```bash
   ls -la ~/.ssh/devops_demo*
   # -rw------- (600) devops_demo
   # -rw-r--r-- (644) devops_demo.pub
   ```

3. Copied public key to server
   ```bash
   ssh-copy-id -i ~/.ssh/devops_demo.pub azureuser@13.88.192.45
   ```

4. Connected without password
   ```bash
   ssh -i ~/.ssh/devops_demo azureuser@13.88.192.45
   ```

5. Created ~/.ssh/config for convenience
   ```
   Host devops-demo
       HostName 13.88.192.45
       User azureuser
       IdentityFile ~/.ssh/devops_demo
       Port 22
   ```

**Result:** ✅ Secure SSH access without passwords

---

### Lab 2: User Management & Sudo Setup

**What I Did:**
1. Created new user
   ```bash
   sudo useradd -m -s /bin/bash devops-user
   ```

2. Generated SSH key for the user
   ```bash
   sudo -u devops-user ssh-keygen -t rsa -b 4096 -f /home/devops-user/.ssh/id_rsa -N ""
   ```

3. Set up authorized_keys
   ```bash
   sudo -u devops-user cat /home/devops-user/.ssh/id_rsa.pub >> /home/devops-user/.ssh/authorized_keys
   sudo -u devops-user chmod 600 /home/devops-user/.ssh/authorized_keys
   sudo -u devops-user chmod 700 /home/devops-user/.ssh
   ```

4. Added to sudo group
   ```bash
   sudo usermod -aG sudo devops-user
   ```

5. Verified setup
   ```bash
   id devops-user
   # uid=1001(devops-user) gid=1001(devops-user) groups=1001(devops-user),27(sudo)
   ```

**Result:** ✅ New user with SSH + sudo access, proper permissions

---

## 🚨 Incidents Debugged & Documented

### Incident 1: SSH Connection Timeout (Port 22)

**Problem:**
```bash
ssh azureuser@13.88.192.45
ssh: connect to host 13.88.192.45 port 22: Connection timed out
```

**Root Cause:**
SSH daemon port was changed from 22 to 2222 without team notification.
Change was made for security hardening but not communicated.

**Troubleshooting Approach:**
1. Enabled verbose output: `ssh -vvv user@host`
2. Checked firewall: `sudo ufw status`
3. Found port 2222 was open, 22 was blocked
4. Checked sshd_config: `sudo grep "^Port" /etc/ssh/sshd_config`
5. Found: `Port 2222`

**Solution:**
- Updated SSH config to use Port 2222
- Notified team of port change
- Updated documentation

**Key Learning:**
Infrastructure changes need communication. A 2-minute notification saves hours of debugging.

**Prevention:**
- Implement change management process
- 24-hour notification before infrastructure changes
- Update team wiki/docs
- Test with team before deploying

---

### Incident 2: Permission Denied (Wrong File Permissions)

**Problem:**
```bash
ssh -i ~/.ssh/mykey azureuser@server
Permission denied (publickey).
```

**Root Cause:**
Private key file had 666 permissions (world-readable).
SSH security feature: "If private key is readable by others, it could be compromised. Refuse to use it."

**Why It Happened:**
Key was transferred via file sharing/email → lost correct permissions.

**Troubleshooting Approach:**
1. Checked key file permissions: `ls -la ~/.ssh/mykey`
2. Found: `-rw-rw-rw- (666)` - WRONG!
3. SSH refuses to use world-readable private keys

**Solution:**
```bash
chmod 600 ~/.ssh/mykey
chmod 700 ~/.ssh
```

**Key Learning:**
SSH permissions aren't just "nice to have" - they're enforced security. This is actually a GOOD thing.

**Prevention:**
- SSH-keygen already sets correct permissions (600)
- Always verify after copying keys
- Add to .bashrc: `chmod 600 ~/.ssh/* && chmod 700 ~/.ssh`

---

### Incident 3: Key Mismatch (Wrong User)

**Problem:**
```bash
ssh -i ~/.ssh/id_rsa azureuser@server
Permission denied (publickey).
```

**Root Cause:**
SSH key was generated for devops-user but developer tried to use as azureuser.
Public key not in /home/azureuser/.ssh/authorized_keys

**SSH Authentication Flow:**
1. Developer sends: "Here's my public key"
2. Server checks: "Is this key in /home/azureuser/.ssh/authorized_keys?"
3. Server finds: "No, not here"
4. Server rejects: "Permission denied"

**Troubleshooting Approach:**
1. Checked which user owns the key: `whoami`
2. SSH tried as: azureuser
3. Key was for: devops-user
4. Mismatch found!

**Solution Options:**
1. Use correct user: `ssh -i ~/.ssh/id_rsa devops-user@server` ✅
2. Add key to azureuser's authorized_keys

**Key Learning:**
Clear naming matters. Key names should show purpose:
- Good: `azureuser_key`, `devops_key`
- Bad: `id_rsa`, `key1`, `key2`

**Prevention:**
- Document which key for which user
- Use descriptive key names
- Create ~/.ssh/config (single source of truth)

---

## 🎯 Key Takeaways

### Technical
1. SSH keys are secure → use them
2. File permissions enforce security → respect them
3. 600 permissions on private keys = non-negotiable
4. 700 permissions on ~/.ssh directory = mandatory
5. Verbose output (-vvv) reveals truth

### Soft Skills
1. Systematic troubleshooting beats guessing
2. Documentation prevents future incidents
3. Communication saves hours of debugging
4. Every incident teaches more than tutorials
5. Root cause analysis improves systems

### Process
1. Enable verbose output when debugging
2. Check one variable at a time
3. Test each assumption
4. Document findings
5. Prevent repeat incidents

---

## 📁 Files in This Repository

```
Week-1-SSH-Linux/
├── README.md (this file)
├── CONCEPTS.md (detailed theory)
├── LAB-1-SSH-KEYS.md (step-by-step guide)
├── LAB-2-USERS.md (step-by-step guide)
├── INCIDENT-1-PORT-TIMEOUT.md (debugging walkthrough)
├── INCIDENT-2-PERMISSIONS.md (debugging walkthrough)
├── INCIDENT-3-KEY-MISMATCH.md (debugging walkthrough)
├── scripts/
│   └── setup-and-verify.sh (automated setup)
└── configs/
    ├── ssh-config (example template)
    └── sshd-config-hardened (server config)
```

---

## ✅ What I Can Do Now

- ✅ Generate SSH key pairs securely
- ✅ Manage SSH configs efficiently
- ✅ Create users with proper permissions
- ✅ Debug SSH connection failures systematically
- ✅ Document incidents professionally
- ✅ Understand DevOps fundamentals
- ✅ Know when to use each environment
- ✅ Implement server security best practices

---

## 🔄 Reflection

**What Went Well:**
- Incident-driven learning forced deep understanding
- Writing documentation cemented concepts
- Systematic troubleshooting approach worked
- Hands-on labs beat reading 10 articles

**What Was Challenging:**
- First time debugging SSH issues
- Understanding permission model
- Communicating complex concepts clearly

**Next Week:**
Week 2: Linux Filesystem Fundamentals
- Directory structure
- File operations
- Searching and filtering
- Log analysis

---

**Week 1 Complete!** 🚀
```

---

## 💡 How to Use

### LinkedIn Post
1. Copy the post text above
2. Replace `[your-repo-link]` with your GitHub URL
3. Add image (optional):
   - GitHub repo screenshot
   - Terminal screenshot
   - Or just text
4. Post on LinkedIn

### GitHub README
1. Create file: `README.md`
2. Copy the README content above
3. This is YOUR repository structure now
4. People can review everything here

Both files are ready to use!
