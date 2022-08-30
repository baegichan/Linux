#!/bin/bash



DISKLIST=$(fdisk -l | grep Disk | grep -v sda  | grep sd | awk '{ print $2 }' | tr -d ':')
case  $# in
        0)
                for i in $DISKLIST ;
                do
fdisk $i <<END
                        n
                        p





                        w
                        q
END
                        mkdir /root$(echo "$i" | cut -c 5-) >/dev/null 2>&1
                        mkfs.ext4 "$i""1" << EOF >/dev/null 2>&1
                        y
EOF
DIRNAME=/root$(echo "$i" | cut -c 5-)
                        if  [$(cat /etc/fstab | grep $i ) == ""]>/dev/null 2>&1 ; then
                                mount "$i""1" $DIRNAME
                                echo "$i""1   $DIRNAME   ext4 defaults 0 0" >> /etc/fstab
                        fi
        echo "[ OK ] $i done"
                done ;;
        *) echo "No parameter" ;;

esac
