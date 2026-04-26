# Week 2 – Linux Filesystem & File Operations

## 🎯 Objective
To understand Linux filesystem structure, file operations, permissions, and basic troubleshooting using logs.

---

## 🛠️ Tasks Performed
- Explored Linux filesystem directories (/etc, /var, /home)
- Practiced absolute and relative paths
- Performed file operations (create, copy, move, delete)
- Worked with file viewing commands (cat, less)
- Searched logs using grep

---

## 💻 Commands Used

### Navigation
pwd  
ls  
cd  

### File Operations
cp file1 file2  
mv file1 file2  
rm file  

### File Viewing
cat file  
less file  

### Search
grep "error" logfile.log  

---

## 🚨 Incident Simulation

### Issue:
Application was unable to locate its configuration file.

### Possible Causes:
- Incorrect file path
- File not present in expected directory
- Permission issues

### 🔍 Troubleshooting Steps:
1. Checked if file exists using:
   ls /etc/app/

2. Searched for file across system:
   find / -name "app.conf"

3. Analyzed logs:
   grep "error" /var/log/app.log

### ✅ Resolution:
Identified incorrect file path and updated configuration. Application started working successfully.

---

## 📚 Key Learnings
- Understanding Linux filesystem is critical for debugging
- Small path errors can break applications
- Logs are essential for troubleshooting
- grep is a powerful tool for log analysis

