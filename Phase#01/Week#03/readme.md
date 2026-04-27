# Week 3 – Users, Permissions & Ownership

## 🎯 Objective
To understand Linux users, groups, file permissions, and secure access control for services.

---

## 🛠️ Tasks Performed
- Created service user (appuser)
- Created log directory
- Assigned ownership using chown
- Set permissions using chmod
- Tested file access as service user

---

## 💻 Commands Used

### User Management
sudo adduser appuser

### Ownership
sudo chown appuser:appuser /var/log/myapp

### Permissions
chmod 755 /var/log/myapp

### Check Permissions
ls -l
ls -ld

---

## 🚨 Incident Simulation

### Issue:
Application unable to write logs due to permission denied error.

### Troubleshooting:
1. Checked directory ownership
2. Verified permissions
3. Switched to service user for testing

### Resolution:
Assigned correct ownership and permissions using chown and chmod.

---

## 📚 Key Learnings
- Importance of least privilege access
- Avoid using chmod 777 in production
- Services should run with dedicated users
- Proper ownership is critical for application functionality

