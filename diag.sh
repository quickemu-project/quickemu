#!/bin/bash
output_diagnostic_info() {
    local PRETTY_NAME
    if [ -e /etc/os-release ]; then
        eval "$(grep PRETTY_NAME /etc/os-release)"
    else
        PRETTY_NAME="Unknown"
    fi
    echo "Diagnostic Information"; 
        echo \
"---------------------------------
       Software Information
----------------------------------"

    echo Quickemu version : "$(quickemu --version)"
    curl --version    
    qemu-system-"$(uname -p)" -version | head -1     
    qemu-system-"$(uname -p)" -machine help -cpu help
    echo \
"---------------------------------
       System Information
----------------------------------"
    echo "Kernel Version: $(uname -srvpio)"
    echo "Memory: $(free -h | awk '/Mem:/{print $2}')"
    sudo  vmstat -w -SM -a
    echo "CPU Flags: $(grep flags /proc/cpuinfo | sort -u | awk -F: '{print $2}')"
    #echo "Operating System: $(lsb_release -d | awk -F"\t" '{print $2}')"
    echo "Operating System: ${PRETTY_NAME}" #  - Non LSB version"
    echo "GPU Info:"
    lspci | grep -i  vga
    sudo dmesg | grep -i -e vga -e gpu | grep -v trace | cut -d] -f2-

}


output_diagnostic_info