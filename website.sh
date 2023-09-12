#!/bin/bash

# Install Apache2
sudo apt-get update
sudo apt-get install apache2 -y

# Enable SSL module and restart Apache
sudo a2enmod ssl
sudo service apache2 restart

# Create SSL certificate and key files
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Configure SSL VirtualHost
sudo tee /etc/apache2/sites-available/default-ssl.conf > /dev/null <<EOF
<IfModule mod_ssl.c>
  <VirtualHost _default_:443>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/html/>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
    </Directory>

  </VirtualHost>
</IfModule>
EOF

sudo rm /var/www/html/index.html

sudo git clone https://github.com/Y3llowm4n/website_pop_template /var/www/html/

cd /var/www/html/

sudo mv /var/www/html/website_pop_template/* /var/www/html

sudo rm -r website_pop_template

# Enable SSL VirtualHost
sudo a2ensite default-ssl.conf

# Restart Apache
sudo service apache2 restart