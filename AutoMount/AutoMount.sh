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
                        mkdir /root$(echo "$i" | cut -c 5-)
mkfs.ext4 "$i""1" << EOF
                        y
EOF
DIRNAME=/root$(echo "$i" | cut -c 5-)
                        if      [ $(cat /etc/fstab | grep $i ) -z ] ; then
                                mount "$i""1" $DIRNAME
                                echo "$i""1   $DIRNAME   ext4 defaults 0 0" >> /etc/fstab
                        fi
                done ;;

        *) echo "No parameter" ;;

esac

