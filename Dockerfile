# Use the Alpine base image
FROM alpine:3.20.1

# Install necessary packages
RUN apk update && \
    apk add --no-cache \
    samba=4.19.6-r0 \
    samba-common-tools=4.19.6-r0 \
    openssl=3.3.1-r3 && \
    rm -rf /var/cache/apk/*

# Create the directory for sharing
RUN mkdir -p /mount

# Create the Samba users group
RUN addgroup smbusers

# Add a script to create users dynamically
COPY create_users.sh /usr/local/bin/create_users.sh
RUN chmod +x /usr/local/bin/create_users.sh

# Copy the Samba configuration file
COPY config/smb.conf /etc/samba/smb.conf

# Set permissions for the /mount directory
RUN chown -R root:smbusers /mount && \
    chmod -R 0770 /mount

# Expose ports 139 and 445 (NetBIOS and SMB)
EXPOSE 445

# Command to start the Samba service and create users
CMD /usr/local/bin/create_users.sh && smbd -F --no-process-group