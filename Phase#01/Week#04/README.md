# Week 4 – Process Management & Monitoring

## 🎯 Objective
To understand Linux processes, resource monitoring, and handling high CPU issues.

---

## 🛠️ Tasks Performed
- Monitored running processes using ps and top
- Simulated high CPU usage
- Identified resource-heavy processes
- Terminated processes safely using kill

---

## 💻 Commands Used

### Process Monitoring
ps aux
top
htop

### Resource Monitoring
free -h

### Process Control
kill -15 PID
kill -9 PID
---

## 🚨 Incident Simulation

### Issue:
High CPU usage due to a runaway process.

### Troubleshooting:
1. Checked CPU usage using top
2. Identified process consuming high CPU
3. Retrieved PID using ps aux
4. Attempted graceful termination

### Resolution:
Process terminated successfully and CPU usage normalized.

---

## 📚 Key Learnings
- Importance of monitoring system resources
- Difference between graceful and force kill
- Identifying runaway processes
- Safe troubleshooting approach in productiony

