#!/bin/bash

# Variable for os name
os_name=$(uname -s)

# Function to install Apache2 on Debian/Ubuntu
install_apache_debian() {
    sudo apt update
    sudo apt install -y apache2
}

# Function to install Apache2 on RHEL/CentOS
install_apache_rhel() {
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
}

# Main installation function
install_apache() {
    case "$os_name" in
        "Linux")
            if grep -qiE "ubuntu" /etc/*release; then
                echo "Detected OS: Ubuntu"
                install_apache_debian
            elif grep -qiE "rhel|centos" /etc/*release; then
                echo "Detected OS: RHEL/CentOS"
                install_apache_rhel
            else
                echo "Unsupported Linux distribution."
                exit 1
            fi
            ;;
        *)
            echo "Unsupported OS: $os_name"
            exit 1
            ;;
    esac
}

# Run the main installation function
install_apache