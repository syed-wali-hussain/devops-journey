# Week 2: Linux Filesystem & Core Commands

**Status:** ✅ Complete  
**Duration:** 6 hours  
**Topics:** Filesystem, Paths, Permissions, File Operations, Searching  

---

## 📚 What I Learned

### Concepts

1. **Linux Filesystem Hierarchy**
   - `/etc` = Configuration files
   - `/var` = Variable data (logs, databases)
   - `/home` = User directories
   - `/bin` = Core commands
   - `/tmp` = Temporary files (auto-deleted on reboot)

2. **Paths**
   - Absolute: `/home/user/file.txt` (complete path from root)
   - Relative: `documents/file.txt` (relative to current directory)

3. **File Permissions**
   - Format: `rwxrwxrwx` (owner, group, others)
   - Numbers: `7=rwx, 6=rw-, 4=r--, 0=---`
   - Example: `chmod 644 file.txt` (owner: rw, group: r, others: r)

4. **Core Commands**
   - Navigation: `ls, cd, pwd, tree`
   - File ops: `cp, mv, rm, mkdir`
   - Reading: `cat, less, head, tail`
   - Searching: `grep, find, locate`

---

## 🛠️ Labs Completed

### Lab 1: Directory Structure & File Operations

**What I Did:**
```bash
# Created directory structure
mkdir -p ~/devops-project/{config,logs,data,scripts,backup}

# Created config files
cat > config/app.conf << 'EOF'
SERVER_PORT=8080
DATABASE_HOST=localhost
DATABASE_PORT=5432
LOG_LEVEL=INFO
EOF

# Practiced file operations
cp config/app.conf config/app.conf.backup      # Copy
mv logs_archive old_logs                       # Rename/move
rm old_logs                                    # Delete
```

**Result:** ✅ Complete directory structure with files

---

### Lab 2: Searching & Filtering Logs

**What I Did:**
```bash
# Search for specific lines
grep "ERROR" logs/app.log                      # Find errors
grep -n "ERROR" logs/app.log                   # With line numbers
grep -c "ERROR" logs/app.log                   # Count

# Search with context
grep -A 2 "ERROR" logs/app.log                 # Show 2 lines after
grep -B 2 "ERROR" logs/app.log                 # Show 2 lines before

# Find files
find ~/devops-project -name "*.conf"           # Find all .conf files
find ~/devops-project -type f -mtime 0         # Modified today

# View logs
tail -f logs/app.log                           # Live follow (real-time)
tail -f logs/app.log | grep "ERROR"            # Filter in real-time
```

**Result:** ✅ Efficiently searched and filtered log files

---

## 🚨 Incident: App Cannot Find Config File

### Problem
```
Production error: Cannot find config file at /etc/app/app.conf
Dev created the file but app can't find it
```

### Root Cause
Path mismatch:
- File location: `/home/azureuser/devops-project/config/app.conf`
- App expects: `/etc/app/app.conf`

### Troubleshooting Approach
```bash
# 1. Check if file exists
ls -la /etc/app/app.conf                       # Not found!

# 2. Find where it actually is
find / -name "app.conf" 2>/dev/null            # Found at /home/...

# 3. Check what app logs say
cat logs/app.log | grep "config"               # Shows expected path

# 4. Mismatch identified!
# Expected: /etc/app/app.conf
# Actual: /home/azureuser/devops-project/config/app.conf
```

### Solution
```bash
# Create /etc/app directory
sudo mkdir -p /etc/app

# Copy config to correct location
sudo cp ~/devops-project/config/app.conf /etc/app/

# Verify
sudo ls -la /etc/app/app.conf                  # Now it exists!

# Restart app
sudo systemctl restart myapp

# Check logs
tail logs/app.log | grep "config"              # Shows SUCCESS
```

### Key Learning
1. **Path matters** - same file in wrong location = broken app
2. **Linux convention** - configs go in `/etc/` directory
3. **Environment variables > hardcoded paths** - flexible and safe
4. **Always verify** - check files exist before running app

### Prevention
- Use environment variables for paths (not hardcoded)
- Document where config files should be
- Test in staging environment first
- Add startup checks (fail if config missing)

---

## 💡 Key Takeaways

**Technical Skills:**
- ✅ Navigate filesystem efficiently
- ✅ Manage files and directories
- ✅ Search and filter log files
- ✅ Set proper permissions
- ✅ Find files quickly

**Soft Skills:**
- ✅ Systematic troubleshooting
- ✅ Understanding Linux conventions
- ✅ Path management

**Key Insight:**
80% of Linux admin work = finding files, reading logs, managing permissions
These fundamentals are foundation for everything else

---

## 🔑 Commands Reference

### Navigation
```bash
pwd                         # Current directory
cd /path                    # Go to path (absolute)
cd folder                   # Go to folder (relative)
cd ..                       # Go to parent
cd ~                        # Go to home
ls -la                      # List with details
tree                        # Visual directory tree
```

### File Operations
```bash
cp file1 file2              # Copy
cp -r folder1 folder2       # Copy folder (recursive)
mv file1 /path/             # Move
mv oldname newname          # Rename
rm file                     # Delete (careful!)
rm -r folder                # Delete folder
mkdir folder                # Create directory
mkdir -p folder/subfolder   # Create with parents
```

### Reading Files
```bash
cat file                    # Show entire file
less file                   # View with pagination
head -20 file               # First 20 lines
tail -20 file               # Last 20 lines
tail -f file                # Follow (live update)
```

### Searching
```bash
grep "text" file            # Find lines with text
grep -n "text" file         # With line numbers
grep -i "TEXT" file         # Case insensitive
grep -A 2 "text" file       # Show 2 lines after
find /path -name "*.txt"    # Find files by name
find /path -type f -size +1k # Find large files
```

### Permissions
```bash
chmod 644 file              # rw-r--r-- (standard file)
chmod 755 script            # rwxr-xr-x (executable)
chmod 600 secret            # rw------- (secure)
chmod -R 755 folder         # Recursive
```

---

## 📁 Repository Structure

```
Week-2-Filesystem/
├── README.md (this file)
├── CONCEPTS.md (detailed theory)
├── LAB-1-DIRECTORY-STRUCTURE.md
├── LAB-2-SEARCHING-LOGS.md
├── INCIDENT-CONFIG-FILE-PATH.md
└── scripts/
    └── file-operations-practice.sh
```

---

## ✅ What I Can Do Now

- ✅ Navigate Linux filesystem confidently
- ✅ Create and manage directory structures
- ✅ Copy, move, delete files efficiently
- ✅ Set correct file permissions
- ✅ Search files and filter logs
- ✅ Diagnose path-related issues
- ✅ Understand Linux directory conventions

---

## 🔄 Reflection

**What Went Well:**
- Hands-on labs made concepts clear
- Incident forced practical application
- Grep power was eye-opening

**Challenging Part:**
- Understanding permission numbers (4, 2, 1)
- When to use absolute vs relative paths

**Next Week:**
Week 3: Package Management & System Administration

---

**Week 2 Complete!** 🚀
