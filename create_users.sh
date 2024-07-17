#!/bin/sh

# Function to add a Samba user
add_samba_user() {
    local user=$1
    local password=$2
    adduser -D -H -G smbusers "$user"
    echo -e "$password\n$password" | smbpasswd -a -s "$user"
}

# Add users based on environment variables
for i in $(seq 1 10); do
    user_var="USER${i}"
    password_var="PASSWORD${i}"
    user=${!user_var}
    password=${!password_var}
    if [ -n "$user" ] && [ -n "$password" ]; then
        add_samba_user "$user" "$password"
    fi
done

# Set permissions for the /mount directory
chown -R root:smbusers /mount
chmod -R 0770 /mount