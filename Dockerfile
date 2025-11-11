# Use the official n8n base image
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to the root user to create config and install packages
USER root

# ---- THE DEFINITIVE FIX ----
# (Your existing proxy fix)
RUN mkdir -p /home/node/.n8n/ && \
    echo "module.exports = { express: { 'trust proxy': true } };" > /home/node/.n8n/config.js && \
    chown -R node:node /home/node/.n8n

# === START OF PACKAGE INSTALLS ===

# Install ffmpeg AND Python build dependencies
RUN apk add --no-cache \
    ffmpeg \
    build-base \
    python3-dev \
    py3-pip \
    gfortran \
    musl-dev \
    libffi-dev

# Install your Python libraries
# We add --break-system-packages to override PEP 668
RUN pip install --upgrade pip && \
    pip install --break-system-packages \
    numpy \
    scipy \
    pandas \
    matplotlib \
    rdkit-pypi

# === END OF PACKAGE INSTALLS ===

# Set the persistent data folder (Render disk will mount here at /data)
ENV N8N_USER_FOLDER=/data

# Expose n8n's default port for Render
EXPOSE 5678

# Switch back to the non-privileged node user to run the application
USER node
