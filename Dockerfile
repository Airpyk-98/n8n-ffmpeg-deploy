# Use the official n8n base image
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to the root user to install packages
USER root

# ---- THIS IS THE MOST RELIABLE FIX ----
# Set the environment variables directly in the image
# This guarantees n8n starts with the correct settings
ENV N8N_TRUST_PROXY=true
ENV N8N_RUNNERS_ENABLED=true
ENV DB_SQLITE_POOL_SIZE=10

# Install ffmpeg
RUN apk add --no-cache ffmpeg

# Set a persistent data folder (Render disk will mount here)
ENV N8N_USER_FOLDER=/data

# Expose n8n's default port for Render
EXPOSE 5678

# Switch back to the non-privileged node user to run the application
USER node
