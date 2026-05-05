# PHASE 1 - WEEK 1: Linux Fundamentals & SSH Mastery
## DevOps Foundations, Environments, and Secure Server Access

**Duration:** 3 Days (2 hours each)  
**Difficulty:** Beginner → Intermediate  
**Prerequisites:** None (Linux basic knowledge helpful but not required)

---

# 📚 DAY 1: CONCEPTS & THEORY (2 Hours)

## 1️⃣ DevOps Overview - Bilkul Basics Se Samajhte Hain

### DevOps Kya Hai Actually?

**Simple Definition:**
```
DevOps = Development + Operations ka collaboration
Matlab: Developers aur Operations team ek sath kaam karte hain
Purpose: Code ko jaldi safe aur reliably production mein deploy karna
```

### Traditional Approach vs DevOps

**Scenario: Ek Pizza Delivery App Banana Hai**

#### **Traditional (Waterfall) Approach:**
```
Month 1-2: Dev team likhtay hai code (6 months ka plan banata hai)
Month 3-4: Code poora hota hai
Month 5: Testing shuru
Month 6: Bugs miley, back to dev
Month 7: Finally deploy karte hain

Problem: Agar requirement change ho ya market change ho, toh sab kuch flop

Time to market: 6-12 months
Failures per deployment: 30-40% chance
Collaboration: Bilkul nahin, blame game hota hai
```

**DevOps Approach (Modern):**
```
Week 1: Chota feature likho, test karo, deploy karo
Week 2: User feedback lao, improve karo
Week 3: Dusra feature likho

Har week automatically test aur deploy hota hai

Time to market: Days/Hours
Failures: 1-2% (automation testing catches issues)
Collaboration: Dev + Ops + QA sab ek team
```

### Real-World Examples 2026

| Company | Deployments | Time-to-Fix |
|---------|------------|------------|
| Amazon | 50 MILLION/day | 15 minutes |
| Netflix | Hundreds/hour | 1 hour |
| Google | Continuous | Minutes |
| Traditional Bank | 1/quarter | 3 months |

**Takeaway:** DevOps = Speed + Safety + Collaboration

---

## 2️⃣ SDLC (Software Development Lifecycle) - Poora Process

### Phases (Kya, Kab, Kaun):

```
┌─────────────────────────────────────────────────────────┐
│ 1. PLANNING                                              │
│    ├─ What app banayenga? Business requirement         │
│    ├─ Timeline: 6 months ya 3 months?                  │
│    ├─ Resources: Kitne developers? Budget?             │
│    ├─ Risk analysis: Kya issues aa sakte hain?         │
│    └─ WHO: Product Manager, Business Analyst           │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 2. ANALYSIS & REQUIREMENTS                              │
│    ├─ Detailed features: Kya-kya chahiye?              │
│    ├─ Use cases: Users kaise use karengen?             │
│    ├─ Performance: Kitne users simultaneously?         │
│    ├─ Security: Kya data sensitive hai?                │
│    └─ WHO: Business Analyst, Architects                │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 3. DESIGN (Technical)                                   │
│    ├─ System Architecture: Microservices? Monolith?    │
│    ├─ Database: SQL? NoSQL?                            │
│    ├─ API design: REST? GraphQL?                       │
│    ├─ Infrastructure: Where deploy? AWS? Azure?        │
│    └─ WHO: Solution Architect, Tech Lead               │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 4. DEVELOPMENT (Coding)                                 │
│    ├─ Developers likhtay hain code                     │
│    ├─ Version control (Git) mein save karte hain       │
│    ├─ Code review hota hai                             │
│    ├─ Local mein test karte hain                       │
│    └─ WHO: Software Engineers, Developers              │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 5. TESTING (QA/Quality Assurance)                       │
│    ├─ Unit Testing: Har function sahi ho?              │
│    ├─ Integration Testing: Sab components sath kaam?   │
│    ├─ System Testing: Poora app thik?                  │
│    ├─ UAT (User Acceptance): Client ne approve kiya?   │
│    ├─ Performance Testing: Fast hai?                   │
│    ├─ Security Testing: Hackers nahin kar sakte?       │
│    └─ WHO: QA Engineers, Testers                       │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 6. DEPLOYMENT (Release to Production)                   │
│    ├─ Build: Code ko executable banao (Docker image)   │
│    ├─ Deploy: Production servers mein dal do           │
│    ├─ Smoke tests: Kya app open ho raha?              │
│    ├─ User notification: "New version available"       │
│    └─ WHO: DevOps Engineers, Release Manager           │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ 7. MAINTENANCE & MONITORING                             │
│    ├─ Monitor: Server healthy hai? Performance ok?     │
│    ├─ Logs: Errors track karo                          │
│    ├─ Bugs: User nahe zyada koi bug lagaya?            │
│    ├─ Patches: Security updates ayen?                  │
│    ├─ Performance tuning: Slow response times?         │
│    └─ WHO: DevOps, SRE, Support Engineers              │
└─────────────────────────────────────────────────────────┘
```

### DevOps Team Kahan Involved Hota Hai?

```
Planning ──► Analysis ──► Design ──► Development
                                         ▼
Maintenance ◄── Monitoring ◄── Deployment ◄── Testing
                                         ▲
                            DevOps Automates This!
```

---

## 3️⃣ Environments: DEV, SIT, UAT, PROD - Samajhte Hain

**Scenario:** Pizza ordering app banaya. Har step mein different environment use hota hai.

### Environment Lifecycle

```
DEV (Development)
├─ Your laptop ya development server
├─ Sirf tum code likh rahe ho
├─ Database: Fake data
├─ Anything can break, koi farak nahin
├─ Configuration: Hardcoded passwords OK
├─ Access: Open for everyone on team
├─ Example: localhost:3000
└─ Cost: Almost free

      ▼ (Code ready for testing)

SIT (System Integration Testing)
├─ Shared server jahan multiple components combine hote hain
├─ Database: Fresh copy of real database structure
├─ End-to-end flow testing
├─ "API + Frontend + Database = sab sath kaam kar rahe?"
├─ Configuration: Test API keys, test databases
├─ Access: Dev team + QA team
├─ Example: sit-api.internal-company.com
└─ Cost: Small budget (1-2 servers)

      ▼ (Everything works together)

UAT (User Acceptance Testing)
├─ Client/Business team isko test karte hain
├─ Database: Real production-like data (but dummy customers)
├─ Users ki actual workflow test hota hai
├─ "Kya clients ko feature pasand hai?"
├─ Configuration: Production-like but safe
├─ Access: Client team + internal team
├─ Example: uat-pizza.company.com
└─ Cost: Medium (good performance needed)

      ▼ (Client approved, safe to go live)

PRODUCTION (PROD)
├─ Real users use kar rahe hain
├─ Real money involved
├─ Real customers' data
├─ Database: Real production data
├─ Configuration: Secrets properly managed
├─ Access: Only authorized DevOps/SRE
├─ Monitoring: 24/7 alerting
├─ Example: pizza-order.com
├─ Backup: Multiple backups (hourly, daily, weekly)
└─ Cost: High budget (redundancy, scaling needed)
```

### Environment Configuration Example

```
Development (DEV)
├─ Database host: localhost:5432
├─ API timeout: 60 seconds
├─ Logging: VERBOSE (sab kuch print karo)
├─ Cache: Disabled (hamesha fresh data)
└─ Auth: Skip (testing ke liye)

SIT
├─ Database host: sit-db.internal:5432
├─ API timeout: 30 seconds
├─ Logging: INFO (important things only)
├─ Cache: Enabled (test caching)
└─ Auth: Test users with real auth flow

UAT
├─ Database host: uat-db.internal:5432
├─ API timeout: 10 seconds (production-like)
├─ Logging: WARNING (only problems)
├─ Cache: Fully enabled
└─ Auth: Real client users

PRODUCTION
├─ Database host: prod-db.internal:5432 (replicated)
├─ API timeout: 5 seconds (fast)
├─ Logging: ERROR (only critical)
├─ Cache: Advanced caching
└─ Auth: Production OAuth, MFA enabled
```

### Real Incident Example:

```
2 AM: "App crash ho gaya!"
├─ Check Production logs: "Database connection failed"
├─ Why wasn't this caught before?
│  └─ SIT/UAT mein simpler database config tha
│  └─ Production load 1000x zyada tha
│  └─ Connection pool limit exceed hua
│
├─ Fix quickly (Emergency deployment)
└─ Learn: Add stress testing in UAT

Moral: Testing environments production ka real replica nahin the
```

---

## 4️⃣ SSH - Secure Shell (Kya Hai, Kaise Kaam Karta Hai)

### Problem: Remote Server Ko Kaise Control Kare?

```
Traditional (Insecure):
┌─────────────┐                    ┌──────────────┐
│ Your Laptop │ ─── Telnet ───────► │ Server       │
│ (Clear Text)│  Password: admin123 │ (Insecure!)  │
└─────────────┘                    └──────────────┘
           ▼
       Hacker ne intercept kar liya! 🚨
```

```
Modern (SSH - Secure):
┌─────────────┐                    ┌──────────────┐
│ Your Laptop │ ─── Encrypted ────► │ Server       │
│ (Private    │   Connection        │ (Safe!)      │
│  Key)       │                     │ (Public Key) │
└─────────────┘                    └──────────────┘
           ▼
       Hacker ko nahin samajh aayega! ✅
```

### SSH Kaise Kaam Karta Hai (Simple Explanation)

```
Step 1: Server koi secret lock rakhta hai (Public Key)
Step 2: Tum apna secret chabi rakhte ho (Private Key)
Step 3: Server boleta: "Apni chabi se isko unlock kar"
Step 4: Agar tum unlock kar sake, matlab tum authorized ho
Step 5: Connection establish hota hai (Encrypted)

Analogy:
- Public Key = Airport ka X-ray machine (sabko available)
- Private Key = Apni body (sirf tum jaante ho)
- SSH = Secure encrypted tunnel
```

### SSH Key Pair - Kya Hai

```
┌──────────────────────────────────────┐
│ SSH Key Pair (Ek set)               │
│                                      │
│ Private Key (apke pass)             │
│ ├─ Bilkul secret                    │
│ ├─ ~/.ssh/id_rsa                    │
│ ├─ Permissions: 600 (sirf tum read) │
│ └─ Kabhi share mat karo!            │
│                                      │
│ Public Key (server mein)            │
│ ├─ Sab ko de sakte ho               │
│ ├─ ~/.ssh/authorized_keys           │
│ ├─ Permissions: 644 (sab read)     │
│ └─ Server mein aapko identify karta │
└──────────────────────────────────────┘
```

### SSH Connection Flow

```
1. Tum command do:
   $ ssh user@server.com

2. Tum apni private key submit karte ho:
   "Yeh mera proof hai"

3. Server apke authorized_keys check karta hai:
   "Haan, yeh key maikhe hai"

4. Server challenge karta hai:
   "Thik hai, ek test solve karo"

5. Tum apni private key se test solve karte ho
   (Server public key se verify karta hai)

6. ✅ Access granted!
   Encrypted tunnel open hota hai
```

---

## 5️⃣ Basic Server Hygiene - Production Ready Hone Ke Liye

### Kya Hota Hai "Server Hygiene"?

```
Saf sahaf server = Secure + Fast + Reliable

Dirty Server:
├─ 100 unused packages installed
├─ Old versions (security vulnerabilities)
├─ Random files scattered
├─ No organization
├─ Slow, unsafe, unpredictable
└─ "Kya tha yahan?" - nahin pata

Clean Server:
├─ Sirf needed packages
├─ Latest security patches
├─ Organized directory structure
├─ Clear naming conventions
├─ Fast, secure, predictable
└─ "Kya tha yahan?" - bilkul pata
```

### Best Practices (Har Production Server Mein)

```
1. USERS & PERMISSIONS
   ├─ Root user kabhi direct use mat karo
   ├─ Service users create karo (nginx, app)
   ├─ SSH key-based auth (password nahin)
   ├─ Sudo access carefully manage karo
   └─ Regular user audit (kitte users hain?)

2. SSH SECURITY
   ├─ Default port 22 badlo (port 2222 jaise)
   ├─ Root login disable karo (PermitRootLogin no)
   ├─ Password auth disable karo (PubkeyAuthentication only)
   ├─ Keep SSH updated
   └─ Monitor SSH logs for attempts

3. PACKAGES & UPDATES
   ├─ Har 2 weeks update aur patching
   ├─ Security updates immediately
   ├─ Uninstall unused packages
   ├─ Track kya installed hai (apt list --installed)
   └─ Use package manager (apt/yum), not manual

4. DISK & FILESYSTEM
   ├─ Regular cleanup of /tmp
   ├─ Log rotation (logs purane na ho jaye)
   ├─ Monitor disk space (80% limit)
   ├─ Separate partitions: /, /var, /home
   └─ Regular backups (daily)

5. FIREWALL & NETWORKING
   ├─ Only needed ports open
   ├─ SSH, HTTP, HTTPS typically
   ├─ Block everything else (ufw/firewalld)
   ├─ Logging enabled for dropped packets
   └─ Regular network audit

6. MONITORING & LOGS
   ├─ Monitor CPU, Memory, Disk
   ├─ Check /var/log daily
   ├─ Setup alerts for critical events
   ├─ Failed login attempts track karo
   └─ Centralized logging (ELK, Splunk)

7. ACCESS CONTROL
   ├─ Principle of least privilege
   ├─ Only needed permissions
   ├─ Regular access review
   ├─ Audit log sabka karo
   └─ SSH key rotation quarterly

8. BACKUP & DISASTER RECOVERY
   ├─ Daily backup (automated)
   ├─ Off-site backup (different location)
   ├─ Restore test (monthly)
   ├─ Document recovery procedure
   └─ RTO/RPO defined (Recovery Time/Point Objective)
```

### Real Production Server Checklist

```
☐ OS updated (apt update && apt upgrade)
☐ SSH hardened (custom port, no root login)
☐ Firewall configured (ufw enable)
☐ Users created (no root for daily work)
☐ Monitoring installed (prometheus, datadog)
☐ Logs centralized
☐ Backup configured
☐ SSH keys rotated
☐ Certificates valid (SSL/TLS)
☐ Performance baseline set
☐ Incident contacts documented
☐ Change log maintained
```

---

---

# 🛠️ DAY 2: HANDS-ON LABS (2 Hours)

## Lab 1: SSH Keys Create Karo aur Server Se Connect Karo

### Setup Requirements

```
You need:
1. Linux/Mac laptop (or WSL on Windows)
2. A Linux VM (Azure free tier, or local VirtualBox)
   - Ubuntu 22.04 recommended
   - 2GB RAM, 20GB disk sufficient
3. SSH client (bash, already installed)
```

### Step 1: Local Machine Par SSH Keys Generate Karo

```bash
# Step 1a: SSH directory banao (agar nahi hai)
mkdir -p ~/.ssh
cd ~/.ssh

# Step 1b: SSH key pair generate karo
# Command: ssh-keygen -t rsa -b 4096 -f id_rsa -N ""
# Explanation:
#   -t rsa: RSA encryption (strong)
#   -b 4096: 4096-bit key (very secure)
#   -f id_rsa: Filename kya ho
#   -N "": No passphrase (production mein passphrase use karna)

ssh-keygen -t rsa -b 4096 -f ~/.ssh/devops_demo -N ""

# Output:
# Generating public/private rsa key pair.
# Created directory '/home/yourname/.ssh'.
# Your identification has been saved in /home/yourname/.ssh/devops_demo
# Your public key has been saved in /home/yourname/.ssh/devops_demo.pub
# Key fingerprint is SHA256:abc...xyz
```

### Step 2: Keys Ko Verify Karo

```bash
# Dekho kya keys banay hain
ls -la ~/.ssh/

# Output:
# -rw-------  1 user group 3381 Dec 19 10:30 devops_demo      (PRIVATE - 600)
# -rw-r--r--  1 user group  753 Dec 19 10:30 devops_demo.pub  (PUBLIC - 644)

# Private key dekho (secret nahin share karna!)
cat ~/.ssh/devops_demo.pub

# Output example:
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxxx...long key...xxx user@laptop
```

### Step 3: Server Ko Setup Karo

```bash
# Azure mein VM create karo (free tier) OR use existing server

# Server ka IP note karo: e.g., 13.88.192.45
# Default user: azureuser (or ec2-user, ubuntu, etc.)
# Password: Temporarily allow karo ya SSH key direct setup

SERVER_IP="13.88.192.45"
SERVER_USER="azureuser"
```

### Step 4: Public Key Server Mein Copy Karo

**Option A: Using ssh-copy-id (Easiest)**

```bash
# Pehli baar password se connect karega
ssh-copy-id -i ~/.ssh/devops_demo.pub -p 22 azureuser@13.88.192.45

# Enter password when prompted
# Output:
# Number of key(s) added: 1
# Now try logging into the machine with "ssh 'azureuser@13.88.192.45'"
```

**Option B: Manual (Agar ssh-copy-id available nahin)**

```bash
# Server mein login karo (password use karte hue)
ssh azureuser@13.88.192.45

# Server par:
mkdir -p ~/.ssh
echo "your_public_key_content_here" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
exit
```

### Step 5: SSH Key Se Connect Karo

```bash
# SSH kar with key (no password!)
ssh -i ~/.ssh/devops_demo azureuser@13.88.192.45

# Output:
# Welcome to Ubuntu 22.04 LTS
# azureuser@myserver:~$

# Hooray! Tum server mein ho! ✅

# Verify karo SSH connection
whoami
# Output: azureuser

pwd
# Output: /home/azureuser

hostname
# Output: myserver
```

### Step 6: ~/.ssh/config Banao (Optional but Recommended)

```bash
# Local machine par
cat > ~/.ssh/config << 'EOF'
Host devops-demo
    HostName 13.88.192.45
    User azureuser
    IdentityFile ~/.ssh/devops_demo
    Port 22
    StrictHostKeyChecking accept-new
    UserKnownHostsFile ~/.ssh/known_hosts
EOF

# Permissions set karo
chmod 600 ~/.ssh/config

# Ab bas likho:
ssh devops-demo

# Instead of:
ssh -i ~/.ssh/devops_demo azureuser@13.88.192.45
```

### Step 7: SSH Fingerprint Verify Karo

```bash
# Local machine par, pehli connection mein ye message aayega:
# The authenticity of host '13.88.192.45' can't be established.
# RSA key fingerprint is SHA256:abc123xyz...

# Server par check karo:
ssh-keygen -lf /etc/ssh/ssh_host_rsa_key.pub

# Agar match kare, toh (yes) likho
# yes

# Ab ~/.ssh/known_hosts mein save ho jayega
cat ~/.ssh/known_hosts
```

### Lab 1 Verification Checklist

```
☐ Private key created: ~/.ssh/devops_demo (600 permissions)
☐ Public key created: ~/.ssh/devops_demo.pub (644 permissions)
☐ Public key server mein: ~/.ssh/authorized_keys
☐ SSH connection successful (no password!)
☐ Config file created (optional)
☐ Fingerprint verified
☐ Can run commands remotely

Test Command:
ssh devops-demo "uname -a"
# Should show server info without asking password
```

---

## Lab 2: User Create Karo aur Sudo Setup Karo

### Why Do We Need Different Users?

```
Bad Practice (Everything as root):
- Security vulnerability
- Can't track konne ne kya delete kiya
- Accidental destructive commands easy
- Against principle of least privilege

Good Practice (Different users for different roles):
- App runs as 'appuser' (limited permissions)
- Admin operations as 'admin' (can do sudo)
- Monitoring as 'monitoruser' (read-only logs)
- Each user ka own audit trail
```

### Step 1: Server Mein Login Karo

```bash
ssh devops-demo
# or
ssh -i ~/.ssh/devops_demo azureuser@13.88.192.45
```

### Step 2: Naya User Create Karo

```bash
# Verify tum server par ho
whoami
# Output: azureuser

# Check current users
cat /etc/passwd | grep -E "bash|zsh"
# Shows all shell users

# Naya user banao
sudo useradd -m -s /bin/bash devops-user

# Explanation:
#   useradd: Create user
#   -m: Create home directory
#   -s /bin/bash: Set shell to bash (interactive shell)
#   devops-user: Username

# Verify user created
id devops-user
# Output:
# uid=1001(devops-user) gid=1001(devops-user) groups=1001(devops-user)

# Check home directory
ls -la /home/devops-user/
# Output:
# drwxr-xr-x  2 devops-user devops-user 4096 Dec 19 10:45 .
# drwxr-xr-x  5 root        root        4096 Dec 19 10:45 ..
# -rw-r--r--  1 devops-user devops-user  220 Dec 19 10:45 .bash_logout
# -rw-r--r--  1 devops-user devops-user 3771 Dec 19 10:45 .bashrc
# -rw-r--r--  1 devops-user devops-user  807 Dec 19 10:45 .profile
```

### Step 3: User Ka Password Set Karo (Temporary)

```bash
# Set temporary password
sudo passwd devops-user

# Enter password (e.g., TempPass123!)
# Confirm password

# User ko force karo password change karte time first login
sudo passwd -e devops-user

# Now user ko next login time change karna padega
```

### Step 4: SSH Keys Banao Devops User Ke Liye

```bash
# Switch to devops-user (using password)
su - devops-user

# Verify
whoami
# Output: devops-user

# SSH directory banao
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# SSH key generate karo
ssh-keygen -t rsa -b 4096 -f ~/.ssh/devops_key -N ""

# Verify
ls -la ~/.ssh/
# Output:
# -rw-------  1 devops-user devops-user 3381 Dec 19 10:50 devops_key
# -rw-r--r--  1 devops-user devops-user  753 Dec 19 10:50 devops_key.pub

# Public key authorized_keys mein daalo
cat ~/.ssh/devops_key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Test local SSH (should work)
ssh -i ~/.ssh/devops_key devops-user@localhost
# Output:
# devops-user@server:~$
exit
```

### Step 5: Sudo Access Setup Karo

```bash
# Back to azureuser (exit from devops-user)
exit
# Output: azureuser@server:~$

# Check sudo group
getent group sudo
# Output: sudo:x:27:

# Check sudoers file (CAREFULLY!)
sudo cat /etc/sudoers
# Output (partial):
# # User privilege specification
# root    ALL=(ALL:ALL) ALL
# 
# # Members of the admin group may gain root privileges
# %admin ALL=(ALL) ALL
# 
# # Allow members of group sudo to execute any command
# %sudo   ALL=(ALL:ALL) ALL

# Add devops-user to sudo group
sudo usermod -aG sudo devops-user

# Verify
id devops-user
# Output:
# uid=1001(devops-user) gid=1001(devops-user) groups=1001(devops-user),27(sudo)
#                                                                    ^^^^ Added!

# Alternative: Direct sudoers entry (safer than editing /etc/sudoers directly)
sudo visudo -f /etc/sudoers.d/devops-user

# Add this line:
# devops-user ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /bin/systemctl

# Save and exit (if using nano: Ctrl+X, Y, Enter)
```

### Step 6: Test Sudo Access

```bash
# Switch to devops-user
su - devops-user

# Test basic command
whoami
# Output: devops-user

# Test sudo without password
sudo -i

# Output:
# root@server:~#

# Verify root
whoami
# Output: root

# Check sudoers
sudo cat /etc/sudoers.d/devops-user
# Output:
# devops-user ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /bin/systemctl

exit
# Back to devops-user
```

### Step 7: User Directory Permissions

```bash
# Check home directory permissions
ls -ld /home/devops-user/
# Output: drwxr-xr-x  3 devops-user devops-user 4096 Dec 19 10:50 /home/devops-user/
#         ^           ^ devops-user devops-user
#         └─ 755: Owner read/write/exec, Group/Other read/exec

# This is good for home directory (owner can do everything)

# Check SSH directory
ls -ld ~/.ssh/
# Output: drwx------  2 devops-user devops-user 4096 Dec 19 10:50 /home/devops-user/.ssh/
#         ^           
#         └─ 700: Owner read/write/exec only (STRICT!)

# Check files
ls -la ~/.ssh/
# Output:
# -rw-------  1 devops-user devops-user 3381 Dec 19 10:50 devops_key      (600)
# -rw-r--r--  1 devops-user devops-user  753 Dec 19 10:50 devops_key.pub  (644)
# -rw-------  1 devops-user devops-user  753 Dec 19 10:50 authorized_keys (600)

# Perfect! Only owner can read/write
```

### Lab 2 Verification Checklist

```
☐ New user created: devops-user
☐ Home directory: /home/devops-user exists
☐ SSH directory: /home/devops-user/.ssh (700 permissions)
☐ SSH key pair: devops_key + devops_key.pub
☐ Authorized keys: ~/.ssh/authorized_keys (contains public key)
☐ User added to sudo group
☐ Sudo access tested (no password)
☐ Can SSH with key (from local machine)

Test Command:
ssh -i /path/to/devops_key devops-user@devops-demo "sudo whoami"
# Should output: root
```

---

---

# 🚨 DAY 3: INCIDENT SCENARIOS (2 Hours)

## Incident 1: SSH Connection Failure - Wrong Port

### Scenario

```
You are on-call DevOps engineer.
3 AM: Urgent Slack message from developer:
"CANNOT ACCESS SERVER! Getting connection timeout!"

Dev trying: ssh azureuser@13.88.192.45
Error: ssh: connect to host 13.88.192.45 port 22: Connection timed out

Your job: Fix it in 10 minutes before users wake up!
```

### Troubleshooting Steps (Systematic Approach)

#### Step 1: Gather Information

```bash
# What does developer know?
# - Server IP: 13.88.192.45
# - User: azureuser
# - Error: Connection timeout on port 22

# First, verify developer's setup
ssh -vvv azureuser@13.88.192.45 -p 22

# Output (verbose):
# OpenSSH_8.2p1 Ubuntu 4ubuntu0.2, OpenSSL 1.1.1f
# debug1: Reading configuration data /home/user/.ssh/config
# debug1: No more authentication methods to try.
# debug1: Trying to connect to 13.88.192.45 port 22...
# ssh: connect to host 13.88.192.45 port 22: Connection timed out
```

#### Step 2: Check If Server is Running

```bash
# Try ping
ping -c 3 13.88.192.45

# If no response: Server down or network issue
# If response OK: Server up, but port 22 blocked

# In this case: Ping works, so server is up
# Port 22 issue!
```

#### Step 3: Check Firewall Rules

```bash
# If server is running but port 22 not responding:
# Could be:
# 1. Firewall blocking
# 2. SSH daemon not running
# 3. SSH on different port

# From server (ask admin to check):
sudo ufw status
# Output:
# Status: active
# To                         Action      From
# --                         ------      ----
# 2222/tcp                   ALLOW       Anywhere
# 22/tcp                     DENY        Anywhere
#
# AHA! Port 2222 allowed, but 22 DENY!

# WHO CHANGED THE PORT?
sudo grep "^Port " /etc/ssh/sshd_config
# Output: Port 2222
```

#### Step 4: Solution

**For Developer:**

```bash
# Try new port
ssh -p 2222 azureuser@13.88.192.45

# Output:
# azureuser@server:~$

# SUCCESS! ✅
```

**For Admin (To prevent future incidents):**

```bash
# Option A: Change SSH back to standard port 22
sudo sed -i 's/^Port 2222/Port 22/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Option B: Tell team about port change (Better!)
# - Update documentation
# - Update SSH config (~/.ssh/config)
# - Send Slack notification
```

### Step 5: Update Team Documentation

```bash
# Create/Update .ssh/config
cat > ~/.ssh/config << 'EOF'
Host devops-demo
    HostName 13.88.192.45
    User azureuser
    IdentityFile ~/.ssh/devops_demo
    Port 2222              # <-- Updated!
    StrictHostKeyChecking accept-new
EOF

# Send to team:
# "⚠️ SSH port changed to 2222 for security hardening"
# "Update: ssh devops-demo (uses ~/.ssh/config)"
```

### Incident 1 Summary & Documentation

```markdown
## Incident Report: SSH Port 22 Connection Failure

**Severity:** HIGH (Complete access loss)
**Duration:** 15 minutes (3:00 AM - 3:15 AM)
**Impact:** 1 developer blocked, 10 deployments pending

### Root Cause
SSH daemon port was changed from 22 to 2222 without notification.
Change was made by: Admin (for security hardening)
Not communicated to development team.

### Timeline
- 3:00 AM: Developer attempts SSH on port 22
- 3:00 AM: Connection timeout (firewall blocking)
- 3:05 AM: Escalated to on-call DevOps
- 3:08 AM: Identified port change in sshd_config
- 3:10 AM: Communicated new port to developer
- 3:12 AM: Developer successfully connects on port 2222

### Solution
1. Updated ~/.ssh/config with Port 2222
2. Sent team notification
3. Updated documentation wiki

### Prevention
1. Create change management process
2. Notify team 24 hours before port changes
3. Automated config backup before sshd changes
4. Monitoring for SSH access failures

### Action Items
☐ Document standard SSH port for this infrastructure
☐ Create pre-deployment checklist for changes
☐ Add SSH port to monitoring alerts
☐ Send port change notice to #infrastructure channel
```

---

## Incident 2: SSH Permission Denied - Wrong Key Permissions

### Scenario

```
Another day, another issue:
Dev message: "Permission denied (publickey)"

ssh -i ~/.ssh/old_key azureuser@13.88.192.45 -p 2222
Permission denied (publickey).

I'm sure my key is correct! Help!
```

### Troubleshooting Steps

#### Step 1: Check Key Exists and Readable

```bash
# Does key file exist?
ls -la ~/.ssh/old_key

# Output: 
# -rw-rw-rw- 1 user group 1704 Dec 19 09:00 old_key
#  ^^^^^^^^^
#  PROBLEM! Permissions are 666 (way too open!)

# SSH requires:
# - Private key: 600 (owner read/write only)
# - .ssh directory: 700
# - Public key: 644

# SECURITY RULE:
# "If private key is readable by others, SSH refuses to use it"
# (To prevent accidental exposure)

# Fix:
chmod 600 ~/.ssh/old_key
chmod 700 ~/.ssh

# Verify:
ls -la ~/.ssh/old_key
# Output:
# -rw------- 1 user group 1704 Dec 19 09:00 old_key
# ^^^^^^^^^
# Perfect! Only owner can read
```

#### Step 2: Verbose SSH to See Actual Error

```bash
# Try again with verbose
ssh -vvv -i ~/.ssh/old_key azureuser@13.88.192.45 -p 2222

# Output:
# debug1: Identity added: /home/user/.ssh/old_key (user@laptop)
# debug1: Offering public key: /home/user/.ssh/old_key
# debug1: Server accepted key
# debug1: Authentication succeeded (publickey).
# Success! ✅
```

#### Step 3: Check Server-Side Permissions

```bash
# If still failing, check server side:
ssh -p 2222 azureuser@13.88.192.45

# Server check:
ls -la ~/.ssh/
# Output:
# drwxr-xr-x  2 azureuser azureuser 4096 Dec 19 10:30 .
# ^^^^^^^^^
# WRONG! Should be 700, not 755

# Check authorized_keys:
ls -la ~/.ssh/authorized_keys
# Output:
# -rw-rw-rw- 1 azureuser azureuser  380 Dec 19 10:30 authorized_keys
# ^^^^^^^^^
# WRONG! Should be 600, not 666

# Fix on server:
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# Now it works!
```

### Incident 2 Summary & Documentation

```markdown
## Incident Report: SSH Permission Denied (PublicKey)

**Severity:** MEDIUM (Can't access server)
**Duration:** 5 minutes
**Impact:** 1 developer waiting

### Root Cause
Private key had incorrect permissions: 666 instead of 600
SSH security feature: Refuses keys with world-readable permissions

### Why This Happens
1. Created key with default umask (too open)
2. Shared key file with wrong permissions
3. File transferred with copied permissions

### Solution
```bash
chmod 600 ~/.ssh/old_key
chmod 700 ~/.ssh
```

### Prevention
1. Create keys with correct permissions from start:
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
   (Already sets 600)
   
2. Add to .bashrc (check and fix):
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/*
   
3. Monitor for permission changes:
   ls -la ~/.ssh/ | grep "^-rw-rw" # Warn if found
```

---

## Incident 3: SSH Connection Failure - Wrong Key for User

### Scenario

```
New team member:
"I got SSH key: id_rsa
SSH command from documentation: ssh azureuser@server.com
But getting: Permission denied (publickey)"

They have:
- Server: 13.88.192.45:2222
- Key: ~/.ssh/id_rsa (their personal key)
- User: azureuser
- But: Key was generated for 'devops-user', not 'azureuser'
```

### Troubleshooting

#### Step 1: Identify the Issue

```bash
# Check public key on server
ssh -vvv -i ~/.ssh/id_rsa azureuser@13.88.192.45 -p 2222

# Output:
# debug1: Trying private key /home/user/.ssh/id_rsa
# debug1: Server accepted key
# debug1: Offering public key: /home/user/.ssh/id_rsa
# Permission denied (publickey).
# Permission denied (publickey).
# debug1: No more authentication methods to try.
# Connection closed by remote host.

# Check: Is public key in azureuser's authorized_keys?
ssh -p 2222 someadmin@13.88.192.45
cat /home/azureuser/.ssh/authorized_keys

# Output:
# ssh-rsa AAAAB3...xyz (this key is for devops-user, not in azureuser's auth_keys)
```

#### Step 2: Solution

**Option A: Use Correct Key for Correct User**

```bash
# If key is for devops-user:
ssh -i ~/.ssh/id_rsa devops-user@13.88.192.45 -p 2222
# SUCCESS!

# If need to use azureuser, get correct key or regenerate
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azureuser_key -N ""
```

**Option B: Add Public Key to Multiple Users**

```bash
# As admin, copy key to azureuser:
ssh -p 2222 azureuser@13.88.192.45

# On server:
mkdir -p ~/.ssh
echo "ssh-rsa AAAAB3...xyz" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

### Incident 3 Summary

```markdown
## Incident Report: SSH Key Mismatch (Wrong User)

**Severity:** LOW (Can use different user)
**Duration:** 2 minutes (once root cause found)
**Impact:** 1 team member confusion

### Root Cause
SSH key was generated for 'devops-user' but developer tried 'azureuser'
Public key not in /home/azureuser/.ssh/authorized_keys

### Solution
1. Use correct user: `ssh -i key devops-user@server`
OR
2. Add key to azureuser's authorized_keys

### Prevention
1. Document: Which user? Which key? (Wiki)
2. Onboarding script to setup keys properly
3. SSH config template for new team members
```

---

---

# 💡 IMPROVEMENTS & ADVANCED TOPICS

## Additional Practices Beyond Syllabus

### 1. SSH Key Rotation (Security Best Practice)

```bash
# Every 3-6 months, regenerate SSH keys

# Generate new key
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_new -N ""

# Note: ed25519 is more secure than rsa-4096, smaller file
# Test new key
ssh -i ~/.ssh/id_ed25519_new devops-demo

# If works: Remove old key from server
# On server:
vim ~/.ssh/authorized_keys
# Remove old key line

# Delete old local key
rm ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

# Update config
cat > ~/.ssh/config << 'EOF'
Host devops-demo
    HostName 13.88.192.45
    User devops-user
    IdentityFile ~/.ssh/id_ed25519
    Port 2222
EOF
```

### 2. SSH Bastion Host / Jump Host (For Prod Access)

```bash
# Scenario: Can't directly access prod-server from internet
# Need to go through jump-host (bastion)

# Network: Your laptop → Bastion → Prod Server

# Setup:
cat > ~/.ssh/config << 'EOF'
Host bastion
    HostName bastion.company.com
    User admin
    IdentityFile ~/.ssh/bastion_key
    Port 22

Host prod-db
    HostName 10.0.1.100 (internal IP, not internet accessible)
    User postgres
    IdentityFile ~/.ssh/prod_key
    ProxyJump bastion
    Port 5432
EOF

# Now:
ssh prod-db
# Automatically routes through bastion!
```

### 3. SSH Agent (Manage Keys Without Typing)

```bash
# Problem: You have 5 different keys for 5 servers
# Each time SSH asks: "Which key you want to use?"

# Solution: SSH Agent (stores keys in memory)

# Start agent:
eval $(ssh-agent -s)
# Output: Agent pid 12345

# Add keys:
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/prod_key
ssh-add ~/.ssh/bastion_key

# Check added keys:
ssh-add -l
# Output:
# 2048 SHA256:aaaa... /home/user/.ssh/id_rsa (RSA)
# 2048 SHA256:bbbb... /home/user/.ssh/prod_key (RSA)
# 2048 SHA256:cccc... /home/user/.ssh/bastion_key (RSA)

# Now SSH automatically uses correct key!
ssh devops-demo
# No prompt!

# Add to ~/.bashrc so it auto-starts:
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
fi
```

### 4. SSH Config Aliases (Productivity)

```bash
# Create ~/.ssh/config with many hosts

cat > ~/.ssh/config << 'EOF'
# Development
Host dev
    HostName dev.company.internal
    User devops-user
    IdentityFile ~/.ssh/dev_key
    Port 2222

# Staging
Host staging
    HostName staging.company.internal
    User devops-user
    IdentityFile ~/.ssh/staging_key
    Port 2222

# Production (with bastion)
Host prod-app
    HostName prod-app.internal
    User apprunner
    IdentityFile ~/.ssh/prod_key
    Port 22
    ProxyJump bastion

# Copy files (SCP) shortcuts
Host *
    AddKeysToAgent yes
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
EOF

# Now you can:
ssh dev          # Instead of: ssh -i ~/.ssh/dev_key devops-user@dev.company.internal -p 2222
scp ~/file dev:~/uploads/
rsync -av ~/dir/ staging:~/backup/
```

### 5. SSH Security Hardening (For Server Admin)

```bash
# On Server: /etc/ssh/sshd_config

# Key settings:
# 1. Change port (non-standard)
Port 2222

# 2. Disable root login
PermitRootLogin no

# 3. Disable password auth (key-based only)
PubkeyAuthentication yes
PasswordAuthentication no

# 4. Disable empty passwords
PermitEmptyPasswords no

# 5. Limit login attempts
MaxAuthTries 3
MaxSessions 10

# 6. Set idle timeout
ClientAliveInterval 300
ClientAliveCountMax 2

# 7. Disable X11 forwarding (unless needed)
X11Forwarding no

# 8. Disable port forwarding (unless needed)
AllowTcpForwarding no

# 9. Allow specific users only
AllowUsers devops-user admin@192.168.1.* azureuser

# 10. Strong key exchange
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com

# Apply changes:
sudo systemctl restart sshd

# Test (DON'T LOG OUT!):
ssh -p 2222 devops-demo

# If works, log out safely:
exit
```

### 6. SSH Monitoring & Logging

```bash
# Check failed login attempts:
sudo cat /var/log/auth.log | grep "Failed password"

# Check successful logins:
sudo cat /var/log/auth.log | grep "Accepted publickey"

# Monitor failed attempts in real-time:
sudo tail -f /var/log/auth.log | grep "authentication failure"

# Setup alert for too many failed attempts:
# (Use fail2ban or similar)

sudo apt-get install fail2ban

cat > /etc/fail2ban/jail.d/sshd.conf << 'EOF'
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
EOF

sudo systemctl restart fail2ban
```
### Day 1: Concepts (2 hours)
- [ ] Read: DevOps fundamentals
- [ ] Read: SDLC overview
- [ ] Read: Environment types (DEV/SIT/UAT/PROD)
- [ ] Read: SSH theory
- [ ] Read: Server hygiene checklist

**Deliverable:** Understand why each concept matters

### Day 2: Hands-on Labs (2 hours)
- [ ] Lab 1: Create SSH keys
- [ ] Lab 1: Connect to VM with key
- [ ] Lab 1: Create ~/.ssh/config
- [ ] Lab 2: Create devops-user
- [ ] Lab 2: Setup sudo access
- [ ] Lab 2: Verify file permissions

**Deliverable:** Working SSH access + new user with sudo

### Day 3: Incident Scenarios (2 hours)
- [ ] Incident 1: Troubleshoot port change
- [ ] Incident 2: Fix permission errors
- [ ] Incident 3: Resolve key mismatch
- [ ] Document all incidents (RCA)
- [ ] Create LinkedIn post
- [ ] Review checklist

**Deliverable:** 3 incident reports + portfolio post

## Verification Checklist

```bash
# Lab 1 Verification
✓ Private key: ~/.ssh/devops_demo (permissions: 600)
✓ Public key: ~/.ssh/devops_demo.pub (permissions: 644)
✓ SSH connection: ssh devops-demo (no password!)
✓ Config file: ~/.ssh/config contains correct host

# Lab 2 Verification
✓ User created: id devops-user
✓ Sudo access: groups devops-user | grep sudo
✓ SSH key setup: ls -la /home/devops-user/.ssh/
✓ Authorized keys: cat ~/.ssh/authorized_keys

# Run verification script:
bash labs/lab-1-ssh-keys/verify.sh
bash labs/lab-2-users-sudo/verify.sh
```

## Incident Resolution Examples

### Incident 1: SSH Connection Timeout

**Problem:**
```
ssh: connect to host 13.88.192.45 port 22: Connection timed out
```

**Root Cause:** Port changed from 22 to 2222

**Solution:**
```bash
# Update ~/.ssh/config
sed -i 's/Port 22/Port 2222/' ~/.ssh/config

# Or manually:
echo "Port 2222" >> ~/.ssh/config
```

**Prevention:** Change notification process

### Incident 2: Permission Denied

**Problem:**
```
Permission denied (publickey)
```

**Root Cause:** Private key has 666 permissions (too open)

**Solution:**
```bash
chmod 600 ~/.ssh/devops_demo
chmod 700 ~/.ssh
```

**Prevention:** Key generation already sets correct perms

### Incident 3: Wrong Key for User

**Problem:**
```
Permission denied (publickey) when using correct key
```

**Root Cause:** Key is for devops-user, trying as azureuser

**Solution:**
```bash
# Option A: Use correct user
ssh -i ~/.ssh/id_rsa devops-user@server

# Option B: Add key to user
# On server: echo "ssh-rsa AAAA..." >> ~/.ssh/authorized_keys
```

## Key Learnings

### Security Principles

1. **Principle of Least Privilege**
   - Users get minimum needed permissions
   - Sudo for specific commands only

2. **Defense in Depth**
   - SSH key-based auth (not password)
   - Proper file permissions (600/700)
   - Port change (non-standard port)
   - Firewall rules

3. **Auditability**
   - Track who has access
   - SSH logs for all connections
   - Permission changes documented

### Practical Skills

- [ ] Generate SSH keys (RSA-4096, Ed25519)
- [ ] Manage SSH config files
- [ ] Create and manage users
- [ ] Set file permissions correctly
- [ ] Debug SSH connection failures
- [ ] Document incidents professionally

## Tools & Commands Reference

```bash
# SSH Key Management
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
ssh-copy-id -i ~/.ssh/id_rsa.pub user@host
ssh-add ~/.ssh/id_rsa
ssh-add -l

# User Management
useradd -m -s /bin/bash username
passwd username
usermod -aG sudo username
userdel -r username
getent passwd

# File Permissions
chmod 600 ~/.ssh/private_key
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys

# SSH Debugging
ssh -vvv user@host
ssh -i ~/.ssh/key user@host -p 2222
ssh -o StrictHostKeyChecking=no user@host

# Server Checks
sudo systemctl status sshd
sudo tail -f /var/log/auth.log
sudo ufw status
sudo cat /etc/ssh/sshd_config
```
📚 CONCEPTS LEARNED
✅ DevOps fundamentals (Dev + Ops collaboration)
✅ SDLC phases (7 steps from planning to maintenance)
✅ Environment types (DEV, SIT, UAT, PROD)
✅ SSH authentication (keys vs passwords)
✅ Server hygiene (security best practices)

🛠️ LABS COMPLETED
✅ Lab 1: SSH key generation & server connection
✅ Lab 2: User creation with sudo setup
✅ ~/ssh/config created for convenience
✅ File permissions verified (600, 700)

🚨 INCIDENTS DEBUGGED
✅ Incident 1: SSH port change (22 → 2222)
✅ Incident 2: Permission denied (wrong file perms)
✅ Incident 3: Key mismatch (wrong user)
✅ All documented with RCA & prevention

📈 IMPROVEMENTS IMPLEMENTED
✅ SSH key rotation strategy (quarterly)
✅ Bastion host / Jump host setup
✅ SSH agent configuration
✅ Advanced sshd_config hardening
✅ SSH monitoring & logging

📱 PORTFOLIO ARTIFACTS
✅ LinkedIn post (with engagement hooks)
✅ GitHub repository (complete documentation)
✅ Incident reports (professional RCA format)
✅ Technical blog ready (optional)

---

**WEEK 1 STATUS: 🎉 COMPLETE & READY FOR WEEK 2**

Next: PHASE 1, WEEK 2 - Linux Filesystem & Commands
```
