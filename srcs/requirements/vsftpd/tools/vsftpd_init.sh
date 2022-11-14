if [ ! -f "/etc/vsftpd.userlist" ]; then

	mkdir -p /var/run/vsftpd/sec_dir
	mkdir -p /home/dpaccagn

	mv /var/www/vsftpd.conf /etc/vsftpd.conf

	adduser -D $FTP_USER --disabled-password
	echo $FTP_USER > /etc/vsftpd.userlist
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
	chown -R $FTP_USER:$FTP_USER /home/dpaccagn

fi

/usr/sbin/vsftpd /etc/vsftpd.conf
