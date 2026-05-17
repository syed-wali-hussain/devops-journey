# Week 3: Users, Groups & File Ownership

**Status:** ✅ Complete  
**Duration:** 6 hours  
**Topics:** User Management, Groups, Permissions, Service Users

---

## 📚 What I Learned

### Concepts

1. **Users & Groups**
   - Root user (UID 0) = all permissions
   - Service users (UID < 1000) = run apps (no login)
   - Regular users (UID >= 1000) = people (can login)
   - Groups = collection of users with shared permissions

2. **chown (Change Owner)**
   - `sudo chown username file` → change owner
   - `sudo chown username:groupname file` → change owner and group
   - `sudo chown -R user:group /folder` → recursive (all contents)

3. **chmod (Change Permissions)**
   - `644` = rw-r--r-- (readable by all, writable by owner)
   - `755` = rwxr-xr-x (directories, executable by all)
   - `640` = rw-r----- (log files, readable by group)
   - `600` = rw------- (secrets, owner only)

4. **umask (Default Permissions)**
   - `umask 0022` → new files: 644, new dirs: 755
   - `umask 0077` → new files: 600, new dirs: 700 (very secure)

5. **Service Users**
   - Run applications (not people)
   - Cannot login (no password, /bin/false shell)
   - Own app data and logs
   - Better security (isolate app from system)

---

## 🛠️ Labs Completed

### Lab 1: Service User & Directory Setup

**What I Did:**
```bash
# Created service user
sudo useradd -r -s /bin/false -m -d /var/lib/myapp myapp

# Created directory structure
sudo mkdir -p /var/lib/myapp/{data,cache}
sudo mkdir -p /var/log/myapp
sudo mkdir -p /etc/myapp

# Set ownership
sudo chown -R root:myapp /etc/myapp
sudo chown -R myapp:myapp /var/lib/myapp
sudo chown -R myapp:myapp /var/log/myapp

# Set permissions
sudo chmod -R 750 /etc/myapp
sudo chmod -R 750 /var/lib/myapp
sudo chmod -R 750 /var/log/myapp
```

**Verified:**
- ✅ Service user cannot login
- ✅ Ownership correctly assigned
- ✅ Permissions properly set
- ✅ App can read/write to own directories
- ✅ Cannot modify config files (security)

---

### Lab 2: Permission Testing

**What I Did:**
```bash
# Created test file as service user
sudo -u myapp touch /var/lib/myapp/testfile.txt

# Verified file owned by correct user
ls -la /var/lib/myapp/testfile.txt
# Output: -rw-r----- myapp myapp testfile.txt

# Tested write access (should succeed)
sudo -u myapp echo "test" >> /var/log/myapp/app.log
# ✅ Worked!

# Tested cannot modify config (should fail)
sudo -u myapp echo "test" >> /etc/myapp/app.conf
# ❌ Permission denied (expected, good security!)
```

**Result:** ✅ Permissions working as designed

---

## 🚨 Incident: Permission Denied Writing Logs

### Problem
```
Application error: Permission denied while writing to /var/log/myapp/app.log
App crashed because it cannot write logs
```

### Root Cause
Log file owned by root (incorrect):
- File owner: root
- File group: root
- File permissions: 640 (rw-r-----)
- App running as: myapp user
- Result: myapp cannot write (not owner, not in group)

### Troubleshooting Approach
```bash
# 1. Check file ownership
ls -la /var/log/myapp/app.log
# -rw-r----- root root app.log ← WRONG!

# 2. Check who app is running as
ps aux | grep myapp
# myapp 12345 ... /usr/bin/myapp ← Runs as myapp

# 3. Check file permissions
stat /var/log/myapp/app.log | grep Uid
# Uid: ( 0/ root) ← Not myapp!

# CAUSE FOUND: File owned by root, app is myapp
```

### Solution
```bash
# Change file ownership to myapp
sudo chown myapp:myapp /var/log/myapp/app.log

# Verify
ls -la /var/log/myapp/app.log
# -rw-r----- myapp myapp app.log ← CORRECT!

# Test write access
sudo -u myapp bash -c 'echo "test" >> /var/log/myapp/app.log'
# ✅ Success!

# Restart app
sudo systemctl restart myapp
# ✅ No more permission errors
```

### Key Learning
1. **Service user must own its files** → can read/write
2. **Root owns config files** → prevents app modification
3. **Group permissions** → allow monitoring tools to read logs
4. **Correct setup prevents crashes** → security + reliability

### Prevention
- Create log files with correct owner from start
- Use logrotate with `create 0640 myapp myapp`
- Test app can write before deploying
- Audit permissions regularly

---

## 💡 Permission Matrix (Quick Reference)

| Path | Owner | Group | Perms | Reason |
|------|-------|-------|-------|--------|
| `/etc/myapp` | root | myapp | 750 | Config, root only modifies |
| `/var/lib/myapp` | myapp | myapp | 750 | App data, app can read/write |
| `/var/log/myapp` | myapp | myapp | 750 | Logs, app can write |
| `~/.ssh/id_rsa` | user | user | 600 | Private key, owner only |
| `/usr/local/bin/script` | root | root | 755 | Executable, anyone can run |

---

## 🔑 Commands Reference

### User Management
```bash
sudo useradd -r -s /bin/false -m username       # Service user
sudo usermod -aG groupname username             # Add to group
id username                                     # Check user info
groups username                                 # List user's groups
cat /etc/passwd | grep username                 # Check user exists
```

### Ownership (chown)
```bash
sudo chown username file                        # Change owner
sudo chown :groupname file                      # Change group only
sudo chown username:groupname file              # Change both
sudo chown -R username:groupname /folder        # Recursive
```

### Permissions (chmod)
```bash
chmod 644 file                                  # rw-r--r--
chmod 755 directory                             # rwxr-xr-x
chmod 640 logs                                  # rw-r-----
chmod 600 secrets                               # rw-------
chmod -R 755 /folder                            # Recursive
```

### Verification
```bash
ls -la /path                                    # See owner/perms
stat /path                                      # Detailed info
ps aux | grep appname                           # Check running user
```

---

## ✅ What I Can Do Now

- ✅ Create service users (non-login accounts)
- ✅ Manage users and groups
- ✅ Set correct file ownership with chown
- ✅ Set secure permissions with chmod
- ✅ Understand umask and default permissions
- ✅ Fix permission denied errors
- ✅ Design secure service deployments
- ✅ Audit file ownership and permissions

---

## 🔄 Reflection

**What Went Well:**
- Lab 1 was clear, hands-on practice
- Incident was realistic and taught debugging
- Permission matrix is useful reference

**What Was Challenging:**
- Understanding why each permission matters
- Debugging ownership vs permissions separately

**Key Insight:**
Most "Permission denied" errors = wrong owner/permissions
Systematic checking (owner → group → perms) always finds issue

**Next Week:**
Week 4: Package Management & System Updates

---

**Week 3 Complete!** 🚀
