# PHASE 1 - WEEK 4: Processes & Resource Monitoring
## CPU, Memory, Signals, and Performance Tuning

---

# 📚 CONCEPTS (To The Point)

## Processes: What Are They?

```
PROCESS = Running program with its own memory, CPU time, files

Example:
ps aux
# Shows all running processes

Output:
USER    PID    %CPU %MEM COMMAND
root    1      0.0  0.1  /sbin/init
root    125    0.2  0.5  /usr/sbin/sshd
user    1234   15.0 8.2  /usr/bin/python app.py
                    ^^   Too much memory!
```

### Process Info

```bash
PID = Process ID (unique number)
UID = User running process
%CPU = CPU percentage using
%MEM = Memory percentage using
PPID = Parent process ID (who started this?)
STAT = State (R=running, S=sleeping, Z=zombie)
```

---

## Monitoring: ps, top, htop

### ps (List Processes)

```bash
ps aux                      # All processes with details
ps aux | grep python        # Find specific process
ps -ef                      # Different format
ps -o pid,user,%cpu,cmd     # Custom columns

Output columns:
USER = who runs it
PID = process number
%CPU = CPU usage
%MEM = memory usage
COMMAND = what is it
```

### top (Real-Time Monitoring)

```bash
top                         # Interactive view
top -b -n 1 | head -20     # One snapshot, 20 lines
top -p 1234                 # Monitor specific PID

Shows:
- Top CPU consumers
- Top memory consumers
- System load
- Free memory

Commands while running top:
q = quit
M = sort by memory
P = sort by CPU
k = kill process
```

### htop (Better top)

```bash
htop                        # Colorful, easier version
htop -p 1234                # Monitor PID 1234

Better than top:
- Color coded
- Shows tree view
- Easier to kill process
- Vertical scroll
```

---

## Signals: kill, SIGTERM, SIGKILL

```
SIGNAL = Message sent to process

Common signals:
SIGTERM (15) = "Please stop gracefully"
              = Process can cleanup, close files
              = Preferred method

SIGKILL (9)  = "Stop NOW, no time to cleanup"
              = Forceful, immediate
              = Last resort (data loss possible)

SIGHUP (1)   = "Reload configuration"
SIGSTOP (19) = "Pause"
SIGCONT (18) = "Resume"
```

### kill Command

```bash
kill PID                    # Send SIGTERM (polite)
kill -9 PID                 # Send SIGKILL (force)
kill -SIGTERM PID           # Explicit SIGTERM
killall process_name        # Kill all by name
pkill -f "python app"       # Kill matching pattern

Example:
ps aux | grep runaway_app
# Shows PID 5678

kill 5678                   # Ask nicely
sleep 2

ps aux | grep 5678
# Still running?

kill -9 5678                # Force it
```

---

## Resource Monitoring: CPU & Memory

### CPU

```
%CPU = How much processor time used
- Single core can be 100%
- Multi-core max is (cores × 100%)
- 4-core = max 400%

High CPU = Bad
- Process using too much
- Infinite loop
- Bad algorithm
- Too many requests

Check:
top                         # See %CPU
ps aux | sort -k3 -nr      # Sort by CPU
```

### Memory

```
%MEM = How much system RAM used
- Single process > 50% = danger
- Usually gradual (memory leak)
- Could be sudden (large data load)

High Memory = Bad
- Process using too much RAM
- Memory leak (keeps growing)
- Not releasing memory
- Can crash system

Check:
top                         # See %MEM
free -h                     # See available memory
ps aux | sort -k4 -nr      # Sort by memory
```

### Load Average

```
Load = How busy system is

Load 1.0 on 4-core = 25% utilized
Load 4.0 on 4-core = 100% utilized
Load 8.0 on 4-core = Overloaded!

Show:
top                         # See "load average: X.X, X.X, X.X"
uptime                      # Quick view
cat /proc/loadavg           # Raw value

1 minute, 5 minute, 15 minute averages
```

---

# 🛠️ LABS + INCIDENTS

## LAB 1: Monitor & Identify Heavy Process (1 Hour)

### Step 1: View All Processes

```bash
# See what's running
ps aux

# Output:
# USER    PID  %CPU %MEM COMMAND
# root    1    0.0  0.1  /sbin/init
# user    1234 0.5  2.3  vim document.txt
# user    5678 45.0 12.5 python heavy_process.py
#         ^^^^          ^^^ High CPU!
```

### Step 2: Use top for Real-Time

```bash
# Interactive view
top

# Shows:
# - Top processes by CPU
# - Memory usage
# - System load
# Press 'q' to quit
```

### Step 3: Monitor Specific Process

```bash
# Get PID of heavy process
ps aux | grep python
# Output: user 5678 45.0 12.5 python heavy_process.py

# Monitor just that process
top -p 5678

# Or use htop (if available)
htop -p 5678
```

### Step 4: Check Memory Details

```bash
# See memory breakdown
free -h
# Output:
# total used free shared buff/cache
# 8G    2.5G 1.2G 0.3G  4G

# Which process uses most?
ps aux | sort -k4 -nr | head -5
```

---

## LAB 2: Simulate Load & Monitor (1 Hour)

### Step 1: Create Test Load

```bash
# Create high-CPU process
cat > heavy.sh << 'EOF'
#!/bin/bash
while true; do
    echo "Computing..." > /dev/null
done
EOF

chmod +x heavy.sh

# Run in background
./heavy.sh &
# Output: [1] 12345  (PID is 12345)
```

### Step 2: Monitor While Running

```bash
# In another terminal
top

# Should see heavy.sh using ~100% CPU

# Or check specific PID
ps aux | grep heavy.sh
# Output:
# user 12345 99.5 0.1 ./heavy.sh
#           ^^^^ Almost all CPU!
```

### Step 3: Kill Gracefully

```bash
# Send SIGTERM (polite stop)
kill 12345

# Wait 2 seconds
sleep 2

# Check if stopped
ps aux | grep heavy.sh
# Should be gone

# Or if still running
kill -9 12345  # Force it
```

### Step 4: Verify Recovery

```bash
# Check CPU back to normal
top

# See load average dropped
uptime
# Output: load average: 0.5, 0.3, 0.2
#         (was higher when process was running)

# Cleanup
rm heavy.sh
```

---

## INCIDENT: High CPU Due to Runaway Process

### Scenario

```
Alert: Server CPU at 95%! 🚨
App is slow
Users complaining
Your job: Find and fix in 15 minutes
```

### Step 1: Quick Diagnosis

```bash
# Check top processes
ps aux | sort -k3 -nr | head -5

# Output:
# USER    PID  %CPU %MEM COMMAND
# appuser 8765 85.0 5.2  /usr/bin/python app.py
# ^^^^^^^^^^^ WAY too high!

# OR use top
top
# Shows same thing interactively
```

### Step 2: Identify Problem

```bash
# Why is it using so much CPU?
# Check process details
ps -p 8765 -o pid,user,etime,cmd

# Output:
# PID USER    ELAPSED CMD
# 8765 appuser 02:30:00 /usr/bin/python app.py
#              ^^^^^^^^ Running for 2.5 hours at 85% CPU
#              Likely runaway loop or stuck operation

# Check if it's supposed to do this
# Talk to dev: "Does app.py normally use 85% CPU?"
# Answer: "NO! Should be < 5%"

DIAGNOSIS: Runaway process (infinite loop or stuck)
```

### Step 3: Check Process Activity

```bash
# What files is it accessing?
lsof -p 8765
# Shows open files, network connections

# What system calls is it making?
strace -p 8765
# (May not be available, but useful if it is)
```

### Step 4: Terminate Safely

```bash
# First, try graceful stop (SIGTERM)
kill 8765

# Monitor for 5 seconds
sleep 5
ps aux | grep 8765

# Still there? Try again harder
kill -9 8765

# Verify it's gone
ps aux | grep 8765
# Should return empty (or just grep line)
```

### Step 5: Restart Service

```bash
# Restart app normally
sudo systemctl restart myapp

# Verify it's running but using normal CPU
ps aux | grep python
# Output:
# appuser 9999 2.3 3.5 /usr/bin/python app.py
#         ^^^ Back to normal!

# Check CPU is normal
top
# Load average back to 0.5, 0.3, 0.2
```

### Root Cause Analysis

```
PROBLEM: High CPU (85%) for 2+ hours

ROOT CAUSE:
Process in infinite loop (likely code bug)
OR stuck in long operation
OR waiting for resource indefinitely

Possible causes:
1. Infinite loop in code
2. Stuck database query
3. Deadlock with another process
4. Memory leak causing slowdown
5. Too many requests overwhelming it

SOLUTION:
Killed runaway process (kill -9)
Restarted app normally
Returned to normal CPU (2.3%)

PREVENTION:
1. Code review (check for infinite loops)
2. Timeout: Kill if running > X hours
3. Resource limits: ulimit settings
4. Monitoring: Alert if CPU > threshold for Y minutes
5. Graceful shutdown: Allow cleanup before restart
```

---

## Prevention & Monitoring

### Set Resource Limits

```bash
# Limit process resources
ulimit -c unlimited      # Core dumps
ulimit -m 1000000        # Max memory (KB)
ulimit -t 600            # Max CPU seconds

# For service (in systemd):
cat > /etc/systemd/system/myapp.service << 'EOF'
[Service]
MemoryLimit=2G          # Max 2GB RAM
CPUQuota=50%            # Max 50% CPU
TasksMax=100            # Max 100 processes
EOF
```

### Monitoring & Alerts

```bash
# Monitor script
cat > monitor_cpu.sh << 'EOF'
#!/bin/bash
while true; do
    load=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1)
    if (( $(echo "$load > 3" | bc -l) )); then
        echo "ALERT: High CPU load: $load"
        ps aux | sort -k3 -nr | head -5
    fi
    sleep 60
done
EOF

chmod +x monitor_cpu.sh
./monitor_cpu.sh &
```

---

# ✅ WEEK 4 SUMMARY

**Concepts:**
- ✅ Processes and process monitoring
- ✅ ps, top, htop commands
- ✅ Signals (SIGTERM, SIGKILL)
- ✅ CPU and memory monitoring
- ✅ Load average

**Labs:**
- ✅ Identified heavy process
- ✅ Simulated CPU load
- ✅ Monitored with top
- ✅ Terminated process safely

**Incident:**
- ✅ High CPU from runaway process
- ✅ Diagnosed root cause
- ✅ Terminated gracefully
- ✅ Restarted service

**Key Insight:**
Most performance issues = single runaway process
Systematic monitoring finds them fast
Graceful kill > forceful kill (but kill -9 always works)
