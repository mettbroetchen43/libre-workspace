sudo mkdir -p /var/www/linux-arbeitsplatz-static/
sudo chmod -R 777 /var/www/linux-arbeitsplatz-static/

if [ ! -d "/usr/share/linux-arbeitsplatz" ]; then
    cd src/lac/
else 
    cd /usr/share/linux-arbeitsplatz/
fi

if [ ! -f "cfg" ]; then
    cp cfg.example cfg
fi

python3 -m venv .env

ln -s /usr/bin/python3 /usr/bin/python

source .env/bin/activate
pip install django python-ldap django-auth-ldap gunicorn
python manage.py migrate --no-input

# Get the current IP-Adress
# Get the output of hostname -I and cut the first part of it
IP=`hostname -I | cut -d' ' -f1`

echo ":443 {
    tls internal {
        on_demand
    }
    handle_path /static* {
        root * /var/www/linux-arbeitsplatz-static
        file_server
        encode zstd gzip
    }
    reverse_proxy localhost:11123
}

" >> /etc/caddy/Caddyfile