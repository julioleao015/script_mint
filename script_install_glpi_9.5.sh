#!/bin/bash

#Declaracao da Funcao do Menu!
function installGlpi {

clear
echo '####################################'
echo '                                    '
echo '        Instalação GLPI 9.5         '
echo '                                    '
echo '####################################'
sleep 2

echo ""
echo 'Loading.'
sleep 1.5
clear
echo 'Loading..'
sleep 1.5
clear
echo 'Loading...'
sleep 2
clear

echo ""
echo "1. ATUALIZANDO LISTA DE PACOTES"
apt update -y
sleep 2

echo ""
echo "2. REMOVENDO PACOTES NTP"
apt purge ntp
sleep 2

echo ""
echo "3. INSTALAÇÃO PACOTES OpenNTPD"
apt install -y openntpd
sleep 2

echo ""
echo "4. PARANDO SERVIÇO OpenNTPD"
service openntpd stop
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "5. CONFIGURAÇÃO TIMEZONE PADRÃO DO SERVIDOR"
sleep 2
dpkg-reconfigure tzdata
sleep 2

clear
echo ""
echo "6. ADICIONANDO SERVIDOR NTP.BR"
echo "servers pool.ntp.br" > /etc/openntpd/ntpd.conf
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "7. HABILITAR E INICIAR SERVIÇO OpenNTPD"
systemctl enable openntpd
systemctl start openntpd
sleep 2 

echo ""
echo "8. PACOTES MANIPULAÇÃO DE ARQUIVOS"
apt install -y xz-utils bsdtar bzip2 unzip curl
sleep 2

clear
echo ""
echo "9. INSTALAÇÃO SERVIDOR WEB (APACHE)"
sleep 2
apt install -y apache2 libapache2-mod-php7.3 php-soap php-cas php7.3 php7.3-{apcu,cli,common,curl,gd,imap,ldap,mysql,xmlrpc,xml,mbstring,bcmath,intl,zip,bz2}
apt install php-curl php-fileinfo php-gd php-json php-mbstring php-mysqli php-session php-zlib php-simplexml php-xml php-opcache php-pear-CAS
apt install php-cli php-domxml php-imap php-ldap php-openssl php-xmlrpc php-apcu
sleep 2

clear
echo ""
echo "RESOLVENDO PROBLEMA DE ACESSO WEB AO DIRETÓRIO"
sleep 2
echo ""
echo "10. CRIAR ARQUIVO COM CONTEÚDO"
echo -e "<Directory \"/var/www/html/glpi\">\nAllowOverride All\n</Directory>" > /etc/apache2/conf-available/glpi.conf
echo "CONCLUÍDO COM ÊXITO!"
sleep 1

echo ""
echo "11. HABILITA A CONFIGURAÇÃO CRIADA"
a2enconf glpi.conf
sleep 2

echo ""
echo "12. REINICIANDO SERVIDOR APACHE PARA A NOVA CONSIDERAÇÃO"
systemctl restart apache2
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

clear
echo ""
echo "13. BAIXANDO E INSTALANDO O GLPI 9.5"
sleep 2
wget -O- https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz | tar -zxv -C /var/www/html/
sleep 2

clear
echo ""
echo "14. AJUSTANDO PERMISSÕES DE ARQUIVOS"
echo "AGUARDE UM MOMENTO..."
chown www-data. /var/www/html/glpi -Rf
find /var/www/html/glpi -type d -exec chmod 755 {} \;
find /var/www/html/glpi -type f -exec chmod 644 {} \;
echo ""
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

clear
echo ""
echo "15. INSTALANDO O SERVIÇO MySQL"
apt install -y mariadb-server
sleep 2

echo ""
echo "16. CRIANDO BASE DE DADOS"
mysql -e "create database glpidb character set utf8"
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "17. CRIANDO USUÁRIO DO BANCO"
echo "Digite o nome de usuário do banco que você deseja criar: "
read user_db
echo ""
echo "Digite a senha desse usuário para cadastro: "
read passwd_db
echo ""
mysql -e "create user '$user_db'@'localhost' identified by '$passwd_db'"
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "18. DANDO PRIVILÉGIOS AO USUÁRIO"
mysql -e "grant all privileges on glpidb.* to '$user_db'@'localhost' with grant option";
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "19. HABILITANDO SUPORTE AO TIMEZONE NO MySQL/MariaDB"
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -p -u root mysql
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "20. HABILITANDO SUPORTE AO TIMEZONE NO MySQL/MariaDB"
mysql -e "GRANT SELECT ON mysql.time_zone_name TO '$user_db'@'localhost';"
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

echo ""
echo "21. FORÇANDO APLICAÇÃO DE PRIVILÉGIOS"
mysql -e "FLUSH PRIVILEGES;"
echo "CONCLUÍDO COM ÊXITO!"
sleep 2

clear
echo ""
echo "TUDO PRONTO, AGORA VOCÊ JÁ PODE ACESSAR O GLPI VIA NAVEGADOR E CONTINUAR SUA INSTALAÇÃO PELA INTERFACE WEB."
sleep 4
echo ""
echo "PARA ACESSAR A INTERFACE WEB DO GLPI, DIGITE: ip-do-servidor/glpi NA BARRA DE PESQUISA DO SEU NAVEGADOR."
echo ""
sleep 4
echo ""
echo "COMPARTILHE ESSE SCRIPT PARA AJUDAR OS OUTROS, FAÇAM BOM USO DELE."
echo "ATÉ LOGO!"
echo ""
echo "CONTATO:"
echo "- Nome Desenvolvedor: Júlio Leão"
echo "- E-mail: julioleao015@gmail.com"
echo "- GitHub: github.com/julioleao015"

}


# Chamada da Funcao de Instalacao
installGlpi