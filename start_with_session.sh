#!/usr/bin/env bash
set -e

# This script runs on Render. It will:
# 1) Download the session zip from the URL stored in the env var SESSION_ZIP_URL
# 2) Extract it into the persistent disk mount at /data/RubySessions
# 3) Start the bot using the normal start command (npm start below — change if needed)

# Change this if your bot starts differently
BOT_START_CMD="npm start"

# Destination on Render persistent disk
DEST_DIR="/data/RubySessions"
TMP_ZIP="/tmp/RubySessions.zip"

# If no URL provided, we skip download (useful for later runs)
if [ -n "$SESSION_ZIP_URL" ]; then
  echo "SESSION_ZIP_URL provided — downloading session from Render env..."
  mkdir -p "$DEST_DIR"
  # download the zip (follow redirects)
  curl -L --fail "$SESSION_ZIP_URL" -o "$TMP_ZIP"
  echo "Downloaded session zip to $TMP_ZIP"
  # extract into the persistent disk
  unzip -o "$TMP_ZIP" -d "$DEST_DIR"
  echo "Extracted RubySessions into $DEST_DIR"
  # optional: remove the tmp zip
  rm -f "$TMP_ZIP"
else
  echo "No SESSION_ZIP_URL env var found — skipping session download."
fi

# Start the bot
echo "Starting bot with: $BOT_START_CMD"
exec $BOT_START_CMD