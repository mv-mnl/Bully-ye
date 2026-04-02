#!/bin/bash

#sddm
sudo cp ~/Bully-ye/sddm/sddm.conf /etc/sddm.conf
sudo systemctl restart sddm

#plymouth
sudo cp -r ~/Bully-ye/plymouth/* /usr/share/plymouth/themes/spinner/
sudo plymouth-set-default-theme -R spinner