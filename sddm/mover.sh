#!/bin/bash

#mover los temas a la carpeta de sddm
sudo cp -r ~/Bully-ye/sddm/pixel-coffee /usr/share/sddm/themes/

#configurar sddm
sudo cp ~/Bully-ye/sddm/sddm.conf /etc/sddm.conf

#reiniciar sddm
sudo systemctl restart sddm