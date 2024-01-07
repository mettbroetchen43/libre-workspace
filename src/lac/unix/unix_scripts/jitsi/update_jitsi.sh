cd /root/jitsi

# Ensure that in the .env file the variable "JITSI_IMAGE_VERSION" is set to "stable"
# Delete the line with "JITSI_IMAGE_VERSION=latest"
sed -i "/JITSI_IMAGE_VERSION/d" .env
# Add the line "JITSI_IMAGE_VERSION=stable"
echo "JITSI_IMAGE_VERSION=stable" >> .env

# Update Rocket.Chat
docker-compose pull
docker-compose up -d