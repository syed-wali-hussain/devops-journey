# Week 5 – Logs, Disk Management & Networking Basics

## 🎯 Objective
To understand system logs, disk usage, inode awareness, and basic networking troubleshooting in Linux.

---

## 📚 Key Concepts

### 📜 Logs (/var/log)
Linux systems store logs in `/var/log`, which help in debugging issues.

Common logs:
- /var/log/syslog → system logs  
- /var/log/auth.log → authentication logs  

Logs are the first place to check when troubleshooting failures.

---

### 🧠 journald
Modern Linux systems use journald to manage logs.

Useful commands:
journalctl  
journalctl -xe  
journalctl -u <service>  

It helps in analyzing service-level issues.

---

### 🔄 Log Rotation
Logs continuously grow and can fill disk space.  
Log rotation ensures old logs are compressed or removed automatically.

---

### 💾 Disk Usage (df, du)

df -h → shows overall disk usage  
du -h → shows directory-wise usage  

These tools help identify storage issues.

---

### ⚠️ Inode Awareness

Each file consumes an inode.  
Even if disk space is available, the system can fail if inodes are exhausted.

Check using:
df -i  

---

### 🌐 Networking Basics

- IP → identifies a machine  
- DNS → resolves domain to IP  
- HTTP → communication protocol  

Useful tools:
ping → check connectivity  
curl → check server/API response  

---

### ☁️ Cloud Networking (Intro)
- VPC/VNet → isolated cloud network  
- Subnets → segmented network  

Used to isolate and secure applications in cloud environments.

---

## 🛠️ Tasks Performed
- Analyzed system logs in /var/log
- Used journalctl for service debugging
- Checked disk usage using df and du
- Practiced inode checks
- Tested network connectivity using ping and curl
- Simulated disk full scenario

---

## 💻 Commands Used

### Logs
journalctl  
grep -i error /var/log/syslog  

### Disk
df -h  
du -h --max-depth=1  
df -i  

### Networking
ping  
curl  

---

## 🚨 Incident Simulation

### Issue:
Service failure due to disk full.

### Troubleshooting:
1. Checked disk usage using df -h  
2. Identified large directories using du -h --max-depth=1 /
3. Analyzed logs for errors grep -i error /var/log/syslog
4. Checked inode usage 
5. Cleaned unnecessary files  

### Resolution:
Freed disk space and restored service successfully.

---

## 📚 Key Learnings
- Logs are essential for debugging system issues  
- Disk space and inode usage both matter  
- Log rotation prevents storage issues  
- Networking tools help verify system connectivity  
- Safe cleanup is critical in production  

