echo "Installing Magento .."
cd /var/www/html && composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition .

echo "Setting permissions .."
# post installing Magento set the file permissions
sudo find . -type f -exec chmod 644 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo find ./var -type d -exec chmod 777 {} \;
sudo find ./pub/media -type d -exec chmod 777 {} \;
sudo find ./pub/static -type d -exec chmod 777 {} \;
sudo chmod 777 ./app/etc
sudo chmod 644 ./app/etc/*.xml
sudo chown -R :<web server group> .
sudo chmod u+x bin/magento
