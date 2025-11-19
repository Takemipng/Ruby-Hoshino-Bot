#!/usr/bin/env bash
set -e

echo "Downloading WhatsApp session…"

curl -L "$SESSION_URL" -o RubySessions.zip

unzip -o RubySessions.zip -d RubySessions

rm RubySessions.zip

echo "Starting bot with npm start…"

npm start
