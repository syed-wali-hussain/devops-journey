# PHASE 1 - WEEK 2: Linux Filesystem & Core Commands
## Concepts + Labs + Incidents

---

# 📚 CONCEPTS (To The Point)

## Linux Filesystem Structure

```
/ (Root - sabkuch yahan se shuru)
├── /bin          Commands jo sabko chahiye (ls, cp, mv)
├── /etc          Configuration files (important!)
├── /home         Users ke folders (aapka data yahan)
├── /var          Variable data - logs, temp, databases
├── /tmp          Temporary files (restart par delete ho jayegi)
├── /root         Root user ka home
├── /usr          User programs and libraries
├── /lib          System libraries
└── /opt          Optional software
```

**Important:** `/etc` = config, `/var` = logs, `/home` = your data

---

## Paths: Absolute vs Relative

```
ABSOLUTE PATH (poori rasta likho)
/home/azureuser/documents/file.txt
└─ Sab jagah same result

RELATIVE PATH (current folder se relative)
documents/file.txt
└─ Depends kahan ho
```

### Navigation

```bash
pwd                 # Where are you? (print working directory)
cd /home            # Go to /home (absolute)
cd documents        # Go to documents (relative to current)
cd ..               # Go to parent directory
cd ~                # Go to home directory
cd -                # Go to previous directory
```

---

## File Permissions: rwx (Read, Write, Execute)

```
-rw-r--r--  1  user  group  1024  Dec 19 10:30  file.txt
^           ^  ^     ^      ^
|           |  |     |      └─ File size
|           |  |     └────── Group
|           |  └─────────── Owner
|           └───────────── Hard links
└──────────────────────── Permissions

Permissions: rwx rwx rwx
             ^^^ ^^^ ^^^
             |   |   └─ Others
             |   └───── Group
             └───────── Owner

r = Read (4)     w = Write (2)     x = Execute (1)

rw- = 6 (read+write)
r-- = 4 (read only)
rwx = 7 (everything)
---= 0 (nothing)
```

### Example: chmod (Change permissions)

```bash
chmod 644 file.txt      # Owner: rw, Group: r, Others: r
chmod 755 script.sh     # Owner: rwx, Group: rx, Others: rx
chmod 600 private.key   # Owner: rw only (secure!)
```

---

## Core Commands Explained

### Listing & Navigation

```bash
ls                  # List files
ls -l               # Long format (permissions, size, date)
ls -la              # Include hidden files (starts with .)
ls -lh              # Human readable sizes (1K, 2M, not 1024)

cd /path            # Change directory
pwd                 # Current directory
tree /path          # Visual tree (if installed)
```

### File Operations

```bash
cp file1.txt file2.txt           # Copy
cp -r folder1 folder2            # Copy folder (recursive)

mv file1.txt folder/             # Move/rename
mv oldname.txt newname.txt       # Rename

rm file.txt                      # Delete (careful!)
rm -r folder                     # Delete folder
rm -i file.txt                   # Ask before delete (safe)

mkdir folder                     # Create directory
mkdir -p folder/subfolder        # Create with parents
```

### Reading Files

```bash
cat file.txt                # Show entire file
cat file1.txt file2.txt     # Show both files

less file.txt               # View with pagination (Space = next page, q = quit)
head -20 file.txt           # First 20 lines
tail -20 file.txt           # Last 20 lines
tail -f file.txt            # Follow (live update, useful for logs!)
```

### Searching

```bash
grep "error" file.txt           # Find lines with "error"
grep -i "ERROR" file.txt        # Case insensitive
grep -n "error" file.txt        # Show line numbers
grep "error" *.log              # Search multiple files
grep -r "error" /var/log/       # Search recursively in folder

find /path -name "*.txt"        # Find all .txt files
find /path -type f -name "app"  # Find file named "app"
```

---

# 🛠️ LABS + INCIDENTS (Hands-On)

## LAB 1: Directory Structure & File Operations (1 Hour)

### Setup

```bash
# Create project folder
mkdir -p ~/devops-project
cd ~/devops-project

# Create directory structure
mkdir -p {config,logs,data,scripts,backup}

# Check structure
ls -la
# Output:
# drwxr-xr-x  config
# drwxr-xr-x  logs
# drwxr-xr-x  data
# drwxr-xr-x  scripts
# drwxr-xr-x  backup
```

### Create Files

```bash
# Create config files
cat > config/app.conf << 'EOF'
SERVER_PORT=8080
DATABASE_HOST=localhost
DATABASE_PORT=5432
LOG_LEVEL=INFO
EOF

cat > config/database.conf << 'EOF'
DB_USER=admin
DB_PASS=secret123
DB_NAME=myapp_db
EOF

# Create sample logs
cat > logs/app.log << 'EOF'
2024-12-19 10:00:00 INFO Starting application
2024-12-19 10:00:01 INFO Connecting to database
2024-12-19 10:00:02 ERROR Connection failed: host not reachable
2024-12-19 10:00:03 ERROR Retrying connection
2024-12-19 10:00:04 INFO Connection successful
2024-12-19 10:00:05 INFO Loading config from /etc/app/app.conf
2024-12-19 10:00:06 WARNING Config file not found
2024-12-19 10:00:07 INFO Application ready on port 8080
EOF

# Create sample data
echo "user1,2024-01-01,active" > data/users.csv
echo "user2,2024-01-02,inactive" >> data/users.csv
echo "user3,2024-01-03,active" >> data/users.csv

# Create script
cat > scripts/backup.sh << 'EOF'
#!/bin/bash
echo "Backing up data..."
cp -r ../data ../backup/data_backup_$(date +%s)
echo "Backup complete!"
EOF

chmod +x scripts/backup.sh
```

### Practice File Operations

```bash
# List with details
ls -lh config/
ls -la logs/

# Copy files
cp config/app.conf config/app.conf.backup
cp -r logs logs_archive

# Move files
mv logs_archive old_logs
mv old_logs logs_old

# View file contents
cat config/app.conf
less logs/app.log          # Press 'q' to quit

# Check file sizes
ls -lh config/

# Verify structure
tree ~/devops-project
# or
find ~/devops-project -type f
```

---

## LAB 2: Searching & Filtering Logs (1 Hour)

### Search with grep

```bash
# Find error messages
grep "ERROR" logs/app.log

# Output:
# 2024-12-19 10:00:02 ERROR Connection failed: host not reachable
# 2024-12-19 10:00:03 ERROR Retrying connection
```

### Advanced grep

```bash
# Show line numbers
grep -n "ERROR" logs/app.log

# Output:
# 3:2024-12-19 10:00:02 ERROR Connection failed: host not reachable
# 4:2024-12-19 10:00:03 ERROR Retrying connection

# Count matches
grep -c "ERROR" logs/app.log
# Output: 2

# Case insensitive
grep -i "error" logs/app.log

# Show context (lines before/after)
grep -A 2 "ERROR" logs/app.log          # 2 lines after
grep -B 2 "ERROR" logs/app.log          # 2 lines before
grep -C 2 "ERROR" logs/app.log          # 2 lines both sides

# Exclude lines
grep -v "INFO" logs/app.log             # Show non-INFO lines

# Combine conditions
grep "ERROR\|WARNING" logs/app.log      # Show ERROR or WARNING
```

### Find files

```bash
# Find all .conf files
find ~/devops-project -name "*.conf"

# Find files modified today
find ~/devops-project -type f -mtime 0

# Find large files
find ~/devops-project -type f -size +1k

# Find directories
find ~/devops-project -type d
```

### Tail for logs

```bash
# View last 10 lines
tail logs/app.log

# View last 5 lines
tail -5 logs/app.log

# Follow log in real-time (useful for debugging)
tail -f logs/app.log        # Ctrl+C to stop

# Combine with grep
tail -f logs/app.log | grep "ERROR"     # Live ERROR tracking
```

---

## INCIDENT: App Cannot Find Config File

### Scenario

```
Production alert:
Application startup failed!
Error: Cannot find config file at /etc/app/app.conf

Dev message: "But I created the file!"
Your job: Find and fix the issue in 20 minutes
```

### Troubleshooting Steps

#### Step 1: Check File Exists

```bash
# Does file exist at expected location?
ls -la /etc/app/app.conf

# Output:
# ls: cannot access '/etc/app/app.conf': No such file or directory
# ❌ File doesn't exist!

# But developer created it somewhere...
# Find where it actually is
find / -name "app.conf" 2>/dev/null

# Output:
# /home/azureuser/devops-project/config/app.conf
# ✅ Found! But in wrong location
```

#### Step 2: Check What App Expects

```bash
# Check app source code or logs
cat logs/app.log | grep -i "config"

# Output:
# 2024-12-19 10:00:05 INFO Loading config from /etc/app/app.conf
# ➜ App looks for: /etc/app/app.conf
# ➜ File is at: /home/azureuser/devops-project/config/app.conf
# ➜ MISMATCH!
```

#### Step 3: Find Root Cause

```
Possible causes:
1. Wrong path used (most likely)
2. File not copied to production location
3. Permission issues
4. Directory doesn't exist
```

#### Step 4: Solution

**Option A: Move file to correct location**

```bash
# Create /etc/app directory (if doesn't exist)
sudo mkdir -p /etc/app

# Copy config file
sudo cp ~/devops-project/config/app.conf /etc/app/

# Verify
sudo ls -la /etc/app/app.conf

# Restart app
sudo systemctl restart myapp

# Check logs
tail -f logs/app.log
# Should show: INFO Loading config from /etc/app/app.conf ... SUCCESS
```

**Option B: Update app to look in correct location**

```bash
# Edit app configuration to point to actual location
# Config: /home/azureuser/devops-project/config/app.conf

# Check app code
grep "CONFIG_PATH" app.py         # or app.js, etc.

# Update path
# OLD: CONFIG_PATH = "/etc/app/app.conf"
# NEW: CONFIG_PATH = "/home/azureuser/devops-project/config/app.conf"

# Restart
sudo systemctl restart myapp
```

### Root Cause Analysis

```
PROBLEM: App couldn't find config file

ROOT CAUSE:
Path mismatch - file at: /home/azureuser/devops-project/config/app.conf
                app looks: /etc/app/app.conf

CONTRIBUTING FACTORS:
1. No documentation where config should be
2. Path hardcoded in app (bad practice!)
3. No verification before deployment

SOLUTION: 
Move file to standard location (/etc/app/) which is Linux convention

PREVENTION:
1. Use environment variables for paths (not hardcoded)
   CONFIG_PATH = os.getenv('APP_CONFIG', '/etc/app/app.conf')
2. Check file exists before startup
   if not os.path.exists(config_path): exit("Config missing!")
3. Clear documentation where configs should be
4. Test in staging before production
```

### Verification

```bash
# Verify fix
ls -la /etc/app/app.conf

# Check permissions (readable by app user?)
stat /etc/app/app.conf

# Test app
sudo systemctl status myapp

# Check logs for success
tail -20 /var/log/myapp/app.log | grep -i "config"
# Should show: Loading config from /etc/app/app.conf ... SUCCESS
```

---

# 💡 IMPROVEMENTS & BEST PRACTICES

## 1. Directory Naming Conventions

```bash
# Good structure:
/var/log            ← Application logs
/etc/app            ← Configuration files
/var/lib/app        ← Application data
/home/user/backups  ← User backups

# Bad structure:
/data/file1
/configs/something
/logs/app/errors
← Inconsistent, hard to find
```

## 2. Log File Management

```bash
# Create organized logs
mkdir -p /var/log/myapp

# Log rotation (prevent disk full)
cat > /etc/logrotate.d/myapp << 'EOF'
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    notifempty
    create 0640 appuser appgroup
}
EOF

# View real-time logs
tail -f /var/log/myapp/app.log

# Search logs
grep "ERROR" /var/log/myapp/app.log
```

## 3. Secure Permissions for Config Files

```bash
# Config files often have passwords - secure them!
chmod 600 /etc/app/database.conf     # Only owner can read
chmod 640 /etc/app/app.conf          # Owner + group only

# Check permissions
ls -l /etc/app/

# Output:
# -rw-------  database.conf   (owner only - SECURE)
# -rw-r-----  app.conf        (owner + group)
```

## 4. Find vs Locate

```bash
# find = real-time, slower but accurate
find /etc -name "*.conf"

# locate = database, faster but may be outdated
locate app.conf
# Then update database:
sudo updatedb
```

## 5. Wildcards & Patterns

```bash
# Copy all .txt files
cp *.txt backup/

# Copy all files starting with app
cp app* backup/

# Copy all files in multiple directories
cp /etc/app/*.conf /backup/
cp /var/log/app/*.log /backup/

# Search with patterns
grep "ERROR\|FATAL" logs/*.log
```

---

# ✅ WEEK 2 SUMMARY

**Concepts Learned:**
- Linux filesystem hierarchy (/etc, /var, /home, etc.)
- Absolute vs relative paths
- File permissions (rwx, chmod)
- Core commands (ls, cd, cp, mv, rm, cat, grep)

**Labs Completed:**
- Created directory structure
- Practiced file operations (copy, move, delete)
- Searched logs with grep
- Used find for file searching

**Incident Solved:**
- App couldn't find config file
- Diagnosed path mismatch
- Fixed by moving file to correct location
- Documented root cause and prevention

**Key Takeaway:**
80% of Linux admin work is: finding files, reading logs, managing permissions.
Master these fundamentals = become productive fast.
