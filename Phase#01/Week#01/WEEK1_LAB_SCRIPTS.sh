#!/bin/bash

# WEEK 1: LAB SCRIPTS - SSH & USER MANAGEMENT
# Purpose: Automated setup, verification, and troubleshooting
# Usage: bash lab-1-setup.sh, bash verify-lab-1.sh, etc.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}WEEK 1 LAB SCRIPTS${NC}"
echo -e "${BLUE}========================================${NC}"

# ============================================================================
# SCRIPT 1: lab-1-setup.sh - Generate SSH Keys
# ============================================================================

setup_ssh_keys() {
    echo -e "\n${BLUE}[LAB 1] Setting up SSH keys...${NC}"
    
    # Create .ssh directory
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    echo -e "${GREEN}✅ ~/.ssh directory created (700)${NC}"
    
    # Generate RSA key
    if [ ! -f ~/.ssh/devops_demo ]; then
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/devops_demo -N "" -q
        chmod 600 ~/.ssh/devops_demo
        chmod 644 ~/.ssh/devops_demo.pub
        echo -e "${GREEN}✅ SSH key pair generated (RSA-4096)${NC}"
        echo -e "${YELLOW}   Private: ~/.ssh/devops_demo (600)${NC}"
        echo -e "${YELLOW}   Public:  ~/.ssh/devops_demo.pub (644)${NC}"
    else
        echo -e "${YELLOW}⚠️  Keys already exist. Skipping generation.${NC}"
    fi
    
    # Create SSH config
    if [ ! -f ~/.ssh/config ]; then
        cat > ~/.ssh/config << 'EOF'
Host devops-demo
    HostName 13.88.192.45
    User azureuser
    IdentityFile ~/.ssh/devops_demo
    Port 22
    StrictHostKeyChecking accept-new
    UserKnownHostsFile ~/.ssh/known_hosts
EOF
        chmod 600 ~/.ssh/config
        echo -e "${GREEN}✅ SSH config created (~/.ssh/config)${NC}"
    else
        echo -e "${YELLOW}⚠️  Config already exists. Skipping.${NC}"
    fi
    
    echo -e "\n${BLUE}Next Step: Copy public key to server${NC}"
    echo -e "${YELLOW}Command: ssh-copy-id -i ~/.ssh/devops_demo.pub azureuser@13.88.192.45${NC}"
}

# ============================================================================
# SCRIPT 2: verify-lab-1.sh - Verify SSH Setup
# ============================================================================

verify_ssh_setup() {
    echo -e "\n${BLUE}[VERIFICATION] Checking SSH setup...${NC}"
    
    local errors=0
    
    # Check .ssh directory permissions
    if [ ! -d ~/.ssh ]; then
        echo -e "${RED}❌ ~/.ssh directory missing${NC}"
        ((errors++))
    else
        perms=$(stat -f '%OLp' ~/.ssh 2>/dev/null || stat -c '%a' ~/.ssh)
        if [ "$perms" = "700" ]; then
            echo -e "${GREEN}✅ ~/.ssh directory (700 - correct)${NC}"
        else
            echo -e "${RED}❌ ~/.ssh directory ($perms - should be 700)${NC}"
            ((errors++))
        fi
    fi
    
    # Check private key
    if [ ! -f ~/.ssh/devops_demo ]; then
        echo -e "${RED}❌ Private key missing: ~/.ssh/devops_demo${NC}"
        ((errors++))
    else
        perms=$(stat -f '%OLp' ~/.ssh/devops_demo 2>/dev/null || stat -c '%a' ~/.ssh/devops_demo)
        if [ "$perms" = "600" ]; then
            echo -e "${GREEN}✅ Private key (~/.ssh/devops_demo) - 600${NC}"
        else
            echo -e "${RED}❌ Private key wrong permissions ($perms - should be 600)${NC}"
            ((errors++))
        fi
    fi
    
    # Check public key
    if [ ! -f ~/.ssh/devops_demo.pub ]; then
        echo -e "${RED}❌ Public key missing: ~/.ssh/devops_demo.pub${NC}"
        ((errors++))
    else
        perms=$(stat -f '%OLp' ~/.ssh/devops_demo.pub 2>/dev/null || stat -c '%a' ~/.ssh/devops_demo.pub)
        if [ "$perms" = "644" ]; then
            echo -e "${GREEN}✅ Public key (~/.ssh/devops_demo.pub) - 644${NC}"
        else
            echo -e "${RED}❌ Public key wrong permissions ($perms - should be 644)${NC}"
            ((errors++))
        fi
    fi
    
    # Check SSH config
    if [ ! -f ~/.ssh/config ]; then
        echo -e "${YELLOW}⚠️  SSH config missing (optional but recommended)${NC}"
    else
        if grep -q "Host devops-demo" ~/.ssh/config; then
            echo -e "${GREEN}✅ SSH config created${NC}"
        else
            echo -e "${YELLOW}⚠️  SSH config exists but missing devops-demo${NC}"
        fi
    fi
    
    # Try SSH connection (if server available)
    if command -v ssh &> /dev/null; then
        echo -e "\n${BLUE}Testing SSH connection...${NC}"
        if ssh -i ~/.ssh/devops_demo -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new azureuser@13.88.192.45 echo "SSH OK" &>/dev/null; then
            echo -e "${GREEN}✅ SSH connection successful${NC}"
        else
            echo -e "${YELLOW}⚠️  SSH connection failed (server may not be reachable)${NC}"
        fi
    fi
    
    # Final verdict
    echo ""
    if [ $errors -eq 0 ]; then
        echo -e "${GREEN}✅ LAB 1 VERIFICATION PASSED${NC}"
        return 0
    else
        echo -e "${RED}❌ LAB 1 HAS $errors ERROR(S)${NC}"
        return 1
    fi
}

# ============================================================================
# SCRIPT 3: lab-2-setup.sh - Create User & Setup Sudo
# ============================================================================

setup_user_sudo() {
    echo -e "\n${BLUE}[LAB 2] Setting up user and sudo...${NC}"
    
    # Check if running with sudo
    if [ "$EUID" -ne 0 ]; then 
        echo -e "${RED}❌ This script needs to run with sudo${NC}"
        echo -e "${YELLOW}Usage: sudo bash lab-2-setup.sh${NC}"
        return 1
    fi
    
    USERNAME="devops-user"
    
    # Create user
    if id "$USERNAME" &>/dev/null; then
        echo -e "${YELLOW}⚠️  User $USERNAME already exists${NC}"
    else
        useradd -m -s /bin/bash "$USERNAME"
        echo -e "${GREEN}✅ User created: $USERNAME${NC}"
    fi
    
    # Create SSH directory
    sudo -u "$USERNAME" mkdir -p /home/$USERNAME/.ssh
    sudo -u "$USERNAME" chmod 700 /home/$USERNAME/.ssh
    echo -e "${GREEN}✅ SSH directory created: /home/$USERNAME/.ssh (700)${NC}"
    
    # Generate SSH key for user
    if [ ! -f /home/$USERNAME/.ssh/devops_key ]; then
        ssh-keygen -t rsa -b 4096 -f /home/$USERNAME/.ssh/devops_key -N "" -q -C "$USERNAME@devops"
        sudo -u "$USERNAME" chmod 600 /home/$USERNAME/.ssh/devops_key
        sudo -u "$USERNAME" chmod 644 /home/$USERNAME/.ssh/devops_key.pub
        echo -e "${GREEN}✅ SSH key generated for $USERNAME${NC}"
    else
        echo -e "${YELLOW}⚠️  SSH key already exists for $USERNAME${NC}"
    fi
    
    # Setup authorized_keys
    if [ ! -f /home/$USERNAME/.ssh/authorized_keys ]; then
        cat /home/$USERNAME/.ssh/devops_key.pub > /home/$USERNAME/.ssh/authorized_keys
        sudo -u "$USERNAME" chmod 600 /home/$USERNAME/.ssh/authorized_keys
        echo -e "${GREEN}✅ authorized_keys configured${NC}"
    else
        echo -e "${YELLOW}⚠️  authorized_keys already exists${NC}"
    fi
    
    # Add to sudo group
    if groups "$USERNAME" | grep -q sudo; then
        echo -e "${YELLOW}⚠️  $USERNAME already in sudo group${NC}"
    else
        usermod -aG sudo "$USERNAME"
        echo -e "${GREEN}✅ $USERNAME added to sudo group${NC}"
    fi
    
    # Create sudoers entry (no password for specific commands)
    if [ ! -f /etc/sudoers.d/$USERNAME ]; then
        cat > /etc/sudoers.d/$USERNAME << EOF
$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /bin/systemctl
EOF
        chmod 440 /etc/sudoers.d/$USERNAME
        echo -e "${GREEN}✅ Sudoers entry created${NC}"
    else
        echo -e "${YELLOW}⚠️  Sudoers entry already exists${NC}"
    fi
    
    echo -e "\n${BLUE}Next Step: Test user access${NC}"
    echo -e "${YELLOW}Command: ssh -i /home/$USERNAME/.ssh/devops_key $USERNAME@localhost${NC}"
}

# ============================================================================
# SCRIPT 4: verify-lab-2.sh - Verify User Setup
# ============================================================================

verify_user_setup() {
    echo -e "\n${BLUE}[VERIFICATION] Checking user setup...${NC}"
    
    local errors=0
    USERNAME="devops-user"
    
    # Check user exists
    if id "$USERNAME" &>/dev/null; then
        echo -e "${GREEN}✅ User exists: $USERNAME${NC}"
    else
        echo -e "${RED}❌ User missing: $USERNAME${NC}"
        ((errors++))
        return $errors
    fi
    
    # Check home directory
    if [ -d /home/$USERNAME ]; then
        echo -e "${GREEN}✅ Home directory: /home/$USERNAME${NC}"
    else
        echo -e "${RED}❌ Home directory missing: /home/$USERNAME${NC}"
        ((errors++))
    fi
    
    # Check SSH directory permissions
    if [ -d /home/$USERNAME/.ssh ]; then
        perms=$(stat -f '%OLp' /home/$USERNAME/.ssh 2>/dev/null || stat -c '%a' /home/$USERNAME/.ssh)
        if [ "$perms" = "700" ]; then
            echo -e "${GREEN}✅ .ssh directory (/home/$USERNAME/.ssh) - 700${NC}"
        else
            echo -e "${RED}❌ .ssh directory wrong permissions ($perms - should be 700)${NC}"
            ((errors++))
        fi
    else
        echo -e "${RED}❌ .ssh directory missing: /home/$USERNAME/.ssh${NC}"
        ((errors++))
    fi
    
    # Check private key
    if [ -f /home/$USERNAME/.ssh/devops_key ]; then
        perms=$(stat -f '%OLp' /home/$USERNAME/.ssh/devops_key 2>/dev/null || stat -c '%a' /home/$USERNAME/.ssh/devops_key)
        if [ "$perms" = "600" ]; then
            echo -e "${GREEN}✅ Private key (/home/$USERNAME/.ssh/devops_key) - 600${NC}"
        else
            echo -e "${RED}❌ Private key wrong permissions ($perms - should be 600)${NC}"
            ((errors++))
        fi
    else
        echo -e "${RED}❌ Private key missing: /home/$USERNAME/.ssh/devops_key${NC}"
        ((errors++))
    fi
    
    # Check authorized_keys
    if [ -f /home/$USERNAME/.ssh/authorized_keys ]; then
        perms=$(stat -f '%OLp' /home/$USERNAME/.ssh/authorized_keys 2>/dev/null || stat -c '%a' /home/$USERNAME/.ssh/authorized_keys)
        if [ "$perms" = "600" ]; then
            echo -e "${GREEN}✅ authorized_keys - 600${NC}"
        else
            echo -e "${RED}❌ authorized_keys wrong permissions ($perms - should be 600)${NC}"
            ((errors++))
        fi
    else
        echo -e "${RED}❌ authorized_keys missing${NC}"
        ((errors++))
    fi
    
    # Check sudo group membership
    if groups "$USERNAME" | grep -q sudo; then
        echo -e "${GREEN}✅ User in sudo group${NC}"
    else
        echo -e "${RED}❌ User NOT in sudo group${NC}"
        ((errors++))
    fi
    
    # Check sudoers file
    if [ -f /etc/sudoers.d/$USERNAME ]; then
        echo -e "${GREEN}✅ Sudoers entry exists${NC}"
    else
        echo -e "${YELLOW}⚠️  Sudoers entry missing (optional)${NC}"
    fi
    
    # Final verdict
    echo ""
    if [ $errors -eq 0 ]; then
        echo -e "${GREEN}✅ LAB 2 VERIFICATION PASSED${NC}"
        return 0
    else
        echo -e "${RED}❌ LAB 2 HAS $errors ERROR(S)${NC}"
        return 1
    fi
}

# ============================================================================
# SCRIPT 5: fix-ssh-permissions.sh - Fix SSH Permissions
# ============================================================================

fix_ssh_permissions() {
    echo -e "\n${BLUE}[FIX] Correcting SSH permissions...${NC}"
    
    # Fix .ssh directory
    chmod 700 ~/.ssh
    echo -e "${GREEN}✅ Fixed ~/.ssh (700)${NC}"
    
    # Fix all private keys
    chmod 600 ~/.ssh/id_rsa ~/.ssh/devops_demo ~/.ssh/devops_key 2>/dev/null
    echo -e "${GREEN}✅ Fixed private keys (600)${NC}"
    
    # Fix all public keys
    chmod 644 ~/.ssh/*.pub 2>/dev/null
    echo -e "${GREEN}✅ Fixed public keys (644)${NC}"
    
    # Fix authorized_keys
    chmod 600 ~/.ssh/authorized_keys 2>/dev/null
    echo -e "${GREEN}✅ Fixed authorized_keys (600)${NC}"
    
    echo -e "${GREEN}✅ SSH permissions fixed!${NC}"
}

# ============================================================================
# SCRIPT 6: troubleshoot-ssh.sh - SSH Troubleshooting
# ============================================================================

troubleshoot_ssh() {
    echo -e "\n${BLUE}[TROUBLESHOOT] SSH Connection Issues${NC}"
    
    read -p "Enter server (user@host:port): " SERVER
    read -p "Enter SSH key path: " KEYPATH
    
    echo -e "\n${BLUE}Step 1: Check if key exists${NC}"
    if [ -f "$KEYPATH" ]; then
        echo -e "${GREEN}✅ Key file exists${NC}"
        ls -la "$KEYPATH"
    else
        echo -e "${RED}❌ Key file not found: $KEYPATH${NC}"
        return 1
    fi
    
    echo -e "\n${BLUE}Step 2: Check key permissions${NC}"
    perms=$(stat -f '%OLp' "$KEYPATH" 2>/dev/null || stat -c '%a' "$KEYPATH")
    if [ "$perms" = "600" ]; then
        echo -e "${GREEN}✅ Key permissions correct (600)${NC}"
    else
        echo -e "${RED}❌ Key permissions wrong ($perms - should be 600)${NC}"
        read -p "Fix permissions? (y/n): " fix
        if [ "$fix" = "y" ]; then
            chmod 600 "$KEYPATH"
            echo -e "${GREEN}✅ Fixed${NC}"
        fi
    fi
    
    echo -e "\n${BLUE}Step 3: Test SSH with verbose output${NC}"
    echo -e "${YELLOW}Running: ssh -vvv -i $KEYPATH $SERVER${NC}"
    ssh -vvv -i "$KEYPATH" "$SERVER" 2>&1 | head -20
    
    echo -e "\n${BLUE}Step 4: Common issues${NC}"
    echo "1. Key not found in authorized_keys on server"
    echo "2. Permission denied = key has wrong perms or not in authorized_keys"
    echo "3. Connection timeout = firewall blocking or wrong port"
    echo "4. Host key verification = first-time connection, type 'yes'"
}

# ============================================================================
# SCRIPT 7: monitoring-ssh.sh - Monitor SSH Access
# ============================================================================

monitor_ssh() {
    echo -e "\n${BLUE}[MONITOR] SSH Access and Failures${NC}"
    
    echo -e "\n${BLUE}Recent successful logins:${NC}"
    sudo cat /var/log/auth.log 2>/dev/null | grep "Accepted publickey" | tail -5 || echo "No auth.log access"
    
    echo -e "\n${BLUE}Recent failed attempts:${NC}"
    sudo cat /var/log/auth.log 2>/dev/null | grep "Failed password" | tail -5 || echo "No auth.log access"
    
    echo -e "\n${BLUE}SSH connection attempts (real-time):${NC}"
    echo "Press Ctrl+C to stop"
    sudo tail -f /var/log/auth.log 2>/dev/null | grep "ssh" || echo "No permission to monitor logs"
}

# ============================================================================
# MAIN MENU
# ============================================================================

show_menu() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}WEEK 1: SSH & USER MANAGEMENT${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo "1. [LAB 1] Setup SSH keys"
    echo "2. [LAB 1] Verify SSH setup"
    echo "3. [LAB 2] Setup user & sudo (requires sudo)"
    echo "4. [LAB 2] Verify user setup"
    echo "5. [FIX] Fix SSH permissions"
    echo "6. [TROUBLESHOOT] Debug SSH issues"
    echo "7. [MONITOR] Monitor SSH access"
    echo "8. Run ALL labs"
    echo "0. Exit"
    echo ""
}

# Main script logic
main() {
    if [ $# -eq 0 ]; then
        # Interactive mode
        while true; do
            show_menu
            read -p "Choose option (0-8): " choice
            
            case $choice in
                1) setup_ssh_keys ;;
                2) verify_ssh_setup ;;
                3) setup_user_sudo ;;
                4) verify_user_setup ;;
                5) fix_ssh_permissions ;;
                6) troubleshoot_ssh ;;
                7) monitor_ssh ;;
                8) 
                    setup_ssh_keys
                    verify_ssh_setup
                    echo ""
                    echo "Now run as sudo:"
                    echo "sudo bash $0 all"
                    ;;
                0) echo -e "${GREEN}Goodbye!${NC}"; exit 0 ;;
                *) echo -e "${RED}Invalid option${NC}" ;;
            esac
        done
    else
        # Command line mode
        case $1 in
            setup-keys) setup_ssh_keys ;;
            verify-keys) verify_ssh_setup ;;
            setup-user) setup_user_sudo ;;
            verify-user) verify_user_setup ;;
            fix-perms) fix_ssh_permissions ;;
            troubleshoot) troubleshoot_ssh ;;
            monitor) monitor_ssh ;;
            all) 
                setup_ssh_keys
                verify_ssh_setup
                setup_user_sudo
                verify_user_setup
                ;;
            *) echo "Usage: $0 {setup-keys|verify-keys|setup-user|verify-user|fix-perms|troubleshoot|monitor|all}"
        esac
    fi
}

# Run main
main "$@"
