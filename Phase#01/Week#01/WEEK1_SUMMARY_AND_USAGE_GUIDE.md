# WEEK 1 COMPLETE PACKAGE - USAGE GUIDE

## 📦 What You Have

You now have a complete **Week 1 Learning Package** with all materials organized:

### Files Created

1. **PHASE1_WEEK1_COMPLETE.md** (Main learning document)
   - Detailed concepts (DevOps, SDLC, Environments, SSH, Server Hygiene)
   - 2 complete hands-on labs with step-by-step instructions
   - 3 real incident scenarios with troubleshooting
   - Advanced topics (key rotation, bastion hosts, hardening)
   - Size: 20,000+ words of comprehensive content

2. **GITHUB_README_WEEK1.md** (Repository template)
   - Professional README for your GitHub repo
   - Quick start guide
   - Directory structure
   - Progress tracking
   - All commands reference

3. **LINKEDIN_POSTS_AND_INCIDENT_REPORTS.md** (Portfolio content)
   - 3 ready-to-publish LinkedIn post versions
   - 3 professional incident report templates
   - Incident documentation framework
   - Professional communication templates

4. **WEEK1_LAB_SCRIPTS.sh** (Automated bash scripts)
   - Setup SSH keys (automated)
   - Verify SSH setup
   - Create users with sudo
   - Verify user permissions
   - Fix permission issues
   - Troubleshooting helper
   - SSH monitoring script

---

## 🎯 How to Use This Package

### Phase 1: Learning (6 hours total)

#### Day 1: Concepts (2 hours)
```bash
# Read the concepts section
open PHASE1_WEEK1_COMPLETE.md
# Read sections:
# - DAY 1: CONCEPTS & THEORY
#   ✓ DevOps Overview
#   ✓ SDLC Explanation
#   ✓ Environments (DEV/SIT/UAT/PROD)
#   ✓ SSH Theory
#   ✓ Server Hygiene Checklist

# Time: 2 hours
# Deliverable: Understanding concepts
```

#### Day 2: Labs (2 hours)

**Lab 1: SSH Keys (1 hour)**
```bash
# Manual approach (recommended for learning):
bash WEEK1_LAB_SCRIPTS.sh
# Choose: 1 (Setup SSH keys)
# Then choose: 2 (Verify SSH setup)

# OR automated:
bash WEEK1_LAB_SCRIPTS.sh setup-keys
bash WEEK1_LAB_SCRIPTS.sh verify-keys

# Follow steps:
# 1. Generate SSH keys
# 2. Copy to server
# 3. Test connection
# 4. Create SSH config
# 5. Verify everything

# Deliverable: Working SSH access to server
```

**Lab 2: User Management (1 hour)**
```bash
# Setup user and sudo
sudo bash WEEK1_LAB_SCRIPTS.sh setup-user
sudo bash WEEK1_LAB_SCRIPTS.sh verify-user

# Steps:
# 1. Create devops-user
# 2. Create SSH for user
# 3. Setup authorized_keys
# 4. Add to sudo group
# 5. Test access

# Deliverable: New user with SSH + sudo access
```

#### Day 3: Incidents (2 hours)

**Incident 1: SSH Port Timeout (30 min)**
```bash
# Read section: INCIDENT 1: SSH Port Change
# Scenario: ssh command fails with "Connection timeout"
# Your task: 
#   1. Diagnose the issue
#   2. Find root cause
#   3. Implement solution
#   4. Document incident report

# Use troubleshooting script if needed:
bash WEEK1_LAB_SCRIPTS.sh troubleshoot

# Deliverable: Incident report (see template)
```

**Incident 2: Permission Denied (30 min)**
```bash
# Read section: INCIDENT 2: Permission Denied
# Scenario: SSH says "Permission denied (publickey)"
# Your task:
#   1. Check file permissions
#   2. Identify wrong perms
#   3. Fix with chmod
#   4. Document solution

# Use fix script if needed:
bash WEEK1_LAB_SCRIPTS.sh fix-perms

# Deliverable: Incident report
```

**Incident 3: Key Mismatch (30 min)**
```bash
# Read section: INCIDENT 3: Key Mismatch
# Scenario: Right key, wrong user
# Your task:
#   1. Identify the issue
#   2. Check authorized_keys
#   3. Use correct user OR add key
#   4. Document solution

# Deliverable: Incident report
```

---

## 📱 Portfolio Building Phase (3-4 hours)

### GitHub Setup

```bash
# 1. Create repository
git init devops-week-1
cd devops-week-1

# 2. Add all materials
# Copy files from outputs/ to your repo:
# - PHASE1_WEEK1_COMPLETE.md → README.md (or docs/complete-guide.md)
# - Copy concept explanations
# - Copy lab guides
# - Copy incident reports
# - Add WEEK1_LAB_SCRIPTS.sh to scripts/ folder

# 3. Organize structure
mkdir -p docs labs incidents configs scripts
# Move files appropriately

# 4. Create .gitignore
cat > .gitignore << 'EOF'
.ssh/
*.key
*.pem
private_*
secrets/
.env
EOF

# 5. Commit and push
git add .
git commit -m "Week 1: SSH & Linux Fundamentals - Complete"
git remote add origin https://github.com/yourusername/devops-week-1.git
git branch -M main
git push -u origin main
```

### LinkedIn Post

```bash
# 1. Choose post version from LINKEDIN_POSTS_AND_INCIDENT_REPORTS.md
#    - Version 1: Technical focus
#    - Version 2: Story-driven
#    - Version 3: Career-focused

# 2. Personalize with your details:
#    - Your name
#    - Your GitHub link
#    - Your start date
#    - Your target role

# 3. Add images:
#    - Screenshot of GitHub repo
#    - Screenshot of SSH connection
#    - Screenshot of incident report
#    - Or create simple diagram

# 4. Publish on LinkedIn

# 5. Ask engagement question at end
# 6. Add relevant hashtags

# Expected: 50-200 likes, some comments
# Goal: Show learning progress to network
```

---

## 📊 Week 1 Completion Checklist

```
CONCEPTS LEARNED
☐ DevOps fundamentals
☐ SDLC phases
☐ Environment types (DEV/SIT/UAT/PROD)
☐ SSH authentication theory
☐ Server hygiene best practices

LABS COMPLETED
☐ Lab 1: SSH keys generated
☐ Lab 1: Connected to server successfully
☐ Lab 1: Created ~/.ssh/config
☐ Lab 2: Created devops-user
☐ Lab 2: Setup SSH for user
☐ Lab 2: Configured sudo access
☐ Lab 2: File permissions verified

INCIDENTS DEBUGGED & DOCUMENTED
☐ Incident 1: SSH port timeout
   - Root cause identified
   - Solution implemented
   - Professional report written
☐ Incident 2: Permission denied
   - Issue diagnosed
   - Fix applied
   - Prevention documented
☐ Incident 3: Key mismatch
   - Problem understood
   - Solution chosen
   - Documentation complete

PORTFOLIO ARTIFACTS
☐ GitHub repository created and populated
☐ Professional README written
☐ Incident reports documented
☐ Lab scripts committed
☐ LinkedIn post published
☐ All links tested and working

ADVANCED TOPICS REVIEWED
☐ SSH key rotation strategy
☐ Bastion hosts / Jump hosts
☐ SSH agent setup
☐ sshd_config hardening
☐ SSH monitoring

READY FOR WEEK 2
☐ All Week 1 materials on GitHub
☐ Portfolio post published
☐ Lab scripts working
☐ Incident documentation complete
☐ Ready to tackle Linux filesystem & commands
```

---

## 🚀 Execution Timeline

### Ideal Schedule (6 days)

**Day 1 (2 hours): Concepts**
- Morning: Read DevOps fundamentals
- Afternoon: Read SDLC, environments, SSH theory

**Day 2 (2 hours): Lab 1 - SSH Keys**
- Morning: Generate SSH keys
- Afternoon: Connect to server, create config

**Day 3 (2 hours): Lab 2 - User Management**
- Morning: Create user and SSH setup
- Afternoon: Configure sudo, verify permissions

**Day 4 (1.5 hours): Incident 1 & 2**
- Morning: Debug port timeout incident
- Afternoon: Fix permission denied issue

**Day 5 (1.5 hours): Incident 3**
- Morning: Resolve key mismatch
- Afternoon: Write incident documentation

**Day 6 (2 hours): Portfolio & Review**
- Morning: Set up GitHub repo
- Afternoon: Write LinkedIn post, final verification

**Total: 11 hours** (Can compress to 6 hours if done intensively)

---

## 🎓 What You'll Know After Week 1

### Technical Skills ✅

1. **SSH Knowledge**
   - Key generation (RSA-4096, Ed25519)
   - SSH config management
   - Connection debugging
   - Permissions troubleshooting

2. **User Management**
   - Creating users (useradd)
   - Group management (sudo)
   - Permission setting (chmod, chown)
   - SSH setup for users

3. **Server Concepts**
   - DevOps fundamentals
   - SDLC understanding
   - Environment types
   - Security best practices

4. **Troubleshooting**
   - Systematic debugging approach
   - Verbose output analysis
   - Root cause identification
   - Solution documentation

### Soft Skills ✅

1. **Documentation**
   - Professional incident reports
   - Technical writing
   - Clear explanations

2. **Communication**
   - LinkedIn professional presence
   - Technical storytelling
   - Knowledge sharing

3. **Problem-Solving**
   - Systematic approach
   - Critical thinking
   - Real-world application

---

## 💡 Tips for Success

### 1. **Don't Just Read, Actually Do**
- SSH keys: Generate on YOUR laptop
- User setup: Create on YOUR server
- Incidents: Debug step-by-step yourself
- Scripts: Run and understand each command

### 2. **Document Everything**
- Every lab: Write what you did and why
- Every incident: Create professional RCA
- Every mistake: Note it in learning log
- This becomes portfolio

### 3. **Git Workflow**
```bash
# Commit after each major milestone
git add .
git commit -m "Lab 1: SSH keys configured"

git add .
git commit -m "Lab 2: Users and sudo setup"

git add .
git commit -m "Incidents: Completed all 3 scenarios"

git add .
git commit -m "Portfolio: README and documentation"
```

### 4. **LinkedIn Strategy**
- Post after completing Week 1
- Tag people in bootcamp
- Share learnings genuinely
- Engage with others' posts
- Build network early

### 5. **Be Ready for Week 2**
- Back up all Week 1 work
- Review concepts before starting Week 2
- Share lessons learned
- Prepare for next phase (Linux filesystem)

---

## 🔗 How to Reference This Material Later

### For Future Interviews

When asked: **"Tell me about incident you handled"**

```
Response: "In my DevOps bootcamp Week 1, I had to debug an SSH
connection timeout. The server port had been changed from 22 to 2222
without notification. I:

1. Enabled verbose SSH debugging (-vvv)
2. Checked firewall rules
3. Identified port mismatch in sshd_config
4. Updated team documentation
5. Created incident RCA for prevention

This taught me importance of change management and communication
in infrastructure work."

Shows: Problem-solving, documentation, communication skills
```

### For Portfolio

GitHub repo becomes your "first major project" that shows:
- Hands-on practical work
- Professional documentation
- Problem-solving ability
- Communication skills
- Ready-to-learn mindset

### For Continuing Learning

This Week 1 foundation is prerequisite for:
- Week 2: Linux filesystem (uses user management knowledge)
- Week 3: Package management (uses server concepts)
- Week 4-5: System administration (uses all concepts)
- And so on...

---

## ⚠️ Common Mistakes to Avoid

### 1. SSH Permissions
```bash
# ❌ WRONG
chmod 666 ~/.ssh/id_rsa    # World readable!
chmod 777 ~/.ssh           # World writable!

# ✅ RIGHT
chmod 600 ~/.ssh/id_rsa    # Owner only
chmod 700 ~/.ssh           # Owner only
chmod 644 ~/.ssh/id_rsa.pub # Public, read-only
```

### 2. Password vs Keys
```bash
# ❌ WRONG
ssh azureuser@server    # Asks for password
# Anyone can brute-force!

# ✅ RIGHT
ssh -i ~/.ssh/id_rsa azureuser@server   # Uses key
# Mathematically secure
```

### 3. Running as Root
```bash
# ❌ WRONG
sudo useradd -m -s /bin/bash myuser
sudo ssh myuser@server

# ✅ RIGHT
useradd -m -s /bin/bash myuser  # Create as admin
# User runs own SSH with their key
```

### 4. Documentation
```bash
# ❌ WRONG
"Fixed SSH issues"          # Too vague
"Port changed"              # Missing context

# ✅ RIGHT
"SSH port changed 22→2222 causing connection timeout. 
 Root cause: Admin change without team notification.
 Solution: Updated SSH config, notified team.
 Prevention: Implement change management process."
```

---

## 📚 Next Steps After Week 1

### Immediate (This Week)
- ✅ Complete all checklist items
- ✅ Publish GitHub repo
- ✅ Publish LinkedIn post
- ✅ Get feedback from community

### This Week (After Completing Week 1)
- Read PHASE 1, WEEK 2: Linux Filesystem Concepts
- Setup labs for Week 2
- Plan Week 2 schedule

### This Month
- Complete PHASE 1 (Weeks 1-5)
- Start PHASE 2 (Git basics)
- Reflect on learning approach

### This Quarter
- Complete PHASE 1-3 (Linux, Git, Automation)
- Have 2-3 portfolio pieces
- Start applying for junior roles

### This Year
- Complete full 36-week bootcamp
- Build capstone project
- Land first DevOps role

---

## 🎯 Success Criteria

**You'll know Week 1 is complete when:**

- [ ] All labs run without errors
- [ ] All incidents are debugged
- [ ] GitHub repo is public and complete
- [ ] LinkedIn post is published and engaged with
- [ ] You can explain SSH authentication to someone else
- [ ] You can debug any SSH issue using systematic approach
- [ ] You have 3 professional incident reports
- [ ] You understand why each concept matters
- [ ] You're excited for Week 2
- [ ] You've shared your progress with network

---

## 🎉 Congratulations!

You're now ready to start **WEEK 2: Linux Filesystem & Core Commands**.

But first, celebrate! You've:
✅ Completed Week 1 comprehensively
✅ Built your first portfolio piece
✅ Debugged real incidents
✅ Documented professionally
✅ Started your network
✅ Proven you can learn and execute

**This is what job-ready looks like.**

---

**Good luck! 🚀**

Questions? Issues? Improvements?  
→ Check GitHub issues or discussion  
→ DM your learning community  
→ Keep pushing forward  

**Week 1: Complete ✨**
