dirimg=isoboot_source
isolinux=isolinux/isolinux.cfg
grub=EFI/BOOT/grub.cfg

ossufix=alma
if [[ -d isoboot_source_$ossufix ]]; then
#custmize isolinux.cfg
  echo sed -i -e "s@an AlmaLinux@a AlmaLinux@" ${dirimg}_${ossufix}/${isolinux}
  echo sed -i -e "s@AlmaLinux@Rumrocks@" ${dirimg}_${ossufix}/${isolinux}
  sed -i -e "s@an AlmaLinux@a AlmaLinux@" ${dirimg}_${ossufix}/${isolinux}
  sed -i -e "s@AlmaLinux@Rumrocks@" ${dirimg}_${ossufix}/${isolinux}

#customize grub.cfg
  echo sed -i -e "s@an AlmaLinux@a AlmaLinux@" ${dirimg}_${ossufix}/${grub}
  echo sed -i -e "s@AlmaLinux@Rumrocks@" ${dirimg}_${ossufix}/${grub}
  echo sed -i -e "s@timeout=60@timeout=5@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@an AlmaLinux@a AlmaLinux@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@AlmaLinux@Rumrocks@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@timeout=60@timeout=5@" ${dirimg}_${ossufix}/${grub}

fi



ossufix=rocky
if [[ -d isoboot_source_$ossufix ]]; then
#custmize isolinux.cfg
  echo sed -i -e "s@Rocky Linux@Rocky@" ${dirimg}_${ossufix}/${isolinux}
  echo sed -i -e "s@Rocky@Rumrocks@" ${dirimg}_${ossufix}/${isolinux}
  echo sed -i -e "s@timeout=60@timeout=5@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@Rocky Linux@Rocky@" ${dirimg}_${ossufix}/${isolinux}
  sed -i -e "s@Rocky@Rumrocks@" ${dirimg}_${ossufix}/${isolinux}
  sed -i -e "s@timeout=60@timeout=5@" ${dirimg}_${ossufix}/${grub}

#customize grub.cfg
  echo sed -i -e "s@Rocky Linux@Rocky@" ${dirimg}_${ossufix}/${grub}
  echo sed -i -e "s@Rocky@Rumrocks@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@Rocky Linux@Rocky@" ${dirimg}_${ossufix}/${grub}
  sed -i -e "s@Rocky@Rumrocks@" ${dirimg}_${ossufix}/${grub}

fi

