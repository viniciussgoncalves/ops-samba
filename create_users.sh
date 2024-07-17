#!/bin/sh

# Function to add a Samba user
add_samba_user() {
    local user=$1
    local password=$2
    if id "$user" &>/dev/null; then
        echo "User $user already exists, skipping creation."
    else
        adduser -D -H -G smbusers "$user"
        echo -e "$password\n$password" | smbpasswd -a -s "$user"
    fi
}

# Add users based on environment variables
for i in $(seq 1 10); do
    user_var="USER${i}"
    password_var="PASSWORD${i}"
    user=$(eval echo \$$user_var)
    password=$(eval echo \$$password_var)
    if [ -n "$user" ] && [ -n "$password" ]; then
        add_samba_user "$user" "$password"
    fi
done

# Set permissions for the /mount directory
chown -R root:smbusers /mount
chmod -R 0770 /mount