# Alpine image -> use apk to install ffmpeg
FROM docker.n8n.io/n8nio/n8n:latest
USER root
RUN apk add --no-cache ffmpeg
# Persist data under /data (Render disk will mount here)
ENV N8N_USER_FOLDER=/data
# Expose n8n's default port for Render
EXPOSE 5678
USER node
