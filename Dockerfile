# Use the Alpine base image
FROM alpine

# Install necessary packages
RUN apk update && apk add samba samba-common-tools

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
EXPOSE 139 445

# Command to start the Samba service and create users
CMD /usr/local/bin/create_users.sh && smbd -FS --no-process-group