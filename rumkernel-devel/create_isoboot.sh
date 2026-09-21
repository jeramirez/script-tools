for ossufix in "alma" "rocky"; do

if [[ -d isoboot_source_$ossufix ]]; then
xorriso -as mkisofs \
  -V "Rumrocks-9-8-x86_64-dvd" \
  -o Rumrocks-${ossufix}-9.8-x86_64-boot.iso \
  -J -joliet-long -r \
  -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -eltorito-alt-boot \
  -e images/efiboot.img -no-emul-boot \
  isoboot_source_$ossufix/

fi
done
