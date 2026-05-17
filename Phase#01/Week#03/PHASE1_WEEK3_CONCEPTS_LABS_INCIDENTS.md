# PHASE 1 - WEEK 3: Users, Groups & File Ownership
## Permissions, Ownership, and Service Management

---

# 📚 CONCEPTS (To The Point)

## Users & Groups

```
USERS: Individual accounts (login accounts)
- Root user (UID 0) - has all permissions
- Service users - run applications (no login shell)
- Regular users - normal people (login shell)

GROUPS: Collection of users
- sudo group - users who can use sudo
- www-data group - web server group
- docker group - docker users
- Custom groups - application-specific
```

### User Management

```bash
# Create user
sudo useradd -m -s /bin/bash username    # Regular user with home dir
sudo useradd -r -s /bin/false appuser   # Service user (no login)
  -r = system user (UID < 1000)
  -s /bin/false = cannot login

# Create group
sudo groupadd appgroup

# Add user to group
sudo usermod -aG groupname username
  -a = append (don't remove from other groups)
  -G = groups

# View users
cat /etc/passwd | grep username

# View groups
cat /etc/group | grep groupname
```

---

## Ownership: chown (Change Owner)

```bash
# Change file owner
sudo chown username file.txt

# Change file owner AND group
sudo chown username:groupname file.txt

# Change only group
sudo chown :groupname file.txt

# Recursive (all files in folder)
sudo chown -R username:groupname /path/to/folder

# Example:
sudo chown appuser:appgroup /var/log/myapp
sudo chown -R appuser:appgroup /var/lib/myapp
```

---

## Permissions: chmod (Change Mode)

```
Format: rwx rwx rwx
        ^^^ ^^^ ^^^
        own grp oth

r (read)    = 4
w (write)   = 2
x (execute) = 1

COMMON PERMISSIONS:
644 = rw-r--r--    (files: owner rw, others read)
755 = rwxr-xr-x    (directories: owner rwx, others rx)
700 = rwx------    (sensitive: owner only)
600 = rw-------    (very sensitive: owner only)
```

### chmod Examples

```bash
# File: readable by all, writable by owner only
chmod 644 file.txt

# Directory: owner can do everything, group and others can enter/list
chmod 755 /directory

# Log file: owner can read/write, group can read, others nothing
chmod 640 /var/log/app.log

# Private key: owner only
chmod 600 ~/.ssh/id_rsa

# Executable script: owner and group can execute
chmod 755 /usr/local/bin/script.sh
```

---

## umask (Default Permissions)

```
umask = "what NOT to give by default"

Default umask = 0022
└─ Means: don't give write to group/others

New file created:
666 (base) - 022 (umask) = 644 (rw-r--r--)

New directory created:
777 (base) - 022 (umask) = 755 (rwxr-xr-x)

Secure umask (for service):
umask 0077
└─ New files: 644 - 077 = 600 (owner only)
└─ New dirs: 755 - 077 = 700 (owner only)
```

### Set umask

```bash
# Temporary (current session only)
umask 0077

# Permanent (in ~/.bashrc)
echo "umask 0077" >> ~/.bashrc
source ~/.bashrc

# Verify
umask
# Output: 0077
```

---

## Service Users (Best Practice)

```
Regular user (for people):
├─ UID >= 1000
├─ Has home directory
├─ Has login shell (/bin/bash)
├─ Has password
└─ Can SSH/login

Service user (for apps):
├─ UID < 1000
├─ No home directory (or /var/lib/appname)
├─ No login shell (/bin/false)
├─ No password (cannot login)
└─ Runs application only
```

### Why Service Users?

```
Better security:
- If app is hacked, attacker can only access that app's files
- Cannot spread to other users' data
- Cannot login to system

Example:
nginx user → only controls /var/www, /var/log/nginx
mysql user → only controls /var/lib/mysql, /var/log/mysql
App cannot access /root or other users' home directories
```

---

## Ownership Best Practice

```
WHO OWNS WHAT:

Application code:
└─ Owner: root, Group: appgroup, Perms: 755
└─ Only root can modify code (prevent hackers changing it)

Application data:
└─ Owner: appuser, Group: appgroup, Perms: 750
└─ App can read/write, group can read, others nothing

Log files:
└─ Owner: appuser, Group: appgroup, Perms: 640
└─ Only appuser and group can read (contain sensitive info)

Configuration (with passwords):
└─ Owner: root, Group: appgroup, Perms: 640
└─ Only root and group can read (contain secrets)

Configuration (public):
└─ Owner: root, Group: appgroup, Perms: 644
└─ Anyone can read (no secrets)
```

---

# 🛠️ LABS + INCIDENTS

## LAB: Service User & Directory Ownership (2 Hours)

### Step 1: Create Service User

```bash
# Create service user (cannot login)
sudo useradd -r -s /bin/false -m -d /var/lib/myapp myapp

# Verify
id myapp
# Output:
# uid=999(myapp) gid=999(myapp) groups=999(myapp)

# Check cannot login
sudo su - myapp
# Output: This account is currently not available.
```

### Step 2: Create Directory Structure

```bash
# Create directories for app
sudo mkdir -p /var/lib/myapp/{data,cache}
sudo mkdir -p /var/log/myapp
sudo mkdir -p /etc/myapp

# Create config file
sudo cat > /etc/myapp/app.conf << 'EOF'
APP_NAME=myapp
APP_PORT=8080
DATABASE_HOST=localhost
DATABASE_USER=appdb
DATABASE_PASS=secret123
EOF

# Create sample log
sudo cat > /var/log/myapp/app.log << 'EOF'
2024-12-20 10:00:00 INFO Starting application
2024-12-20 10:00:01 INFO Loading configuration
2024-12-20 10:00:02 ERROR Could not write to /var/log/myapp/app.log - Permission denied
EOF
```

### Step 3: Set Ownership

```bash
# Application code directory (root owns, cannot modify by app)
sudo chown -R root:myapp /etc/myapp
sudo chmod -R 750 /etc/myapp

# Data directory (app owns and can read/write)
sudo chown -R myapp:myapp /var/lib/myapp
sudo chmod -R 750 /var/lib/myapp

# Log directory (app can write, group can read)
sudo chown -R myapp:myapp /var/log/myapp
sudo chmod -R 750 /var/log/myapp
```

### Step 4: Verify Setup

```bash
# Check permissions
ls -la /etc/myapp/
# Output:
# drwxr-x--- root myapp /etc/myapp
# -rw-r----- root myapp app.conf

ls -la /var/lib/myapp/
# Output:
# drwxr-x--- myapp myapp /var/lib/myapp
# drwxr-x--- myapp myapp data

ls -la /var/log/myapp/
# Output:
# drwxr-x--- myapp myapp /var/log/myapp
# -rw-r----- myapp myapp app.log

# Verify user cannot login
sudo su - myapp
# Should fail: This account is currently not available.
```

### Step 5: Test Permissions (Hands-On)

```bash
# As myapp user (simulation)
# Create file in myapp's directory
sudo -u myapp touch /var/lib/myapp/testfile.txt

# Check who owns it
ls -la /var/lib/myapp/testfile.txt
# Output: -rw-r----- myapp myapp testfile.txt

# Try to write to log as myapp
sudo -u myapp echo "test" >> /var/log/myapp/app.log
# Should succeed

# Try to write to config as myapp
sudo -u myapp echo "test" >> /etc/myapp/app.conf
# Should FAIL: Permission denied (good security!)
```

---

## INCIDENT: Permission Denied Writing Logs

### Scenario

```
Production Alert:
Application crashed!
Error: Permission denied while writing to /var/log/myapp/app.log

Logs are full of this error.
Users are complaining.
Your job: Fix it in 30 minutes!
```

### Problem Analysis

```bash
# Check current permissions
ls -la /var/log/myapp/app.log

# Output:
# -rw-r----- root root app.log
#  ^^^ ^ ^^^
#  |   |   └─ Others: read only
#  |   └───── Group: read only
#  └───────── Owner: read + write

# Who owns the file?
stat /var/log/myapp/app.log | grep "Uid\|Gid"
# Output:
# Uid: ( 0/ root)
# Gid: ( 0/ root)

# Who is the app running as?
ps aux | grep myapp
# Output:
# myapp 12345 ... /usr/bin/myapp
#  ^^^^
#  App runs as 'myapp' user

# PROBLEM FOUND:
# File owner: root (cannot write)
# File group: root (app is in myapp group, cannot write)
# File perms: 640 (owner: rw, group: r, others: nothing)
# App user: myapp (not root, not in root group)
# Result: myapp cannot write!
```

### Solution

```bash
# Option 1: Change owner to myapp (CORRECT)
sudo chown myapp:myapp /var/log/myapp/app.log

# Option 2: Make group writable
sudo chown root:myapp /var/log/myapp/app.log
sudo chmod 660 /var/log/myapp/app.log

# Verify fix
ls -la /var/log/myapp/app.log
# Output should be:
# -rw-rw---- myapp myapp app.log
# Now myapp can write!
```

### Test Fix

```bash
# Try to write as myapp user
sudo -u myapp bash -c 'echo "Testing write access" >> /var/log/myapp/app.log'

# Check if it worked
tail /var/log/myapp/app.log
# Output:
# 2024-12-20 10:00:02 ERROR Could not write...
# Testing write access  ← This should appear!

# Restart app
sudo systemctl restart myapp

# Check logs - should be clean
sudo tail -f /var/log/myapp/app.log
# Should NOT show permission errors anymore
```

### Root Cause Analysis

```
PROBLEM: Application cannot write to log file

ROOT CAUSE:
Log file owned by: root (correct for security)
Log directory owned by: root (incorrect, should be myapp)
App running as: myapp user
App in groups: myapp group only

When app tries to write:
1. Check if owner of file: NO (owner is root)
2. Check if in file's group: NO (group is root, app is in myapp)
3. Check if others can write: NO (640 permissions)
4. Result: Permission denied!

SOLUTION:
Change ownership so myapp user can write:
sudo chown myapp:myapp /var/log/myapp/app.log

OR allow myapp group to write:
sudo chmod 660 /var/log/myapp/app.log

PREVENTION:
1. Set correct ownership when creating log files
2. Use log rotation (logrotate) with correct permissions
3. Create directories with correct owner first
4. Test app can write before deploying
```

### Prevention (Best Practice)

```bash
# Automated log directory setup:
cat > /etc/logrotate.d/myapp << 'EOF'
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    notifempty
    create 0640 myapp myapp      # Create with correct owner/group/perms
    sharedscripts
    postrotate
        /bin/systemctl reload myapp > /dev/null 2>&1 || true
    endscript
}
EOF

# Test setup
sudo logrotate -f /etc/logrotate.d/myapp

# Verify
ls -la /var/log/myapp/
# Should show correct ownership and permissions
```

---

# 💡 IMPROVEMENTS & BEST PRACTICES

## 1. umask for Security

```bash
# For service accounts (very restrictive)
cat >> /etc/default/myapp << 'EOF'
# Set restrictive umask so new files are only readable by owner
umask 0077
EOF

# Now new files created by app:
# 666 - 077 = 600 (owner only, no world read!)
# 777 - 077 = 700 (directory: owner only)
```

## 2. Directory Permissions for Services

```bash
# Configuration directory (secrets, passwords)
sudo chmod 750 /etc/myapp          # rwxr-x---
# Root: full access, Group: read+execute, Others: nothing

# Data directory (app data)
sudo chmod 750 /var/lib/myapp      # rwxr-x---
# App can read/write/execute, group can read, others: nothing

# Log directory (readable by group for monitoring)
sudo chmod 750 /var/log/myapp      # rwxr-x---
# App can write, group can read (for log aggregation)
```

## 3. Supplementary Groups

```bash
# Add service user to multiple groups
sudo usermod -aG docker myapp          # Access docker
sudo usermod -aG adm myapp             # Read system logs
sudo usermod -aG www-data myapp        # Share files with web server

# Verify
groups myapp
# Output: myapp docker adm www-data
```

## 4. Shared Directories (Multiple Services)

```bash
# Create shared directory
sudo mkdir /var/lib/shared_app_data
sudo chown root:appgroup /var/lib/shared_app_data
sudo chmod 770 /var/lib/shared_app_data
# Only appgroup members can access

# Both services can write:
sudo usermod -aG appgroup service1
sudo usermod -aG appgroup service2

# Now both can read/write shared files
```

## 5. Audit Permissions

```bash
# Script to check service user permissions
cat > check_app_perms.sh << 'EOF'
#!/bin/bash
echo "=== Checking myapp permissions ==="
echo "User myapp owns:"
find /etc/myapp /var/lib/myapp /var/log/myapp -user myapp

echo "Group myapp owns:"
find /etc/myapp /var/lib/myapp /var/log/myapp -group myapp

echo "Permissions:"
ls -lR /etc/myapp
ls -lR /var/lib/myapp
ls -lR /var/log/myapp
EOF

chmod +x check_app_perms.sh
./check_app_perms.sh
```

---

# ✅ WEEK 3 SUMMARY

**Concepts:**
- ✅ Users vs Groups
- ✅ chown (change owner)
- ✅ chmod (change permissions)
- ✅ umask (default permissions)
- ✅ Service users (best practice)

**Lab:**
- ✅ Created service user
- ✅ Set directory structure
- ✅ Assigned correct ownership
- ✅ Set secure permissions
- ✅ Tested access

**Incident:**
- ✅ App cannot write logs
- ✅ Diagnosed permission issue
- ✅ Fixed by changing ownership
- ✅ Documented prevention

**Key Insight:**
Wrong permissions = "Permission denied" errors
Service users = better security
Ownership + permissions = foundation of Linux security
