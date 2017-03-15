cat  /etc/passwd | awk -F: '$3 >= 1000{print $7}'
