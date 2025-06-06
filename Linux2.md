# Update System Package list
    sudo dnf update -y

# Install httpd and nano
    sudo dnf install httpd nano -y

# Verify package installation
    sudo dnf list --installed | grep -E 'nano|httpd"

# Remove nano
    sudo dnf remove nano -y

# List all installed packages that start with letter h
    sudo dnf list --installed | grep -E ^h

# Start The Apache web server
    sudo systemctl start httpd

# Check status of service
    sudo systemctl status httpd

# Enable The Apache web server
    sudo systemctl enable httpd

# Stop thr service
    sudo systemctl stop httpd

# Disable from starting at boot
    sudo systemctl disable httpd

# Restart the service and verify
    sudo systemctl restart httpd && sudo systemctl status httpd

# List installed active services
    systemctl list-units --type service --state active

# Create file
    vi sample.txt

# lines
1. cat sample.txt | grep -E '^J'
2. cat sample.txt | grep @
3. cat sample.txt | grep -E '\bE'
4. cat sample.txt | grep "Error"
5. cat sample.txt | grep -E '[0-9]$'
6. cat sample.txt | grep -E '^[A-Za-z]{5}'
7. cat sample.txt | grep -E "^[AEIOU]"
