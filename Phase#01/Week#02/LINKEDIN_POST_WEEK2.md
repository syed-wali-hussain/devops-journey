# WEEK 2 LINKEDIN POST

---

## 📱 LinkedIn Post - Week 2

```
My app crashed because of a simple path mistake... and it taught me why Linux 
organization matters.

Week 2 of DevOps bootcamp: Linux Filesystem Fundamentals

Here's what happened:

PRODUCTION INCIDENT:
App startup failed with: "Cannot find config file at /etc/app/app.conf"
Dev said: "But I created the file!"
Me: [sweating] Let me investigate...

🔍 TROUBLESHOOTING:

Step 1: Check if file exists
❌ ls -la /etc/app/app.conf → Not found

Step 2: Find where it actually is  
✅ find / -name "app.conf" → Found at /home/user/devops-project/config/app.conf

Step 3: Check what app expects
✅ tail -f app.log → Looking for /etc/app/app.conf

ROOT CAUSE FOUND:
Path Mismatch!
- File is at: /home/user/devops-project/config/app.conf
- App expects: /etc/app/app.conf
- They don't match = app can't find it

SOLUTION:
✅ Created /etc/app directory
✅ Copied config to correct location
✅ Restarted app
✅ Success!

💡 WHAT I LEARNED THIS WEEK:

1. **Linux Filesystem Has Conventions**
   - /etc = Configuration files
   - /var = Logs and databases  
   - /home = User data
   - /bin = Commands
   - Follow conventions = less confusion

2. **File Paths Matter**
   - Absolute path: /home/user/file (complete from root)
   - Relative path: ./file (from current location)
   - Same file, different paths = can break apps

3. **Core Commands Are Foundation**
   - ls = list files
   - grep = search logs
   - find = locate files
   - tail -f = monitor logs in real-time
   - Mastering these = 80% of Linux admin work

4. **Permissions Are Security**
   - 600 = owner only (secure)
   - 644 = owner rw, group r, others r
   - 755 = owner rwx, group rx, others rx
   - Wrong permissions = broken apps or security holes

5. **Log Files Tell The Truth**
   - grep "ERROR" app.log → Find problems
   - tail -f app.log → Monitor in real-time
   - Always check logs first

KEY INSIGHT:
Most "mysterious" bugs = wrong file path, wrong permissions, or outdated logs
Systematic troubleshooting beats random guessing

WEEK 2 STATS:
✅ 2 complete labs
✅ 1 real production incident solved
✅ 5 core concepts mastered
✅ 15+ critical commands learned

Full documentation (concepts, labs, incident analysis):
https://github.com/yourusername/devops-week-2

Week 3 coming: Package Management & System Administration

#DevOps #Linux #SystemAdministration #Learning #Troubleshooting
```

---

## How to Use This Post

1. **Copy the text above**
2. **Replace:** `https://github.com/yourusername/devops-week-2` with your actual GitHub repo link
3. **Optional:** Add image
   - Screenshot of your GitHub repo
   - Terminal screenshot showing grep output
   - Directory structure visualization
4. **Post on LinkedIn**
5. **Done!** 🎉
