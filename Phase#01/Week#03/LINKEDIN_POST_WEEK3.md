# WEEK 3 LINKEDIN POST

---

## 📱 LinkedIn Post - Week 3

```
My app crashed at 3 AM because I didn't understand file ownership...
and that's when I realized why Linux users are so particular about permissions.

Week 3 of DevOps bootcamp: Users, Groups & File Ownership

Here's what happened:

🚨 PRODUCTION INCIDENT:
Application error: "Permission denied writing to /var/log/myapp/app.log"
The app couldn't write logs.
Users couldn't use the service.
My job: Fix it in 30 minutes.

🔍 ROOT CAUSE INVESTIGATION:

Step 1: Check file ownership
❌ ls -la /var/log/myapp/app.log
-rw-r----- root root app.log
Owner: root (not myapp!)

Step 2: Check who app runs as
✅ ps aux | grep myapp
myapp 12345 ... /usr/bin/myapp

Step 3: Match them
❌ File owned by: root
✅ App running as: myapp
❌ MISMATCH = Permission denied!

ROOT CAUSE FOUND:
Log file owned by root, app running as myapp user
When app tries to write:
- Is app the owner? NO (root owns it)
- Is app in file's group? NO (group is root)
- Result: Permission denied

✅ SOLUTION:
Changed file ownership to myapp:
sudo chown myapp:myapp /var/log/myapp/app.log

Test write access:
sudo -u myapp bash -c 'echo "test" >> /var/log/myapp/app.log'
✅ Worked!

Restarted app:
✅ No more permission errors

💡 WHAT I LEARNED THIS WEEK:

1. **Everything has an owner in Linux**
   - Files have owner (user) and group
   - App runs as specific user
   - User must own files it needs to modify

2. **Service Users (not people)**
   - Apps run as service users (not root)
   - Service users cannot login
   - They own app data, logs, cache
   - Better security if app is hacked

3. **Permission Model: Owner → Group → Others**
   - Check owner first: "Is this file's owner?"
   - Then check group: "Is user in this file's group?"
   - Then check others: "Can others access?"
   - If all fail: Permission denied

4. **chmod Numbers Make Sense Now**
   - 640 = rw-r----- (owner: read/write, group: read, others: none)
   - Perfect for log files!
   - Service user owns file (can write)
   - Group can read (for monitoring tools)
   - Others cannot see (security)

5. **Permission Denied = Systematic Problem**
   - Check: ls -la (see owner/group/perms)
   - Check: ps aux (see what user runs app)
   - Match them up
   - Fix ownership or permissions
   - Always works!

INCIDENT STATS:
✅ Root cause: Found in 10 minutes
✅ Solution: Applied in 2 minutes
✅ Test: Verified in 3 minutes
✅ Learning: Invaluable

This week taught me that permissions aren't arbitrary.
They're a logical system:
- Owner: Usually root (for security)
- Group: App group (for app to access)
- Perms: 750 means owner full, group read/execute, others nothing

Most production issues = wrong owner or permissions
Fix the ownership = fix the problem

Full week details (concepts, labs, incident analysis):
https://github.com/yourusername/devops-week-3

Week 4 starting: Package Management & System Administration

What's your biggest permission issue story?

#DevOps #Linux #SystemAdministration #Permissions #SysAdmin #Learning
```

---

## How to Use This Post

1. **Copy the text above**
2. **Replace:** `https://github.com/yourusername/devops-week-3` with your actual GitHub repo link
3. **Optional:** Add image
   - Screenshot of permission matrix
   - Terminal showing permission error and fix
   - File ownership diagram
4. **Post on LinkedIn**
5. **Engage:** Reply to comments, share others' permission stories
6. **Done!** 🎉
