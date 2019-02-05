# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Prerequisiti

 S.O.    Centos/Redhat 7

    apache httpd  (versione fornita dalla ditro installata)

    rbenv
    ruby 2.3.1p112
    rails 5.0.0.1


* Deployment instructions

 1) installare alcuni prerequisiti da root
su Centos/Redhat 7

    yum install httpd
    yum install httpd-devel
    yum install readline-devel

    systemctl start httpd
    systemctl enable httpd

2) creare l'utente dell'applicazione rails

    adduser sgrcmwapp
    
2.1) su Centos/Redhat 7
    chmod 755 /home/sgrcmapi/

3) impostare i dati del proxy e importare il suo richiamo nei file iniziali di configurazione dello user <rails_app>

    su - sgrcmwapp
    vim .my_set


        ################################### PROXY ###################################
        PROXY_SERVER=xxx.xxx.xxx.xxx
        PROXY_PORT=8080
        PROXY_USERNAME=user
        PROXY_PASSWORD=password
        PROXY=$PROXY_USERNAME:$PROXY_PASSWORD@$PROXY_SERVER:$PROXY_PORT
        # HTTP and HTTPS
        export http_proxy=http://$PROXY
        export HTTP_PROXY=http://$PROXY
        export https_proxy=http://$PROXY
        export HTTPS_PROXY=http://$PROXY
        # RSYNC
        export rsync_proxy=$PROXY
        export RSYNC_PROXY=$PROXY
        ##############################################################################

3.1) su Centos/Redhat 7

    vim .bash_profile
         export LANG=it_IT.utf8
         . ~/.my_set

4) con user sgrcmwapp installare rbenv

uscire con exit e rientrare con l'utente sgrcmwapp

    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

5) configurare il proprio profilo

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.my_set
    echo 'eval "$(rbenv init -)"' >> ~/.my_set

6) restart del terminale e installazione ruby

uscire con exit e rientrare con l'utente sgrcmwapp

su - sgrcmwapp

verifica il comando digitando

    type rbenv

(deve essere riconosciuto come una funzione)

    rbenv install -l

(elenca tutte le versioni disponibili)

    rbenv install 2.3.1

(installa una versione)

    rbenv global 2.3.1

(imposta una versione globalmente)

    rbenv local 2.3.1

(imposta una versione localmente)

    rbenv rehash

7) restart del terminale e installazione di rails sempre con user sgrcmwapp

    ruby -v
    gem update
    gem install rails

8) sgrcmwapp

    git clone http://ITGIT01.it.lispadev.local/ALM/SGR_CM-WAPOL.git
    cd SGR_CM-WAPOL
    bundle install
    bundle exec rake tmp:clear
    bundle exec rake assets:clean
    RAILS_ENV=production bundle exec rake assets:precompile RAILS_RELATIVE_URL_ROOT=/
    
9) Apache + Phusion/Passenger su Centos/Redhat 7
    istruzioni seguite da: https://www.phusionpassenger.com/library/install/apache/yum_repo/
    
    login con user root
    
    yum install -y openssl-devel zlib-devel
    yum install sqlite-devel
    yum install -y epel-release yum-utils
    yum-config-manager --enable epel
    yum install -y pygpgme curl
    curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
    yum install -y mod_passenger
    yum install passenger-devel-5.0.30
    systemctl restart httpd
    
    /usr/bin/passenger-config validate-install
    /usr/sbin/passenger-memory-stats
    yum update
    
10) config Apache httpd su Centos/Redhat 7

in /etc/httpd/conf.d/passenger.conf

### Begin automatically installed Phusion Passenger config snippet ###
<IfModule mod_passenger.c>
    PassengerRoot /usr/share/ruby/vendor_ruby/phusion_passenger/locations.ini
    PassengerRuby /home/sgrcmwapp/.rbenv/versions/2.3.1/bin/ruby
    PassengerInstanceRegistryDir /var/run/passenger-instreg
</IfModule>
### End automatically installed Phusion Passenger config snippet ###

<VirtualHost *:80>
    ServerName sgrcmwapol.lispadev.local
    ServerAdmin webmaster@lispa.it
    DocumentRoot /home/sgrcmwapp/SGR_CM-WAPOL/public
    
    <Directory /home/sgrcmwapp/SGR_CM-WAPOL/public>
        AllowOverride all
        Options -MultiViews
        Require all granted
    </Directory>
</VirtualHost>

11) impostare la secret_key per la produzione

    login con utente sgrcmwapp
    
    cd SGR_CM-WAPOL
    RAILS_ENV=production rake secret
    
    viene stampata a video la nuova key
    sul server apache bisogna impostarla come variabile di environment
    
    su Centos/Redhat 7
    
    login con utente root
    vim /etc/sysconfig/httpd
    
    es.: SECRET_KEY_BASE=20ddb36583e3282bb9bb18ce271835724c158cbddbfbd8922a6e6a6b2b2aafc0604eef7a3597a02406755a03e490686445aa553ed0d94d16e741f070d82a5961
    <rails_app>_DATABASE_PASSWORD=<rails_app>

12) riavviare apache2 su Centos/Redhat 7

    chcon -R --type=httpd_sys_rw_content_t /home/sgrcmwapp/SGR_CM-WAPOL/public/
    systemctl restart httpd

13) configurazione dell'applicazione: impostare il puntamento al server (backend.url) che espone le API polarion. In fase di test puntare direttamente, successivamente puntare all'API manager.

    login con utente sgrcmwapp
    
    cd SGR_CM-WAPOL/config
    vim  frontend.yml
    
    default: &default
      backend.url: http://cmpolwappbe01/
      token.header: X-polapp-token
      ...


14) Rimuovere le impostazioni del proxy togliendo il suo richiamo nei file iniziali di configurazione dello user <root> .

15) riavviare apache2 su Centos/Redhat 7

    chcon -R --type=httpd_sys_rw_content_t /home/sgrcmwapp/SGR_CM-WAPOL/public/
    systemctl restart httpd
    
    
