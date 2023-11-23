# You need to run this script as root.
# DOMAIN
# ADMIN_PASSWORD
# IP

mkdir /root/rocket.chat
cp docker_rocketchat_entry.txt /root/rocket.chat/docker-compose.yml
sed -i "s/SED_DOMAIN/$DOMAIN/g" /root/rocket.chat/docker-compose.yml
sed -i "s/SED_PASSWORD/$ADMIN_PASSWORD/g" /root/rocket.chat/docker-compose.yml

cd /root/rocket.chat
docker-compose up -d
cd -

# Add the content of caddy_rocketchat_entry.txt to /etc/caddy/Caddyfile
cat caddy_rocketchat_entry.txt >> /etc/caddy/Caddyfile
sed -i "s/SED_DOMAIN/$DOMAIN/g" /etc/caddy/Caddyfile
if [ $DOMAIN = "int.de" ] ; then
  sed -i "s/#tls internal/tls internal/g" /etc/caddy/Caddyfile
fi