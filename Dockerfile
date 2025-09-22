# Use the official n8n base image
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to the root user to create config and install packages
USER root

# ---- THE DEFINITIVE FIX ----
# Create a permanent config file inside the image that forces the proxy setting.
# This bypasses all environment variable issues.
RUN mkdir -p /home/node/.n8n/ && \
    echo "module.exports = { express: { 'trust proxy': true } };" > /home/node/.n8n/config.js && \
    chown -R node:node /home/node/.n8n

# Install ffmpeg for media processing
RUN apk add --no-cache ffmpeg

# Set the persistent data folder (Render disk will mount here at /data)
ENV N8N_USER_FOLDER=/data

# Expose n8n's default port for Render
EXPOSE 5678

# Switch back to the non-privileged node user to run the application
USER node
