#!/bin/bash

# Create the .devcontainer directory if it doesn't already exist
mkdir -p .devcontainer

# Write the devcontainer.json configuration file
cat <<EOL > .devcontainer/devcontainer.json
{
    "name": "My Codespace",
    "image": "mcr.microsoft.com/vscode/devcontainers/python:3.8",
    "features": {
        "ghcr.io/devcontainers/features/sshd:1": {
            "version": "latest"
        }
    },
    "postStartCommand": "python3 /workspaces/VENOM-V2/hr.py 7393913417:AAG-OoAqtvbvOEAisFAFl1JoQ79P_Kl87vY",
    "customizations": {
        "vscode": {
            "settings": {
                "python.pythonPath": "/usr/local/bin/python"
            },
            "extensions": [
                "ms-python.python"
            ]
        }
    }
}
EOL

# Add the new configuration file to git
git add .devcontainer/devcontainer.json

# Commit the changes with a simplified message
git commit -m "Add postStartCommand to run Python script automatically"

# Push the changes to the main branch
git push origin main

# Run the postStartCommand every 200 seconds
while true; do
    echo "Running postStartCommand..."
    if ! python3 /workspaces/VENOM-V2/hr.py; then
        echo "Script failed. Restarting in 10 seconds..."
        sleep 10
    fi
    sleep 200
done
