# Week 4: Processes & Resource Monitoring

**Status:** ✅ Complete  
**Duration:** 6 hours  
**Topics:** Process Management, CPU/Memory Monitoring, Signals

---

## 📚 What I Learned

### Concepts

1. **Processes**
   - Running program = process with PID (Process ID)
   - Every process has owner (UID), memory usage, CPU usage
   - Parent process (PPID) starts child processes

2. **Process Commands**
   - `ps aux` = List all processes with details
   - `top` = Real-time CPU/memory view
   - `htop` = Better version of top (colorful, easier)
   - `kill PID` = Send signal to process

3. **Signals**
   - SIGTERM (15) = Graceful stop (process can cleanup)
   - SIGKILL (9) = Forceful stop (immediate, no cleanup)
   - Always try SIGTERM first, SIGKILL if necessary
   - Other signals: SIGHUP (reload), SIGSTOP (pause)

4. **Monitoring**
   - %CPU = CPU percentage (max = number of cores × 100%)
   - %MEM = Memory percentage
   - Load Average = System busyness
   - htop shows color-coded usage

5. **Performance**
   - High CPU = Runaway process, infinite loop, or stuck operation
   - High Memory = Memory leak or large data load
   - Load > cores = System overloaded

---

## 🛠️ Labs Completed

### Lab 1: Identify Heavy Process

**Commands Used:**
```bash
# Find top CPU consumers
ps aux | sort -k3 -nr | head -5

# Find top memory consumers
ps aux | sort -k4 -nr | head -5

# Monitor specific process
top -p PID
htop -p PID

# Check process details
ps -p PID -o etime,cmd
```

**Result:** ✅ Can quickly identify resource hogs

---

### Lab 2: Simulate Load & Monitor

**What I Did:**
```bash
# Created test load script
cat > heavy.sh << 'EOF'
#!/bin/bash
while true; do
    echo "Computing..." > /dev/null
done
EOF

chmod +x heavy.sh

# Ran in background
./heavy.sh &

# Monitored with top
top

# Showed ~100% CPU usage
# Killed gracefully
kill PID

# Waited
sleep 5

# Forced if needed
kill -9 PID

# Verified it stopped
ps aux | grep heavy.sh
```

**Result:** ✅ Can control process lifecycle safely

---

## 🚨 Incident: High CPU from Runaway Process

### Problem
```
Alert: Server CPU at 95%
App is slow
Users complaining
```

### Root Cause
Process stuck in infinite loop or long operation using 85% CPU for 2+ hours

### Troubleshooting

**Step 1: Find heavy process**
```bash
ps aux | sort -k3 -nr | head -5
# Found: 85% CPU usage
```

**Step 2: Check how long running**
```bash
ps -p PID -o etime
# Output: 02:30:00 (should be < 5 seconds!)
```

**Step 3: Confirm with top**
```bash
top
# Same process at 85% CPU
```

### Solution

**Step 1: Graceful stop**
```bash
kill PID
sleep 5
```

**Step 2: Check if stopped**
```bash
ps aux | grep PID
```

**Step 3: Force if needed**
```bash
kill -9 PID
```

**Step 4: Restart service**
```bash
sudo systemctl restart myapp
```

**Step 5: Verify normal**
```bash
ps aux | grep myapp
# Now: 2.3% CPU ✅
```

### Key Learning
1. **Always monitor** - find issues early
2. **Graceful stop first** - allows cleanup
3. **Forceful kill if needed** - kill -9 always works
4. **Check before restarting** - verify issue resolved

---

## 💡 Quick Reference

### Commands
```bash
ps aux                      # List all processes
top                         # Real-time view
htop                        # Better top (colorful)
kill PID                    # Graceful stop
kill -9 PID                 # Force stop
killall process_name        # Kill all by name
uptime                      # Load average
free -h                     # Memory status
```

### Sorting
```bash
ps aux | sort -k3 -nr      # Sort by CPU
ps aux | sort -k4 -nr      # Sort by memory
ps -p PID -o etime,cmd      # How long running + command
```

### Monitoring
```bash
top -p PID                  # Monitor specific PID
htop -p PID                 # Better version
ps aux | grep pattern       # Find processes
lsof -p PID                 # Files opened by process
```

---

## ✅ What I Can Do Now

- ✅ Monitor process CPU and memory usage
- ✅ Identify runaway/heavy processes
- ✅ Kill processes gracefully
- ✅ Force kill if needed
- ✅ Understand signals (SIGTERM, SIGKILL)
- ✅ Check system load and performance

---

## 🔄 Reflection

**What Went Well:**
- Labs showed practical usage
- Real incident was educational
- Graceful vs forceful kill was clear

**What Was Challenging:**
- Understanding signals and effects
- Knowing when to use which signal

**Key Insight:**
Performance issues usually = 1 runaway process
Find with: `ps aux | sort -k3 -nr`
Kill with: `kill PID`
Done!

---

**Week 4 Complete!** 🚀
